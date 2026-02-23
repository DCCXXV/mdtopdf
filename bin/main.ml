let valid_extension filename =
	String.ends_with ~suffix:".md" filename ||
	String.ends_with ~suffix:".markdown" filename

let index_handler _req =
	"" |> Template.render |> Dream.html

let convert_handler req =
	match%lwt Dream.multipart ~csrf:false req with
	| `Ok [ ("file", [ (Some filename, content) ]) ] ->
		if not (valid_extension filename) then
			Dream.redirect req "/?error=Only+.md+and+.markdown+files+are+accepted"
		else
			let tmp_md = Filename.temp_file "mdtopdf" ".md" in
			let tmp_pdf = Filename.temp_file "mdtopdf" ".pdf" in
			let oc = open_out tmp_md in
				output_string oc content;
			close_out oc;
			let%lwt status =
				Lwt_process.exec
					("pandoc", [|
						"pandoc"; tmp_md;
						"--pdf-engine=weasyprint";
						"--css=" ^ Sys.getcwd () ^ "/static/css/pdf.css";
						"-o"; tmp_pdf
					|])
			in
			Sys.remove tmp_md;
			(match status with
			| Unix.WEXITED 0 ->
				let%lwt pdf = Lwt_io.(with_file ~mode:Input tmp_pdf read) in
				Sys.remove tmp_pdf;
				Dream.respond ~headers:[
					"Content-Type", "application/pdf";
					"Content-Disposition", "attachment; filename=\"output.pdf\"";
				]
				pdf
			| _ ->
				(try Sys.remove tmp_pdf with _ -> ());
				Dream.redirect req "/?error=Conversion+failed")
	| _ ->
		Dream.redirect req "/?error=Bad+request"

let () =
	Dream.run
	@@ Dream.logger
	@@ Dream.router [
		Dream.get "/static/**" (Dream.static "static");
		Dream.get "/" index_handler;
		Dream.post "/convert" convert_handler;
	]

let index_handler _req =
	"" |> Template.render |> Dream.html

let convert_handler req =
	match%lwt Dream.multipart ~csrf:false req with
	| `Ok [ ("file", [ (_, content) ]) ] ->
		let tmp_md = Filename.temp_file "mdtopdf" ".md" in
		let tmp_pdf = Filename.temp_file "mdtopdf" ".pdf" in
		let oc = open_out tmp_md in
			output_string oc content;
		close_out oc;
		let%lwt _ =
			Lwt_process.exec
				("pandoc", [|
					"pandoc"; tmp_md;
					"--pdf-engine=weasyprint";
					"--css=" ^ Sys.getcwd () ^ "/css/pdf.css";
					"-o"; tmp_pdf
				|])
		in
		let%lwt pdf = Lwt_io.(with_file ~mode:Input tmp_pdf read) in
		Sys.remove tmp_md;
		Sys.remove tmp_pdf;
		Dream.respond ~headers:[
			"Content-Type", "application/pdf";
			"Content-Disposition", "attachment; filename=\"output.pdf\"";
		]
		pdf
	| _ ->
		Dream.respond ~status: `Bad_Request "error"

let () =
  Dream.run
  @@ Dream.logger
  @@ Dream.router [
    Dream.get "/css/**" (Dream.static "css");
    Dream.get "/" index_handler;
    Dream.post "/convert" convert_handler;
  ]

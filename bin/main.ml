let () =
  Dream.run
  @@ Dream.logger
  @@ Dream.router [
    Dream.get "/css/**" (Dream.static "css");
    Dream.get "/"
      (fun _ ->
        "" |> Template.render
        |> Dream.html);
  ]

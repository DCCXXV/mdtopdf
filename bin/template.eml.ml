let render _ =
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="color-scheme" content="dark" />
<link rel="stylesheet" href="css/style.css" />
    <title>MDtoPDF</title>
  </head>
  <body>
    <header>
      <h1>
        <span class="a">MDtoPDF</span><span class="secondary">.DCCXXV.DEV</span>
      </h1>
    </header>
    <main>
      <form method="post" action="/convert" enctype="multipart/form-data">
        <label id="drop-zone" for="file-input"
          >drop a file, click to browse or paste your markdown</label
        >
        <input id="file-input" name="file" type="file" />
        <input type="submit" value="Get PDF" />
      </form>
    </main>
    <script>
      const zone = document.getElementById("drop-zone");
      const input = document.getElementById("file-input");

      zone.addEventListener("dragover", (e) => {
        e.preventDefault();
        zone.classList.add("drag-over");
      });

      zone.addEventListener("dragleave", () => {
        zone.classList.remove("drag-over");
      });

      zone.addEventListener("drop", (e) => {
        e.preventDefault();
        zone.classList.remove("drag-over");
        const file = e.dataTransfer.files[0];
        if (file) {
          const dt = new DataTransfer();
          dt.items.add(file);
          input.files = dt.files;
          zone.textContent = file.name;
        }
      });

      input.addEventListener("change", () => {
        if (input.files[0]) zone.textContent = input.files[0].name;
      });
    </script>
  </body>
</html>

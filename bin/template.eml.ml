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
      <form>
        <label for="file-input"
          >drop a file, click to browse or paste your markdown</label
        >
        <input id="file-input" type="file" />
        <input type="submit" value="Get PDF" />
      </form>
    </main>
  </body>
</html>

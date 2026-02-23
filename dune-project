(lang dune 3.20)

(name mdtopdf)

(generate_opam_files true)

(source
 (github DCCXXV/mdtopdf))

(authors "Marco Antonio Pérez Neira <marcoantonioperezneira@gmail.com>")

(maintainers "Maintainer Marco Antonio Pérez Neira <marcoantonioperezneira@gmail.com>")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name mdtopdf)
 (synopsis "Small webapp to convert markdown files to pdfs")
 (description "Small webapp to convert markdown files to pdfs")
 (depends ocaml dream)
 (tags
  ("web" "pdf" "markdown" "pandoc")))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html

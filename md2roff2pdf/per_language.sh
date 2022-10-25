#!/usr/bin/bash

# name:    pdf_per_language.sh
# author:  nbehrnd@yahoo.com
# license: GPL v2
# date:    [2022-10-25 Tue]
# edit:

# Generation of individual .pdf per language with pandoc and roff ms.
#
# Beside pdfLaTeX, John McFarlane's pandoc offers to use roff ms as pdf engine.
# + According to Linux Debian's synaptic package manager, compared to pdfLaTeX,
#   groff/the GNU troff text-formatting system is a light-weight installation of
#   less than 15 MB.
# + Because groff is the umbrella for programs for edit/display/conversion of
#   Linux man pages (here: pdfroff), possibly most instances of Linux either 
#   include this program suite by default, or offer an easy installation.
# + The .pdf generated are small, include a searchable text layer, and require
#   only one one run of compilation to be generated.
# + Altogether with pandoc, for 148 languages/dialects there is at least partial
#   coverage to enable syntax highlighting (`pandoc --list-highlight-languages`,
#   which includes awk, fortranfixed, fortranfree, latex, markdown, python). 
# + The .pdf written may include functional hyperlinks to other (web)documents.
# + Contrasting to e.g., (https://github.com/aviaryan/learnxinyminutes-pdf), the
#   documentation can include Markdown and LaTeX.
#
# Subject to revision:
# + Though individual .pdf may be concatenated (e.g., pdftk), building «a book»
#   on the level of individual markdown files (similar to \include{} in LaTeX)
#   would be advantageous.
# + Comparison of the scope of languages of learnxinyminutes vs. the coverage
#   provided by pandoc's syntax highlighting.
# + In part in hand with the above, adjusting the format (e.g., ISO A4 paper,
#   a headline reporting the language currently on display, a stamp reporting
#   the date of the last revision on learnxinyminutes).
# + 
# 
# This is a concept study to check the reliability of the wanted .pdf generation
# (without pdfLaTeX, or ConTeXt, or wkhtmlpdf Pandoc's manual equally mention as
# a pdf engine).
# 
# Intended use in Linux Debian 12/bookworm (branch testing), bash (5.2.0(1)-rc2
# (x86_64-pc-linux-gnu, 2022),and pandoc 2.19.2 ([2022-08-22 Mon]):
#
# + provision of the executable bit (chmod)
# `./pdf_per_language.sh` in the folder containing the markdown files

# generation of the .pdf:
for file in *.markdown;
do
  base=$(basename "$file");
  language=${base//\.html\.markdown/};
  echo 'work on file' "$file";

  pandoc -Tpdf -t ms "$file" -o "$language".pdf;
done

# space cleaning:
mkdir pdfs
mv *.pdf ./pdfs

MGL Report Quarto extension

This is a set of files that allow you to render a markdown into a PDF
formatted as a standard "MGL Report."

Install this format into your repo with the following in your terminal:

```bash
quarto add marinegenomicslab/mgl_quarto_report_format
```

This will then prompt you to install the extension and will copy
\_extensions into your working directory.

Use the format by having a yaml like this at the top of your quarto doc that you intend to render as a report:

---
title: "Test Report"
author:
  - "Joe Matt"
date: today

client-block: |
  Report for VIMS

  Commercial Shellfish

  Aquaculture Lab \& Team

format:
  mgl-report-pdf: default
---

If any of the blocks are missing (e.g., client-block) the title page
will be incomplete.

Note:

-   Blank lines create line breaks on the title page

-   Escape special LaTeX characters such as & using \&


References and citations (optional)

A bibliography file is only required if you use citations.

If your report includes citations such as [@smith2020], add a
bibliography file in the YAML front matter of your quarto:

bibliography: references.bib

If no citations are used, do not include a bibliography entry.



Optional: matching ggplot fonts to the report

This extension includes an optional helper function to make ggplot
figures use the same font family as the PDF report (TeX Gyre Termes).

This feature is opt-in and is not applied automatically.

Enable globally (recommended)

At the top of your report:

source("\_extensions/mgl-report/mgl_plot_theme.R")
mgl_setup_plot_fonts()

This:

-   registers the font (if available)

-   enables showtext

-   sets a global ggplot theme matching the report

If you do not want to change the global ggplot theme:

source("\_extensions/mgl-report/mgl_plot_theme.R") mgl_theme \<-
mgl_setup_plot_fonts(set_global_theme = FALSE)

p + mgl_theme

Notes

Some ggplot themes (e.g. theme_minimal()) override font settings Apply
mgl_theme after other themes if needed.

Font paths are system-dependent; the function attempts a safe fallback
if the TeX font files are not found.

Send any complaints to Dominic Swift at dominic.swift@tamucc.edu
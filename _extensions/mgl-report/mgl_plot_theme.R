mgl_setup_plot_fonts <- function(
    family = "Termes",
    base_size = 12,
    # default paths for common TeX Live installs (Linux)
    regular = "/usr/share/texmf/fonts/opentype/public/tex-gyre/texgyretermes-regular.otf",
    bold = "/usr/share/texmf/fonts/opentype/public/tex-gyre/texgyretermes-bold.otf",
    italic = "/usr/share/texmf/fonts/opentype/public/tex-gyre/texgyretermes-italic.otf",
    bolditalic = "/usr/share/texmf/fonts/opentype/public/tex-gyre/texgyretermes-bolditalic.otf",
    set_global_theme = TRUE,
    verbose = TRUE
) {
  # lightweight dependency checks
  if (!requireNamespace("sysfonts", quietly = TRUE)) {
    stop("Package 'sysfonts' is required. Install with install.packages('sysfonts').")
  }
  if (!requireNamespace("showtext", quietly = TRUE)) {
    stop("Package 'showtext' is required. Install with install.packages('showtext').")
  }
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Package 'ggplot2' is required. Install with install.packages('ggplot2').")
  }
  
  paths <- c(regular, bold, italic, bolditalic)
  missing <- paths[!file.exists(paths)]
  
  if (length(missing) > 0) {
    msg <- paste(
      "Could not find one or more font files needed for TeX Gyre Termes:\n",
      paste(" -", missing, collapse = "\n"),
      "\n\nFalling back to system font lookup by name (may still work if installed).",
      sep = ""
    )
    if (verbose) message(msg)
    
    # Try system font by name (works on many systems if font is installed)
    try(sysfonts::font_add(family = family, regular = "TeX Gyre Termes"), silent = TRUE)
  } else {
    sysfonts::font_add(
      family = family,
      regular = regular,
      bold = bold,
      italic = italic,
      bolditalic = bolditalic
    )
  }
  
  showtext::showtext_auto(enable = TRUE)
  
  # A reusable theme object (users can add it to individual plots if they prefer)
  mgl_theme <- ggplot2::theme_classic(base_family = family, base_size = base_size) +
    ggplot2::theme(
      plot.title = ggplot2::element_text(family = family),
      plot.subtitle = ggplot2::element_text(family = family),
      plot.caption = ggplot2::element_text(family = family),
      
      axis.title.x = ggplot2::element_text(family = family),
      axis.title.y = ggplot2::element_text(family = family),
      axis.text.x  = ggplot2::element_text(family = family),
      axis.text.y  = ggplot2::element_text(family = family),
      
      legend.title = ggplot2::element_text(family = family),
      legend.text  = ggplot2::element_text(family = family),
      
      strip.text.x = ggplot2::element_text(family = family),
      strip.text.y = ggplot2::element_text(family = family),
      
      plot.tag = ggplot2::element_text(family = family)
    )
  
  if (isTRUE(set_global_theme)) {
    ggplot2::theme_set(mgl_theme)
  }
  
  # return theme invisibly so users can do: p + mgl_setup_plot_fonts(set_global_theme = FALSE)
  invisible(mgl_theme)
}

#' Screenshot helper
#'
#' @return none, called for side-effects
#' @examples
#' \dontrun{
#' screenshotr()
#' }
#' @export
#'
screenshotr <- function(){

  html_help <-
    system.file("markdown", "screenshotr_help.md", package = "screenshotr") %>%
    readr::read_file() %>%
    commonmark::markdown_html() %>%
    shiny::HTML()

  input_scale <-
    shiny::numericInput(
      inputId = "scale",
      label = "Image scale",
      value = 0.25,
      min = 0,
      max = Inf,
      step = 0.25,
      width = 150
    )

  input_save_action <-
    shiny::radioButtons(
      inputId = "save",
      label = "Post-save action",
      choices = c(
        "Copy relative-path to clipboard" = "copy",
        "Insert relative-path into source" = "insert",
        "None" = "none"
      )
    )

  input_path_anchor <-
    shiny::radioButtons(
      inputId = "path_anchor",
      label = "Directory anchor",
      choices = c(
        "Source document",
        "Project root"
      )
    )

  input_format <-
    shiny::radioButtons(
      inputId = "path_format",
      label = "Text format",
      choices = c(
        "Markdown image" = "markdown",
        "HTML src attribute" = "html",
        "As-is" = "as_is"
      )
    )

  input_paste <-
    shiny::actionButton(
      inputId = "paste",
      label = shiny::tags$span("Paste new"),
      class = "btn-primary"
    )

  input_save <-
    shiny::actionButton(
      inputId = "save",
      label = shiny::tags$span("Save as"),
      class = "btn-primary"
    )

  output_status <-
    shiny::verbatimTextOutput(
      outputId = "status",
      placeholder = TRUE
    )

  panel_controls <-
    miniUI::miniTabPanel(
      title = "Template",
      icon = shiny::icon("sliders"),
      miniUI::miniContentPanel(
        shiny::fillCol(
          flex = c(1, NA),
          shiny::fillRow(
            shiny::fillCol(
              input_scale,
              input_save_action
            ),
            shiny::fillCol(
              input_path_anchor,
              input_format
            )
          ),
          output_status
        )
      )
    )

  panel_image <-
    miniUI::miniTabPanel(
      title = "Image",
      icon = shiny::icon("photo"),
      miniUI::miniContentPanel(
        padding = 0,
        shiny::fillCol(
          flex = c(1, NA),
          shiny::imageOutput(outputId = "image", height = "100%"),
          miniUI::miniButtonBlock(
            input_paste,
            input_save
          )
        )
      )
    )

  panel_help <-
    miniUI::miniTabPanel(
      title = "Help",
      icon = shiny::icon("info-circle"),
      miniUI::miniContentPanel(
        html_help
      )
    )

  ui <- miniUI::miniPage(
    miniUI::gadgetTitleBar("Screenshot helper", right = NULL),
    miniUI::miniTabstripPanel(
      panel_image,
      panel_controls,
      panel_help
    )
  )

  server <- function(input, output, session){

    rct_text_path_format <- shiny::reactive({

      sample <- c(
        markdown = "![](img/sample.png)",
        html = "src = \"img/sample.png\"",
        as_is = "img/sample.png"
      )

      sample[input$path_format]

    })

    output$status <-
      shiny::renderText({
        paste(
          paste("Pasted image:", sep = "\t"),
          paste("Scaled image:", sep = "\t"),
          paste("Text format:", rct_text_path_format(), sep = "\t"),
          sep = "\n"
        )

      })
  }

  shiny::runGadget(ui, server, viewer = shiny::paneViewer(425))

}

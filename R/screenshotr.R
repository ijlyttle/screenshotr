screenshotr <- function(){

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
      inputId = "format",
      label = "Path format",
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

  output_original_image <-
    shiny::verbatimTextOutput(
      outputId = "original_image",
      placeholder = TRUE
    )

  output_scaled_image <-
    shiny::verbatimTextOutput(
      outputId = "scaled_image",
      placeholder = TRUE
    )

  output_path_format <-
    shiny::verbatimTextOutput(
      outputId = "path_format",
      placeholder = TRUE
    )

  panel_controls <-
    miniUI::miniTabPanel(
      title = "Controls",
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
          output_original_image
          # shiny::tags$hr(),
          # shiny::fillRow(
          #   flex = c(2, 5),
          #   shiny::tags$h5("Original image"),
          #   output_original_image
          # ),
          # shiny::fillRow(
          #   flex = c(2, 5),
          #   shiny::tags$h5("Scaled image"),
          #   output_scaled_image
          # ),
          # shiny::fillRow(
          #   flex = c(2, 5),
          #   shiny::tags$h5("Path format"),
          #   output_path_format
          # )
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
      icon = shiny::icon("info-circle")
    )

  ui <- miniUI::miniPage(
    gadgetTitleBar("Screenshot helper", right = NULL),
    miniUI::miniTabstripPanel(
      panel_image,
      panel_controls,
      panel_help
    )
  )

  server <- function(input, output, session){

  }

  shiny::runGadget(ui, server)

}

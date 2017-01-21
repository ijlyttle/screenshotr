screenshotr <- function(){

  input_scale <-
    shiny::numericInput(
      inputId = "scale",
      label = "Image scale",
      value = 0.25,
      min = 0,
      max = Inf,
      step = 0.25
    )

  input_save_action <-
    shiny::radioButtons(
      inputId = "save",
      label = "Action after Save",
      choices = c(
        "Copy text to clipboard",
        "Insert text into source",
        "None"
      )
    )

  input_path_anchor <-
    shiny::radioButtons(
      inputId = "path_anchor",
      label = "Path anchor",
      choices = c(
        "source document",
        "project root"
      )
    )

  input_format <-
    shiny::checkboxInput(
      inputId = "use_markdown",
      label = "Use markdown image"
    )


  input_paste <-
    shiny::actionButton(
      inputId = "paste",
      label = shiny::tags$span("Paste new")
    )

  input_save <-
    shiny::actionButton(
      inputId = "save",
      label = shiny::tags$span("Save")
    )

  panel_controls <-
    miniUI::miniTabPanel(
      title = "Controls",
      icon = shiny::icon("sliders"),
      miniUI::miniContentPanel(
        input_scale,
        input_save_action,
        input_path_anchor,
        input_format
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
          shiny::imageOutput(outputId = "image"),
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

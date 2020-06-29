#' load_data UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @importFrom data.table fread
#' @importFrom DT renderDataTable dataTableOutput
#' @importFrom dplyr filter
#' @importFrom rlang quo `!!` as_name
mod_load_data_ui <- function(id){
  ns <- NS(id)
  tagList(
    box(title = "Select dataset",
        radioButtons(ns("select_dataset"),
                    label = "Select dataset",
                    choices = c("Rescue points", "Radars"),
                    selected = c("Rescue points")),
        conditionalPanel(
          condition = paste0('input[\'', ns('select_dataset'), "\'] == \'Rescue points\'"),
          selectInput(ns("selector_place"), "Place",
                      choices = c("test"),
                      #choices = c(unique(output$dataset$place)),
                      selected = c("Luxembourg, Ville (G)"),
                      multiple = TRUE)),
        conditionalPanel(
          condition = paste0('input[\'', ns('select_dataset'), "\'] == \'Radars\'"),
          selectInput(ns("selector_radar"), "Radar",
                      choices = c("test"),
                      #choices = c("huhu"),
                      selected = c("National road"),
                      multiple = TRUE)),
        width = NULL),
  )
}

#' load_data Server Function
#'
#' @noRd 
mod_load_data_server <- function(input, output, session){
  ns <- session$ns
 
  
  read_dataset <- reactive({
    if(input$select_dataset == "Rescue points") {

      dataset <- fread("data-raw/rettungspunkte.csv")
      variable <- quo(place)
      filter_values <- unique(dataset[, place])
    } else {
      dataset <- fread("data-raw/radars.csv")
      variable <- quo(type_road)
      filter_values <- unique(dataset[, type_road])
    }
    cat("reading data\n")
    list(dataset = dataset,
         variable = variable,
         filter_values = filter_values)
  })


  observe({
    updateSelectInput(session, "selector_place", label = "Select place:", choices = read_dataset()$filter_values,
                      selected = "Luxembourg, Ville (G)")
  })

  observe({
    updateSelectInput(session, "selector_radar", label = "Select type of road:", choices = read_dataset()$filter_values,
                      selected = "National road")
  })

  result <- reactive({
    return_dataset <- read_dataset()$dataset

    if("place" %in% colnames(return_dataset)){
      return_dataset <- return_dataset %>%
        filter((!!read_dataset()$variable) %in% input$selector_place)

      result <- list(
        return_dataset = return_dataset,
        variable = quo(place)
      )
    } else {
      return_dataset <- return_dataset %>%
        filter((!!read_dataset()$variable) %in% input$selector_radar)

      result <- list(
        return_dataset = return_dataset,
        variable = quo(type_road)
      )
    }
  })

  result
}
    
## To be copied in the UI
# mod_load_data_ui("load_data_ui_1")
    
## To be copied in the server
# callModule(mod_load_data_server, "load_data_ui_1")
 

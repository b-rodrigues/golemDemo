#' filter_data UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_filter_data_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' filter_data Server Function
#'
#' @noRd 
mod_filter_data_server <- function(input, output, session){
  ns <- session$ns
 
}
    
## To be copied in the UI
# mod_filter_data_ui("filter_data_ui_1")
    
## To be copied in the server
# callModule(mod_filter_data_server, "filter_data_ui_1")
 

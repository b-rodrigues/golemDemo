#' table_data UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @importFrom DT datatable dataTableOutput renderDataTable
#' @importFrom dplyr select
mod_table_data_ui <- function(id){
  ns <- NS(id)
  tagList(
    box(title = "Tableau",
        DT::dataTableOutput(ns("dataset")),
        width = NULL)
  )
}
    
#' table_data Server Function
#'
#' @noRd 
mod_table_data_server <- function(input, output, session, result){
  ns <- session$ns

  output$dataset <- DT::renderDataTable({

    datatable(result()$return_dataset,
              options = list(
                paging = TRUE,
                pageLength = 10))
  })

}
    
## To be copied in the UI
# mod_table_data_ui("table_data_ui_1")
    
## To be copied in the server
# callModule(mod_table_data_server, "table_data_ui_1")
 

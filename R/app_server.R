#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # List the first level callModules here

  result <- callModule(mod_load_data_server, "load_data_ui_1")

  callModule(mod_table_data_server, "table_data_ui_1", result)
  

  selected_lines <- reactive({
    if(is.null(input$`table_data_ui_1-dataset_rows_selected`)){
      return(TRUE)
    } else {
      as.numeric(input$`table_data_ui_1-dataset_rows_selected`)
    }
  })

  callModule(mod_map_data_server, "map_data_ui_1", result, selected_lines)

}

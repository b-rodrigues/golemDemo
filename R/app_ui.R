#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinydashboard
#' @noRd
app_ui <- function(request) {
  tagList(
                                        # Leave this function for adding external resources
    golem_add_external_resources(),
                                        # List the first level UI elements here
    dashboardPage(
      dashboardHeader(title = "Prototype: dashboard ecoles"),
      dashboardSidebar(
        sidebarMenu(
          menuItem("Carte", tabName = "Carte", icon = icon("map")),
          menuItem("Tab 2", tabName = "tab_2", icon = icon("chart-line"))
        )
      ),
      dashboardBody(
        tabItems(
          tabItem(tabName = "Carte",
                  fluidRow(
                    column(
                      width = 4,
                      mod_load_data_ui("load_data_ui_1"),
                      mod_table_data_ui("table_data_ui_1")
                    ),
                    column(
                      width = 6, offset = 2,
                      mod_map_data_ui("map_data_ui_1")
                    )
                  ))
        )
      )
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'golemDemo'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}


#' map_data UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @importFrom ggiraph girafeOutput renderGirafe girafe geom_polygon_interactive geom_point_interactive opts_hover girafe_options opts_tooltip opts_zoom
#' @importFrom ggplot2 ggplot aes theme theme_void ggtitle
#' @importFrom htmlwidgets sizingPolicy
#' @importFrom dplyr slice
#' @importFrom colorspace scale_colour_continuous_sequential
#' @importFrom shinycssloaders withSpinner
#' @importFrom lubridate dmy
mod_map_data_ui <- function(id){
  ns <- NS(id)
  tagList(
    box(title = "This is map",
        withSpinner(girafeOutput(ns("map")), type = 4),
        width = NULL)
  )
}
    
#' map_data Server Function
#'
#' @noRd 
mod_map_data_server <- function(input, output, session, result, selected_lines){
  ns <- session$ns

  output$map <- renderGirafe({
    
    lux_map <- fread("data-raw/communes_df.csv")

    data_to_plot <- result()$return_dataset[selected_lines(), ]

  map_to_render <- ggplot() +
    geom_polygon_interactive(data = lux_map,
                             aes(lon, lat, group = commune),
                                  colour = "black", fill = "grey") +
    geom_point_interactive(data = data_to_plot,
                           aes(lon, lat, color = (!!result()$variable)),
                           size = 4) +
                           #tooltip = sprintf("%s<br/>", (!!result()$variable))) +
    theme_void() +
    theme(legend.position = "bottom")

  x <- girafe(ggobj = map_to_render,
              width_svg = 6, height_svg = 9)

  x <- girafe_options(x = x,
                 opts_tooltip(opacity = .7),
                 opts_zoom(min = .5, max = 4),
                 sizingPolicy(defaultWidth = "100%"), #, defaultHeight = "300px"),
                 opts_hover(css = "fill:red;stroke:orange;r:5pt;") )

  x
  })
}
    
## To be copied in the UI
# mod_map_data_ui("map_data_ui_1")
    
## To be copied in the server
# callModule(mod_map_data_server, "map_data_ui_1")

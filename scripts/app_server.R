library("shiny")
library("ggplot2")
library("dplyr")
library("tidyr")
library("plotly")
library("leaflet")
library("tidyverse")

# Read in data

data_by_year <- read.csv("../data/Spotify/data_by_year_o.csv")

# Popularity by Year Chart

pop_by_year <- data_by_year %>%
  select(year, popularity)

# Instrument vs Danceability Chart

data_by_year_long <- data_by_year %>%
  select(year, danceability, instrumentalness) %>% # select relevant columns
  # Reshaped dataframe so there's only 1 fill variable.
  gather(variable, measure, -year)

# chart 3 stuff 



# Central server function

server <- function(input, output) {
  output$scatter <- renderPlotly({
    
    new_data_pop <- pop_by_year %>%
      filter(year >= min(input$slider) & year <= max(input$slider))
    
    Year <- new_data_pop$year
    Popularity <- new_data_pop$popularity
    
    plot1 <- ggplot(data = new_data_pop, aes(year, popularity)) +
      geom_point(size = 1) +
      theme_minimal() +
      ggtitle("Change in Music Popularity from 1921-2020") +
      xlab("Year") +
      ylab ("Popularity") +
      geom_smooth(method=lm, se=FALSE) + 
      theme(panel.background = element_rect(fill = "#ADD8E6",
                                            colour = "lightcyan1",
                                            size = 0.5, linetype = "solid"))
    
    return(plot1)
  })
  
  output$inst_dance_chart <- renderPlot({
    if(input$rad_btn_c2 == "Danceability") {
      data_input_based <- filter(data_by_year_long, variable == "danceability")
      legend_names <- "Danceability" 
      bar_colors <- "#80B1D3"
    }else if(input$rad_btn_c2 == "Instrumentalness") {
      data_input_based <- filter(data_by_year_long, variable == "instrumentalness")
      legend_names <- "Instrumentalness" 
      bar_colors <- "#FDB462"
    }else if(input$rad_btn_c2 == "Both") {
      data_input_based <- data_by_year_long
      legend_names <- c("Danceability", "Instrumentalness")
      bar_colors <- c("#80B1D3", "#FDB462")
    }
    
    plot <- ggplot(data_input_based) +
      geom_col(
        mapping = aes(x = year, y = measure, fill = variable) # Create chart
      ) +
      labs(
        title = "Danceability and Instrumentalness From 1921 to 2020",
        # Renamed title and y-axis label
        y = "Danceability and Instrumentalness Index (0.0 to 1.0"
      ) +
      scale_x_continuous(
        name = "Year",
        n.breaks = 10 # Specified number of breaks for x-axis
      ) +
      scale_fill_manual(
        name = "Audio Features",
        labels = legend_names,
        #labels = c("Danceability", "Instrumentalness"),
        # Renamed legend labels and changed colors
        values = bar_colors
        #values = c("#80B1D3", "#FDB462")
      )
    
    return(plot)
  })
}




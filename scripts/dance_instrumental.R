# Chart for instrumentalness vs danceability

library("dplyr")
library("ggplot2")
library("tidyr")
library("lintr")
library("styler")

# Stacked bar chart
inst_dance_chart <- function(data) {
  data_by_year_long <- data %>%
    select(year, danceability, instrumentalness) %>% # select relevant columns
    gather(variable, measure, -year) # Reshaped dataframe so there's only 1 fill variable.

  chart <- ggplot(data_by_year_long) +
    geom_col(
      mapping = aes(x = year, y = measure, fill = variable) # Create chart
    ) +
    labs(
      title = "Danceability and Instrumentalness From 1921 to 2020",
      y = "Danceability and Instrumentalness Index (0.0 to 1.0" # Renamed title and y-axis label
    ) +
    scale_x_continuous(
      name = "Year",
      n.breaks = 10 # Specified number of breaks for x-axis--easier to look at
    ) +
    scale_fill_manual(
      name = "Audio Features",
      labels = c("Danceability", "Instrumentalness"),
      values = c("#80B1D3", "#FDB462") # Renamed legend labels and changed colors
    )

  return(chart)
}

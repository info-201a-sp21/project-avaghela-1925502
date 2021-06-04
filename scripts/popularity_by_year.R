library("dplyr")
library("leaflet")
library("ggplot2")
library("plotly")
library("lintr")
library("tidyverse")

popularity_by_year <- function(df) {
  data_by_year <- df %>%
    select(year, popularity)

  x <- data_by_year$year
  y <- data_by_year$popularity

  ggplot(data = data_by_year, aes(x, y)) +
    geom_point() +
    theme_minimal() +
    ggtitle("Change in Music Popularity over the Years") +
    xlab("Year") +
    ylab("Popularity") +
    geom_smooth(method = lm, se = FALSE)
}

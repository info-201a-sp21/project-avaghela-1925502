# Import library
library("ggplot2")
library("lintr")

# Function that plots a line graph to visualize how loudness of
# music changed over time.
plot_loudness_year <- function(df) {
  ggplotly(ggplot(data = df, aes(x = year, y = loudness)) +
    geom_line() +
    geom_smooth() +
    ggtitle("The Trend of Loudness of Music Over Time") +
    labs(y = "Loudness (dB)", x = "Year"))
}

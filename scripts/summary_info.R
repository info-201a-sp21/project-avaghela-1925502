# load and install packages
library(dplyr)

# Create summary function
get_summary_info <- function(df) {
  highest_dancability <- df %>%
    filter(danceability == max(danceability)) %>%
    pull(danceability)
  most_common_key <- df %>%
    group_by(key) %>%
    summarise(count_keys = n()) %>%
    filter(count_keys == max(count_keys)) %>%
    pull(key)
  music_keys <- c("C", "C#/Db", "D", "D#/Eb","E", "F", "F#/Gb", "G", "G#/Ab",
                  "A", "A#/Bb","B")
  song_key <- most_common_key + 1
  common_key <- music_keys[song_key]
  number_rows <- nrow(df)
  avg_length <- df %>%
    summarise(duration_ms = mean(duration_ms)) %>%
    pull(duration_ms)
  avg_length_min <- round(avg_length * (0.16666666666667 * 0.0001), 2)
  year_lowest_loudness <- df %>%
    filter(loudness == min(loudness)) %>%
    pull(year)
  summary_info <- list("The highest ammount of dancability" =
                         highest_dancability,
                    "The most common key" = common_key,
                    "Number of rows" = number_rows,
                    "Average length of songs in minutes" = avg_length_min,
                    "The quietest year in music" = year_lowest_loudness)
  return(summary_info)
}
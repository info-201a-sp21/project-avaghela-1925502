library("shiny")
library("ggplot2")
library("plotly")
library("shinyWidgets")



# Central ui chunk

ui <- fluidPage(
  #includeCSS("style.css"), # Need to make the file style.css
  navbarPage("Main Title...",
    tabPanel("Scatter",
             titlePanel("Music Popularity"),
             tab_1,
             setBackgroundColor("#F0F8FF")),
    tabPanel("Tab 2", tab_2),
    tabPanel("Trend of Loudness Feature",
             titlePanel("Music Loudness from 1921 to 2020"),
             tab_3)
  )
)


# Tab 1

tab_1 <- sidebarLayout(
  
  sidebarPanel(  
    sliderInput("slider", "Select Range:", min = 1921, 
                max = 2020, value = c(1921,2020), step = 2)
  ),
  mainPanel(
    plotlyOutput(
      outputId = "scatter"
    )
  )
)

# Tab 2

tab_2 <- sidebarLayout(
  sidebarPanel(
    radioButtons(
      inputId = "rad_btn_c2", # this means radio button chart 2
      label = "Select a variable(s)",
      choices = list("Instrumentalness" = "Instrumentalness",
                     "Danceability" = "Danceability", "Both" = "Both")
    )#,
    # dateRangeInput(
    #   inputId = "date_rng_c2", # date range input chart 2
    #   label = "Choose a date range",
    #   format = "yyyy",
    #   start = "1921-01-01",
    #   end = "2020-01-01",
    #   min = "1921-01-01",
    #   max = "2020-01-01"
    # ) # date range doesn't seem to work very well
  ),
  mainPanel(
    plotOutput(
      outputId = "inst_dance_chart"
    )
  )
)

# Tab 3

# data for loudness range



tab_3 <- sidebarLayout(
  sidebarPanel(
    h1(""),
    sliderInput(
      inputId = "yearRange",
      label = "Choose the input year",
      min = 1921,
      max = 2020,
      value = c(1921, 2020),
      step = 1
    )
  ),
  mainPanel(
    h1("Loudness Graph"),
    plotlyOutput(
      outputId = "loudness_chart"
    )
    
  )
)

# Central ui chunk

ui <- fluidPage(
  #includeCSS("style.css"), # Need to make the file style.css
  navbarPage("Main Title...",
             tabPanel("Scatter",
                      titlePanel("Music Popularity"),
                      tab_1,
                      setBackgroundColor("#F0F8FF")),
             tabPanel("Tab 2", tab_2),
             tabPanel("Tab 3", tab_3)
  )
)



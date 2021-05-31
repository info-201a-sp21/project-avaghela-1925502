library("shiny")
library("ggplot2")

# Central ui chunk

ui <- fluidPage(
  #includeCSS("style.css"), # Need to make the file style.css
  navbarPage("Main Title...",
    tabPanel("Tab 1", tab_1),
    tabPanel("Tab 2", tab_2),
    tabPanel("Tab 3", tab_3)
  )
)

# Tab 1

tab_1 <- sidebarLayout(
  sidebarPanel(  
    h1("This is a placeholder")
  ),
  mainPanel(
    h1("placeholder")
  )
)

# Tab 2

tab_2 <- sidebarLayout(
  sidebarPanel(
    radioButtons(
      inputId = "rad_btn_c2", # this means radio button chart 2
      label = "Select a variable(s)",
      choices = list("Choice 1" = "Instrumentalness",
                     "Choice 2" = "Danceability", "Choice 3" = "Both")
    ),
    dateRangeInput(
      inputId = "date_rng_c2", # date range input chart 2
      label = "Choose a date range",
      format = "yyyy",
      start = "1921-01-01",
      end = "2020-01-01",
      min = "1921-01-01",
      max = "2020-01-01"
    ) # date range doesn't seem to work very well
  ),
  mainPanel(
    plotOutput(
      outputId = "inst_dance_chart"
    )
  )
)

# Tab 3

tab_3 <- sidebarLayout(
  sidebarPanel(
    h1("Placeholder")
  ),
  mainPanel(
    h1("placeholder")
  )
)

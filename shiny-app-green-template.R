#Shiny App FSA template,  20/06/2019, FSA data science team

#####-----Load libraries and needed data + processing independed of the app-----#####
library(shiny)
library(shinyWidgets)
library(shinythemes)
library(shinydashboard)
library(tidyverse)

#Delet everything, then load needed data. Add any code that is not reactive. 
rm(list = ls())

#####-----Dashboar Header-----#####  
# Define UI as dashboardPage
ui <- dashboardPage(

  # Sets the title and adds the FSA logo, clicking on the logo will take you to the FSA homepage
  dashboardHeader(title ="Food App"  #,
                  
                  ##Add this line for a logo in the top right corner that opens a website (here
                  ## food.gov.uk) when you click on it. The logo you want to use must be stored in
                  ## a folder called www in the same folder as the app file. 
                  #tags$li(a(href = 'https://www.food.gov.uk/',
                  #         img(src = 'logo.png',
                  #            title = "FSA Home", height = "60px"),
                  #       style = "padding-top:10px; padding-bottom:10px;"),
                  #    class = "dropdown"
                  #   )
  ),
  
#####-----Dashboar Sidebar-----#####  
  # Set all the side bar options you want, delete or add more as needed. 
  # List of icons https://fontawesome.com/icons?from=io
  dashboardSidebar(
    sidebarMenu(
      menuItem("Introduction", tabName = "intro", icon = icon("chalkboard-teacher")),
      menuItem("Data plots", tabName = "dplots", icon = icon("chart-bar")),
      menuItem("More data plots!", tabName = "dplots2", icon = icon("chart-line")),
      menuItem("Even more data!", tabName = "dplots3", icon = icon("chart-pie")),
      menuItem("Data origin and processing", tabName = "methods", icon = icon("book")),
      menuItem("Contact and links", tabName = "contact", icon = icon("address-card"))
    )
  ),

#####-----Dashboar body - items-----#####    
  # Add text to your tab pages. Add any input and output space here!
  dashboardBody(
    tabItems(
      #####-----Tab 1 Introduction-----#####
      # Introduction tab content
      tabItem(tabName = "intro",
              h2("Introduction"),
              wellPanel(
                style = "background: white; 
                        border-color: #a7d18c",
                fluidRow("Introduction text here..."
                )
                #And plots or more text
              )
              # Add mroe wellPanels here if needed
      ),
      #####-----Tab 2-----#####
      # First data tab content
      tabItem(tabName = "dplots",
              h2("Data input and plots")
              #Add text, input and plot outputs here!
      ),
      #####-----Tab 3-----#####
      # Second data tab content
      tabItem(tabName = "dplots2",
              h2("Some different plots")
              #Add text, input and plot outputs here!
      ),
      #####-----Tab 4-----#####
      # Third data tab content
      tabItem(tabName = "dplots3",
              h2("More data and more plots")
              #Add text, input and plot outputs here!
      ),
      #####-----Tab 5-----#####
      # Method tab content
      tabItem(tabName = "methods",
              h2("Document where the data comes from and how it is processed")
              #Add text here!
      ),
      #####-----Tab 6-----#####
      # Contact tab content
      tabItem(tabName = "contact",
              h2("How can the user get help and/or more information?")
              #Add text and links here
      )
    ),

#####-----Dashboar body - Formatting-----#####      
    #Here is all the formatting for colors etc. 
     tags$head(tags$style(HTML('
         .skin-blue .main-header .logo {
          height : 80px;
          background-color: #338c74;
          font-family: Arial;
          padding-top:15px;
          font-size: 30px;
         }
         .skin-blue .main-header .navbar {
          background-color: #99c5b9;
         } 
        .skin-blue .main-sidebar {
         padding-top:100px;
         background-color: #006F51;
        }
        .skin-blue .main-sidebar .sidebar .sidebar-menu .active a{
         background-color: #6CB33F;
        }
        .content-wrapper, .right-side { 
        background-color: white;
        overflow-x: hidden; 
        }
      ')))
  )
)

#####-----Server function-----#####
# Define server logic required to draw a histogram
server <- function(input, output) {
#####-----Function for tab 1-----#####  
  
  
#####-----Function tab 2 etc-----##### 
  
}

#####-----Run App-----##### 
# Run the application 
shinyApp(ui = ui, server = server)


#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyWidgets)
library(dplyr)
library(bslib)

staff = c("张宝元","白宇昕","韩镇远","张博文","宋敏","柯鹏","袁浩铭","于春娟","杨翔翔","帅嘉伟","陶超仁","武菲菲","贺朝","刘青青")

ui <- page_sidebar(
  tags$style(type="text/css",
             ".shiny-output-error { visibility: hidden; }",
             ".shiny-output-error:before { visibility: hidden; }"
  ),
  title = "简易抽签app",
  sidebar = sidebar(
    title = "controls",
    width = "400px",
    selectInput(
      inputId = "person",
      label = "候选人", 
      choices = staff,
      multiple = TRUE,
    ),
    actionButton("action", label = "Roll"),
  ),
  card(
    card_header("抽签结果"),
    verbatimTextOutput("outcome")
  )
)

server = function(input,output,session){
  
  value = eventReactive(input$action,{
   rnorm(length(input$person))
 })
 
 output$outcome = renderPrint(
   data.frame(
     name = input$person,
     value = value()
   ) |> 
     arrange(desc(value()))
 )
}

shinyApp(ui, server)





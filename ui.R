library(shiny)
library(RHRV)

shinyUI(
    fluidPage(
      titlePanel("Heart Rate Variability Analysis Using Wavelet Entropy Measures"),
      sidebarLayout(
      sidebarPanel(width=3,
      
  selectInput('wavelet',
              label='Wavelet',
              choices=c("haar","d4","d6","d8","d16","la8", "la16","la20","bl14","bl20"),
              selected="d4"),
  helpText('The wavelet used to calculate the spectrogram. 
           The name of the wavelet specifies the family  and the length of the wavelet.'),
  sliderInput('bandtolerance',
              label='Band tolerance',
              min = 0.001, max = 0.1, value = 0.01, step=0.005),
  helpText('Sets the maximum error allowed in the wavelet analysis.')
  ),
  
  
  mainPanel(
    fluidRow(p("Heart Rate Variability (HRV) describes variations over time of both instantaneous HR and the intervals between consecutive heart beats.")),
    fluidRow(p("Different physiological conditions contribute to the patterns of heart rate variability; 
                for example stress and streneous physical training have an effect on HRV. 
                This can be analyzed by separating the heart rate signal to different frequency areas (from ultra low frequency to high frequency) ")),
    fluidRow(p('For detailed beginner friendly introduction on HRV please see tutorial:'),
             a(href="http://rhrv.r-forge.r-project.org/tutorial/tutorial.pdf","Getting Started with RHRV")),
    plotOutput('plot'),
    plotOutput('hrplot')
  )
))
)
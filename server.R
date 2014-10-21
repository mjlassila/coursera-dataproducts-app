library(shiny)
library(RHRV)


# Prepare the dataset
hrv.data  = CreateHRVData()
hrv.data = LoadBeatAscii(hrv.data,"example.beats")
hrv.data = BuildNIHR(hrv.data)
hrv.data = FilterNIHR(hrv.data)


# Start Shiny

shinyServer(function(input, output) {
  hrv.data <- InterpolateNIHR (hrv.data, freqhr = 4)
  
  
  hrv.data = CreateFreqAnalysis(hrv.data)
  
  hrv.base.data <- 
    CreateTimeAnalysis(
      hrv.data,size=300,
      interval = 7.8)
# Let user decide the wavelet type and error tolerance to use
  hrv <- reactive({
    CalculatePowerBand(
      hrv.base.data,
      indexFreqAnalysis= 1,
      type = "wavelet",
      wavelet = input$wavelet,
      bandtolerance = input$bandtolerance,
      relative = FALSE,
      ULFmin = 0,
      ULFmax = 0.03,
      VLFmin = 0.03,
      VLFmax = 0.05,
      LFmin = 0.05,
      LFmax = 0.15,
      HFmin = 0.15,
      HFmax = 0.4 )
  })
  
  output$plot <- renderPlot(
  PlotPowerBand(hrv(), indexFreqAnalysis = 1, ymax = 700, ymaxratio = 50),width=800)
  
  output$hrplot <- renderPlot(
    PlotHR(hrv.data),width=800)
  
})
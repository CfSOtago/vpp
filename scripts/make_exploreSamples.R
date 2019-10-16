# loads data & runs a report

# Load packages needed in this script
require(bookdown)
require(data.table) # data munching
require(drake)
require(here)
require(rmarkdown)

# parameters ----
repoParams <- list()

repoParams$repoLoc <- here::here()

repoParams$f1 <- "/Volumes/hum-csafe/Research Projects/GREEN Grid/externalData/solarCity/2018-07-06-sampleData/RgAv_Sample_Data.csv.gz"

repoParams$f2 <- "/Volumes//hum-csafe/Research Projects/GREEN Grid/externalData/solarCity/2018-07-06-sampleData/Sample Monitoring Data.csv.gz"

# Data ----

loadData <- function(f){
  # load the data
  message("Loading ", f)
  dt <- data.table::fread(f)
  return(dt)
} # should be in package functions

makeReport <- function(iFile, oFile){
  # default = html
  rmarkdown::render(input = iFile, # input .Rmd
                    params = list(title = title,
                                  subtitle = subtitle,
                                  authors = author),
                    output_file = oFile # output
  )
}

# drake code ----
# this is where we use drake 
plan <- drake::drake_plan(
  df1 = loadData(repoParams$f1),
  df2 = loadData(repoParams$f2)
)

plan # test the plan
make(plan) # run the plan, re-loading data if needed

# > Make report ----
# >> yaml ----
version <- "1.0"
title <- paste0("Virtual Power PLants: Explore initial sample data")
subtitle <- paste0("Report v", version)
author <- "Ben Anderson"


# >> run report ----
iFile <- paste0(repoParams$repoLoc, "/scripts/exploreSamples.Rmd")
oFile <- paste0(repoParams$repoLoc,"/docs/exploreSamples_v", version, ".html")
makeReport(iFile, oFile)



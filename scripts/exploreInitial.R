# very basic script to see what is in the data

f1 <- "/Volumes/hum-csafe/Research Projects/GREEN Grid/externalData/solarCity/2018-07-06-sampleData/RgAv_Sample_Data.csv.gz"

f2 <- "/Volumes//hum-csafe/Research Projects/GREEN Grid/externalData/solarCity/2018-07-06-sampleData/Sample Monitoring Data.csv.gz"

require(data.table)
require(skimr)

dt1 <- data.table::fread(f1)
summary(dt1)
head(dt1)
skimr::skim(dt1)

dt2 <- data.table::fread(f2)
summary(dt2)
head(dt2)
skimr::skim(dt2)
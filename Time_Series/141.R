#xts is a superset of zoo, where xts can do everything zoo can do

library(zoo)

setwd("c:/work/DynamicAllocation/analysis/trunk/")
#chart size parameters
plot_width = 800
plot_height = 640

#load Trend Level Analysis
ATR<-read.csv("data_files/ATR.csv")
#transform ATR
ATR <- transform(ATR, Date=as.Date(Date, format='%m/%d/%y'))

ts <- zoo(ATR)

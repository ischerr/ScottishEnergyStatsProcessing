library(readxl)
library(tidyr)
library(data.table)

lcreedataset2019 <- read_excel("Data Sources/LCRE Survey/lcreedataset2019.xlsx", 
                               sheet = "LCRE by country")

lcreedataset2019 <- fill(lcreedataset2019,1, .direction ="down")

lcreedataset2019 <- as_tibble(lcreedataset2019)

lcrelist <- list()


min(as.numeric(lcreedataset2019[2,]), na.rm = TRUE)

for (year in min(as.numeric(lcreedataset2019[2,]), na.rm = TRUE):max(as.numeric(lcreedataset2019[2,]), na.rm = TRUE)){
  print(year)
  i<- year -  min(as.numeric(lcreedataset2019[2,]), na.rm = TRUE) + 1
  print(i)
  data <- lcreedataset2019[c(1,2,((i*4)-1):(((i*4)-1)+3))]
  data$Year <- year
  lcrelist[[i]] <- data
}

newdata <- rbindlist(lcrelist)

names(newdata) <- c("Category", "Country", "Estimate", "Lower CI", "Upper CI", "CV", "Year")

newdata <- as_tibble(newdata[complete.cases(newdata),])

newdata <- newdata[c(7,1:6)]

newdata[which(newdata$Category == "Turnover (£ thousand)"),]$Category <- "Turnover"
newdata[which(newdata$Category == "Exports (£ thousand)"),]$Category <- "Exports"
newdata[which(newdata$Category == "Imports (£ thousand)"),]$Category <- "Imports"
newdata[which(newdata$Category == "Acquisitions (£ thousand)"),]$Category <- "Aquisitions"
newdata[which(newdata$Category == "Disposals (£ thousand)"),]$Category <- "Disposals"


write.csv(newdata, "Output/LCRE/LCRE.csv", row.names = FALSE)



lcreedataset2019 <- read_excel("Data Sources/LCRE Survey/lcreedataset2019.xlsx", 
                               sheet = "LCRE group & country")

lcreedataset2019 <- fill(lcreedataset2019,1, .direction ="down")
lcreedataset2019 <- fill(lcreedataset2019,2, .direction ="down")

lcreedataset2019 <- as_tibble(lcreedataset2019)

lcrelist <- list()


min(as.numeric(lcreedataset2019[4,]), na.rm = TRUE)

for (year in min(as.numeric(lcreedataset2019[4,]), na.rm = TRUE):max(as.numeric(lcreedataset2019[4,]), na.rm = TRUE)){
  print(year)
  i<- year -  min(as.numeric(lcreedataset2019[4,]), na.rm = TRUE) + 1
  print(i)
  data <- lcreedataset2019[c(1,2,3,((i*4)):(((i*4))+3))]
  data$Year <- year
  lcrelist[[i]] <- data
}

newdata <- rbindlist(lcrelist)

names(newdata) <- c("Category", "Sector", "Country", "Estimate", "Lower CI", "Upper CI", "CV", "Year")

newdata <- as_tibble(newdata[complete.cases(newdata),])

newdata <- newdata[c(8,1:7)]

newdata[which(newdata$Category == "Turnover (£ thousand)"),]$Category <- "Turnover"
newdata[which(newdata$Category == "Exports (£ thousand)"),]$Category <- "Exports"
newdata[which(newdata$Category == "Imports (£ thousand)"),]$Category <- "Imports"
newdata[which(newdata$Category == "Acquisitions (£ thousand)"),]$Category <- "Aquisitions"
newdata[which(newdata$Category == "Disposals (£ thousand)"),]$Category <- "Disposals"

newdata$Estimate <- as.numeric(newdata$Estimate)

newdata$`Lower CI` <- as.numeric(newdata$`Lower CI`)

newdata$`Upper CI` <- as.numeric(newdata$`Upper CI`)

newdata[which(is.na(newdata$Estimate + newdata$`Lower CI`+newdata$`Upper CI`)),]$Estimate <- NA
newdata[which(is.na(newdata$Estimate + newdata$`Lower CI`+newdata$`Upper CI`)),]$`Lower CI` <- NA
newdata[which(is.na(newdata$Estimate + newdata$`Lower CI`+newdata$`Upper CI`)),]$`Upper CI` <- NA

newdata$Estimate <- as.numeric(newdata$Estimate)

newdata$`Lower CI` <- as.numeric(newdata$`Lower CI`)

newdata$`Upper CI` <- as.numeric(newdata$`Upper CI`)
write.csv(newdata, "Output/LCRE/LCREBreakdown.csv", row.names = FALSE)


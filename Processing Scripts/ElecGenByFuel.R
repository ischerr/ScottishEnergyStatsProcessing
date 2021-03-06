library(readxl)
library(tidyverse)

print("Fuel")

### Load Regional generation Data
Fuel <- read_excel(
  "Data Sources/Regional Generation/Regional Generation.xlsx",
  col_names = FALSE,
  sheet = "Electricity generation by fuel"
)

Fuel[1:2] <- NULL
Fuel <- as_tibble(t(Fuel))
Fuel[1] <- NULL

# names(Fuel) <- c(
#   "Year",
#   "Country"
#   
# )
rm(list = ls())

library(tidyverse)
library(purrr)
library(ggplot2)
library(tidyr)
library(readxl)

### Set PrimaryDirectory
dirname(rstudioapi::getActiveDocumentContext()$path)            # Finds the directory where this script is located
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))     # Sets the working directory to where the script is located
getwd()
PrimaryDirectory <- getwd()
PrimaryDirectory

data <- read_csv("hypoxia-data.csv")
data

data$`IL-2 (A4) pg/mL`
data$`mM D2HG`
data$`live CD3/well`

norm_data <- data %>%
  mutate(combined = paste(celltype, condition, sep = "_")) %>%
  mutate(across(`IL-2 (A4) pg/mL`:`mM D2HG`, ~.x/`live CD3/well`*10000))



ggplot(norm_data, aes(x = day, y = `Leptin (B4) pg/mL`, col = as.factor(combined))) +
  geom_point() +
  theme_bw()



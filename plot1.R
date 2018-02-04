# ==============================================================================
# Coursera Exploratory Data Analyis, Week 1, Assigment
# Oliver Baumfeld
#
# Generates plot1.png which shows a histogram of the Global Active Power 
# on 2007-02-01 and 2007-02-02.
# ==============================================================================
library(tidyverse)

# === read and prepare data ===
filepath <- "household_power_consumption.txt"
data <- read_delim(filepath,
                   delim = ";",
                   na=("?"),
                   locale = locale(decimal_mark = "."),
                   col_types = cols(col_date(format = "%d/%m/%Y"),
                                    col_time(format = "%H:%M:%S"),
                                    col_double(),
                                    col_double(),
                                    col_double(),
                                    col_double(),
                                    col_double(),
                                    col_double(),
                                    col_double())
)

week1_data <- data %>% 
    filter(Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02") ) %>%
    mutate(DateTime = as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))

# === produce plot ===
png(filename = "plot1.png", 
    width = 480,
    height = 480,
    bg = "transparent")

hist(x = week1_data$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kW)",
     col = "red")

dev.off()
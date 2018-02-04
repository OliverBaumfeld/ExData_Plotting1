# ==============================================================================
# Coursera Exploratory Data Analyis, Week 1, Assigment
# Oliver Baumfeld
#
# Generates plot3.png which shows the 3 energy sub meterings as a function of 
# time on 2007-02-01 and 2007-02-02.
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
png(filename = "plot3.png", 
    width = 480,
    height = 480,
    bg = "transparent")

plot(x = week1_data$DateTime,
     y = week1_data$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")

lines(x = week1_data$DateTime,
      y = week1_data$Sub_metering_2,
      col = "red")

lines(x = week1_data$DateTime,
      y = week1_data$Sub_metering_3,
      col = "blue")

legend("topright",
       legend = names(week1_data)[7:9],
       col=c("black", "red", "blue"),
       lty=1)

dev.off()
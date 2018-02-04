# ==============================================================================
# Coursera Exploratory Data Analyis, Week 1, Assigment
# Oliver Baumfeld
#
# Generates plot4.png which shows 4 different graphs with data between
# 2007-02-01 and 2007-02-02.
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
png(filename = "plot4.png", 
    width = 480,
    height = 480,
    bg = "transparent")

# Set plotting parameters
par(mfrow = c(2, 2),
    pty = "m",
    cex = 0.7) 

# Subplot 1
plot(x = week1_data$DateTime,
     y = week1_data$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kW)")

# Subplot 2
plot(x = week1_data$DateTime,
     y = week1_data$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

# Subplot 3
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
       lty=1,
       bty = "n")

# Subplot 4
plot(x = week1_data$DateTime,
     y = week1_data$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()
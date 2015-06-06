if (!file.exists("household_power_consumption.txt")){
        temp <- tempfile()
        print("Downloading file. Please wait ... ")
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp, method = "curl", quiet = TRUE)
        dat <- read.table(unzip(temp,"household_power_consumption.txt"), sep = ";", na.strings="?", header = TRUE)
        unlink(temp)
    } else {
        dat <- read.table(file="household_power_consumption.txt",sep = ";", na.strings="?", header = TRUE)
    }

dat <- within(dat, datetime <- as.POSIXlt(paste(Date, Time),format = "%d/%m/%Y %H:%M:%S"))
dat$Date <-as.Date(dat$Date, "%d/%m/%Y")
get.rows   <- dat$Date >= as.Date("2007-02-01") & dat$Date <= as.Date("2007-02-02")
dat <- dat[get.rows, ]

png("plot3.png", bg="transparent", width=480, height=480)

# Plot3
plot(x = dat$datetime, y = dat$Sub_metering_1, type = "n", ylab = "Energy submetering", xlab="")
lines(x = dat$datetime, y = dat$Sub_metering_1, col="black")
lines(x = dat$datetime, y = dat$Sub_metering_2, col="red")
lines(x = dat$datetime, y = dat$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1, col = c("black", "red", "blue"), bty)

dev.off()
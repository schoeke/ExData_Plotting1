# Check if the data file is already here and read it in.

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

# Filter by dates given in assignment. 
get.rows   <- dat$Date >= as.Date("2007-02-01") & dat$Date <= as.Date("2007-02-02")
dat <- dat[get.rows, ]

png("plot1.png", bg="transparent", width=480, height=480)

# Plot1 
hist(dat$Global_active_power,xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")


dev.off()
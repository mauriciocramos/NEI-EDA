## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
## (fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
## plot answering this question.

if (!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
totalpm25 <- with(subset(NEI,fips=="24510"), tapply(Emissions,year,sum))
years <- names(totalpm25)
plot(years, totalpm25, type = "o", xaxt = "n", main = "Total PM2.5 emission in Baltimore City per year")
axis(1, years)
dev.copy(png, file = "plot2.png")
dev.off()
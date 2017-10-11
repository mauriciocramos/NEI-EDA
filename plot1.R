## Author: Maurício Collaça
## date: 2017-10-10

## Question: Have total emissions from PM2.5 decreased in the United States from
## 1999 to 2008? Using the base plotting system, make a plot showing the total
## PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and
## 2008.

if (!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
totalpm25 <- with(NEI, tapply(Emissions,year,sum))
years <- names(totalpm25)
plot(years, totalpm25, type = "o", xaxt = "n", main = "Total PM2.5 emission from all sources per year")
axis(1, years)
dev.copy(png, file = "plot1.png")
dev.off()


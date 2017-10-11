## Author: Maurício Collaça
## date: 2017-10-10

## Compare emissions from motor vehicle sources in Baltimore City with emissions
## from motor vehicle sources in Los Angeles County, California (fips ==
## "06037"). Which city has seen greater changes over time in motor vehicle
## emissions?

library(dplyr, quietly = TRUE, warn.conflicts = FALSE)
library(ggplot2, quietly = TRUE, warn.conflicts = FALSE)
if (!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if (!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")
motorVehicles <- SCC %>% filter(grepl("Vehicle", EI.Sector)) %>% select(SCC)
data <- NEI %>% filter((fips == "24510" | fips == "06037") & SCC %in% motorVehicles$SCC) %>% group_by(fips, year) %>%
    summarise(motorVehiclePM2.5 = sum(Emissions))
g <- ggplot(data, aes(x=year, y=motorVehiclePM2.5)) +
    facet_grid(. ~ fips) +
    scale_x_continuous(breaks = c(1999,2002,2005,2008),
                       labels = c("1999","2002","2005","2008"),
                       limits = c(1998,2009),
                       minor_breaks = NULL) +
    geom_line(size = 1) +
    geom_point(size = 2) + geom_smooth(method = "lm") +
    ggtitle("Emissions from motor vehicle sources", "in Los Angeles County (06037) and Baltimore City (24510)") +
    theme_bw()
print(g)
dev.copy(png, file = "plot6.png")
dev.off()
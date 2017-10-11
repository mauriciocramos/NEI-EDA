## Author: Maurício Collaça
## date: 2017-10-10

## How have emissions from motor vehicle sources changed from 1999–2008 in
## Baltimore City?

library(dplyr, quietly = TRUE, warn.conflicts = FALSE)
library(ggplot2, quietly = TRUE, warn.conflicts = FALSE)
if (!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if (!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")
motorVehicles <- SCC %>% filter(grepl("Vehicle", EI.Sector)) %>% select(SCC)
data <- NEI %>% filter(fips == "24510" & SCC %in% motorVehicles$SCC) %>% group_by(year) %>%
    summarise(motorVehiclePM2.5 = sum(Emissions))
g <- ggplot(data, aes(x=year, y=motorVehiclePM2.5)) +
    scale_x_continuous(breaks = c(1999,2002,2005,2008),
                       labels = c("1999","2002","2005","2008"),
                       limits = c(1998,2009),
                       minor_breaks = NULL) +
    geom_line(size = 1) +
    geom_point(size = 2) + geom_smooth(method = "lm") +
    ggtitle("Emissions from motor vehicle sources in Baltimore City") +
    theme_bw() + 
    theme(plot.title = element_text(hjust = 0.5))
print(g)
dev.copy(png, file = "plot5.png")
dev.off()
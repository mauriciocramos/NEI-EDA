## Author: Maurício Collaça
## date: 2017-10-10

## Across the United States, how have emissions from coal combustion-related
## sources changed from 1999–2008?

library(dplyr, quietly = TRUE, warn.conflicts = FALSE)
library(ggplot2, quietly = TRUE, warn.conflicts = FALSE)
if (!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if (!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")
coalCombustion <- SCC %>% filter(grepl("^Fuel Comb.+Coal$", EI.Sector)) %>% select(SCC)
data <- NEI %>% filter(SCC %in% coalCombustion$SCC) %>% group_by(year) %>%
    summarise(coalCombustionPM2.5 = sum(Emissions))
g <- ggplot(data, aes(x=year, y=coalCombustionPM2.5)) +
    scale_x_continuous(breaks = c(1999,2002,2005,2008),
                        labels = c("1999","2002","2005","2008"),
                        limits = c(1998,2009),
                        minor_breaks = NULL) +
    geom_line(size = 1) +
    geom_point(size = 2) + geom_smooth(method = "lm") +
    ggtitle("Emissions from coal combustion sources") +
    theme_bw() + 
    theme(plot.title = element_text(hjust = 0.5))
print(g)
dev.copy(png, file = "plot4.png")
dev.off()

## Of the four types of sources indicated by the type (point, nonpoint, onroad,
## nonroad) variable, which of these four sources have seen decreases in
## emissions from 1999–2008 for Baltimore City? Which have seen increases in
## emissions from 1999–2008? Use the ggplot2 plotting system to make a plot
## answer this question.

library(dplyr, quietly = TRUE, warn.conflicts = FALSE)
library(ggplot2, quietly = TRUE, warn.conflicts = FALSE)
if (!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
data <- NEI %>% filter(fips == "24510") %>% group_by(type, year) %>%
    summarise(totalpm2.5 = sum(Emissions))
g <- ggplot(data, aes(x=year, y=totalpm2.5)) +
    facet_grid(. ~ type) +
    scale_x_continuous(breaks = c(1999,2002,2005,2008),
                       labels = c("1999","2002","2005","2008"),
                       limits = c(1998,2009),
                       minor_breaks = NULL) +
    geom_line(aes(color = type), size = 2) +
    geom_point() + geom_smooth(method = "lm") +
    ggtitle("Total PM2.5 emission in Baltimore City per type per year") +
    theme_bw() + 
    theme(legend.position="top", plot.title = element_text(hjust = 0.5))
print(g)
dev.copy(png, file = "plot3.png")
dev.off()
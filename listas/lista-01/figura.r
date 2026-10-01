library(ggplot2)
air <- read.csv("airquality.csv")

figura <- ggplot(air, aes(x = as.factor(Month), y = Temp)) +
  geom_boxplot(fill = "lightgreen", color = "darkgreen") +
  labs(
    title = "Distribuição da Temperatura por Mês",
    x = "Mês",
    y = "valores"
  ) +
  theme_minimal()

ggsave("figura.pdf", plot = figura, width = 7, height = 5)

air <- read.csv("airquality.csv")

pdf("figura.pdf", width = 7, height = 5)

boxplot(Temp ~ Month,
  data = air,
  main = "Distribuição de Temperatura por mês",
  xlab = "Mês",
  ylab = "Fahrenheit"
)

dev.off()

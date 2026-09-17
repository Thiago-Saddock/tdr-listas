
# Lê os dados em CSV e modifica a coluna "Month" para Mês
ler_dados <- function(arquivo) {
  dados <- read.csv(arquivo)
  dados$Mes <- factor(dados$Month, levels = 5:9,
                      labels = c("Maio", "Junho", "Julho", "Agosto",
                                 "Setembro"))
  dados
}

## Média mensal de cada variável considerando apenas os dias em que ela foi medida.
medias_mensais <- function(dados) {
  medias <- aggregate(cbind(Wind, Temp) ~ Mes, data = dados, FUN = mean,
                      na.action = na.pass, na.rm = TRUE)
  medias[, -1] <- round(medias[, -1], 1)
  medias
}

## Regressão da temperatura sobre o vento, nos dias com as duas medidas.
ajustar_modelo <- function(dados) {
  lm(Temp ~ Wind, data = dados)
}

## Desenha a dispersão com a reta ajustada e devolve o caminho do arquivo.

salvar_figura <- function(dados, modelo, arquivo = "saidas/dispersao.png") {
  dir.create(dirname(arquivo), showWarnings = FALSE, recursive = TRUE)
  png(arquivo, width = 1400, height = 900, res = 180)
  on.exit(dev.off())
  plot(Temp ~ Wind, data = dados, pch = 20, col = "purple",
       xlab = "Vento (MPH)", ylab = "Temperatura (F)")
  abline(modelo, col = "darkblue", lwd = 2)
  arquivo
}

## Cria um CSV 
gerar_csv <- function(medias, arquivo = "saidas/medias.csv") {
  dir.create(dirname(arquivo), showWarnings = FALSE, recursive = TRUE)
  write.csv(medias, file  = arquivo, row.names = FALSE)
  return(arquivo)
}

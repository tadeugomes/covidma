library(lubridate)
library(openair)  #função calendarPlot
library(zoo) # moving averages     
library(tidyverse)

#leitura do dataset
caso <- read.csv("~/Downloads/caso.csv") #dataset original disponível em brasil.io

#filtrar Maranhão
ma<-caso %>% 
  filter(state == "MA")

#transformar coluna de string para data 
ma$date<-as_date(ma$date)

#Transformar/calcular taxa de mortes
ma<-ma %>% 
  mutate(taxa_mortes = round((deaths / confirmed)*100, digits = 4))

#Taxa diária de mortes. Mortes/casos confirmados. digits = 4
calendarPlot(ma, pollutant = "taxa_mortes",
             main = "Evolução da taxa diária de mortes por Covid-19 no Maranhão (em %)", 
             xlab ="Elaboração: @teixeira_tadeu. Dados: www.brasil.io")


write_csv(ma, "caso_ma.csv")

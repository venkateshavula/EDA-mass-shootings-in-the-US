library(dplyr)
library(data.table)
library(readr)
library(car)
library(ggplot2)
library(plotly)
library(maps)
library(tm)
library(wordcloud)
library(sp)
library(maps)
library(maptools)
library(reshape2)

# read data into R
df<-read.csv("/Users/Venky/Downloads/Mass Shootings Dataset Ver 5.csv",na.strings ="",header = TRUE)

# recode Gender categories
df$Gender<-recode(df$Gender,"'M'='Male'; c('M/F','Male/Female')='Unknown'")
table(df$Gender)

# recode Race categories
df$Race<-recode(df$Race,"c('Black American or African American','black','Black American or African American/Unknown','Black')='Black/ African American';
                         c('White American or European American/Some other Race','White American or European American','white')='White';
                         c('Asian American','Asian American/Some other race')='Asian';
                         c('Some other race','Unknown','Two or more races','Other',NA,'')='Other';
                         'Latino'='Hispanic';'Native American or Alaska Native'='Native American/ Alaska Native'")
table(df$Race)

# Impute missing values of Age with mean value
df$Age_n<-as.numeric(levels(df$Age))[df$Age]
df$Age_n<-ifelse(is.na(df$Age_n),mean(df$Age_n,na.rm = TRUE),df$Age_n)

# Fix the Date format and Extract year & month
df<-df%>%mutate(Date = as.Date(Date, '%m/%d/%Y'),incidentyear=year(Date),incidentmonth=month(Date))

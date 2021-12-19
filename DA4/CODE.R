df <- read.csv(file = "covid_vaccine_statewise.csv",sep = ",")
#head(df)
colnames(df)
nameofvaccines <- c("Covaxin","CoviShield","Total Doses")#Will be in the legend

#Bar plot to display the no. of people vaccinated per state
barplot(df$Total.Individuals.Vaccinated,names.arg = df$State,xlab = "States",ylab = "Total Individuals Vaccinated",col = "green",main = "Vaccinated Per State Chart(Jatin Dhall)")

#Bar plot to display the no. of people vaccinated per day
barplot(df$Total.Individuals.Vaccinated,names.arg = df$Date,xlab = "Date",ylab = "Total Individuals Vaccinated",col = "green",main = "Vaccinated Per Day Chart(Jatin Dhall)")

#Getting the total no. of males, females and transgenders
male <- sum(df$Male)
female <- sum(df$Female)
transgender <- sum(df$Transgender)
transgender

#Creating a pie chart to show how many male, female and transgenders are vaccinated
x <- c(male,female,transgender)
label <- c('Male(Jatin)','Female','Transgender')
colors <- c('blue','green','red')
pie(x, labels = label, main = "Gender Vaccination classification",col = colors) 
legend("topright", label, cex = 0.8, fill = colors)

#DERIVED DATA(Total Vaccine Units Used per day)
df$Total_VaccineUnits <- df$Total.Covaxin + df$Total.CoviShield
head(df)
barplot(df$Total_VaccineUnits,names.arg = df$Date,xlab = "Date",ylab = "Total Vaccine Units",col = "blue",main = "Vaccines per day(Jatin Dhall)")

#No. of rows in the dataset = no. of days 
no_day <- nrow(df)
days <- c()
for (val in 1: no_day)
{
  days <- append(days,val)
}
#Displaying the correlation of between days and total individual vaccinated
print("Correlation between days and no. of individuals vaccinated is : (Jatin Dhall)")
cor(df$Total.Individuals.Vaccinated,days,use = "complete.obs")


#Regression on these variables :-
plot(df$Total.Individuals.Vaccinated,days)
lm(df$Total.Individuals.Vaccinated~days,data = df)
abline(lm(df$Total.Individuals.Vaccinated~days,data = df))

#Line Plots and Regression
#CODE BY JATIN DHALL
#Using EuStockMarkets dataset
EuStockDF <- as.data.frame(EuStockMarkets)
#For one line in the graph
#ggplot(EuStockDF,aes(x = c(1:nrow(EuStockDF)),y = DAX)) + geom_line(colour = "light blue") + labs(x = "Time", y = "Stocks")
#X axis displays the row number and y axis displays the DAX

dax_smi_plot <- ggplot() + 
                    geom_line(data = EuStockDF,aes(x = c(1:nrow(EuStockDF)),y = DAX),size = 1.5,colour = "light blue") + 
                    geom_line(data = EuStockDF,aes(x = c(1:nrow(EuStockDF)),y = SMI),size = 1.5,colour = "red") + 
                    labs(x = "Time", y = "Stocks") 
print(dax_smi_plot)

#For all attributes to be included in the graph
all_stocks <- ggplot() +
  geom_line(data = EuStockDF,aes(x = c(1:nrow(EuStockDF)),y = DAX),size = 1.5,colour = "light blue") + 
  geom_line(data = EuStockDF,aes(x = c(1:nrow(EuStockDF)),y = SMI),size = 1.5,colour = "red") + 
  geom_line(data = EuStockDF,aes(x = c(1:nrow(EuStockDF)),y = CAC),size = 1.5,colour = "purple") + 
  geom_line(data = EuStockDF,aes(x = c(1:nrow(EuStockDF)),y = FTSE),size = 1.5,colour = "green") + 
  labs(x = "Time", y = "Stocks") 
            
legend_stocks <- all_stocks + 
                  xlab("Days") +
                  ylab("Price") + 
                  ggtitle("Eu Stocks")
print(legend_stocks)
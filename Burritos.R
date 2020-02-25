# Create a variable called ritos and store your data in it 
ritos <- read.csv("/home/sunbeam/R_loveeshbhat_imarticus/programs/day14test/Burritos_Data.csv")
ritos

# Print first 6 rows of ritos
ritos[1:6,]

# Print the dimensions of ritos
dim(ritos)

# Filter the data using varibale nonSD == 0, store it in ritos and print the dimension of this dataset 
library(dplyr)
ritos <- filter(ritos, NonSD == 0)
dim(ritos)

# Print the number of unique values for Burrito variable
unique(ritos$Burrito)

# Using the Burrito variable, filter data for california and print the number of unique values for the same.
# Hint : use grepl to filter ‘california’
a <- filter(ritos, grepl('california', ritos$Burrito)) 
a
length(unique(a$Burrito))

# Select the variables Location and Yelp and print the first 6 rows
b <- ritos[c(1,6)]
b[1:6,]

# Select columns with Burito ratings i.e. from Tortilla to Wrap and print the first 6 rows
c <- select(ritos, Tortilla:Wrap)   
c[1:6,]

# Create a new data frame df from ritos, select only columns ‘Taste’, ‘Rec’, ‘Cost’, ’Volume
df <- select(ritos,Taste,Rec,Cost,Volume) 
df

# Create a new column(‘Cost_vol’) in the same dataframe df using the formula(Cost/Volume), print the first 6 
# rows of the df

Cost_vol <- ritos$Cost/ritos$Volume
d <- cbind(Cost_vol,df)
d[1:6,]

# Plot(dotplot) Taste on y axis and Cost_vol on x axis for df and colour code by variable Rec

library(ggplot2)
ggplot(df, aes(x = Cost_vol, y = Taste))+ geom_point(aes(colour = Rec))

# Select burrito rating variable and recommendation(select variable rec and Tortilla to Taste), store this in a new 
# variable called ing and print the first 6 rows

library(data.table)
ing <- select(ritos,c(Rec,Tortilla:Taste))
head(ing)

# Convert the above data to long format and store in variable df.melt; use ‘Rec’ and ‘Taste’ as your id variables, 
# print the structure of this dataset

library(UsingR)
library(reshape2)
df.melt<-melt(ing, id.vars=c('Rec','Taste'))
str(df.melt)

# Plot(ggplot and geom_point) the above dataset using x variable ‘Taste’ and y variable ‘Value’

ggplot(df.melt, aes(x = Taste, y = value)) + geom_point()

# Create a facet_wrap of df.melt use x-axis=“Taste”, y-axis=“Value” and colour = “variable”, use geom_point, add a 
# smoother(lm) using geom_smooth, colour the smoother in “black”, give the x axis label as ‘Burrito Qulaity’ and y-axis
# label as ‘score’

ggplot(df.melt, aes(x = Taste, y = value, colour = variable)) + 
  geom_point() + geom_smooth(method='lm', color='black') + facet_wrap(~variable) +
  labs(x='Burrito Quality', y='Score')
# Clear the R workspace
rm(list=ls())

# Set work directory
setwd(dirname(sys.frame(1)$ofile))

# Load libraries
library(data.table) # this is for quick load data
library(stringr) # this is for convinient work with strings
library(rpart) # this is for building the decision tree

# Load data
train_set<-as.data.frame(fread(input = 'training.txt',sep=' ',sep2=":",header = F))
test_set<-as.data.frame(fread(input = 'testing.txt',sep=' ',sep2=":",header = F))
names_data<-names(test_set)

# Data preparation
# Here we delete indexes of cells. For our targets they don't need.
train_set<-cbind.data.frame(as.character(train_set[,1]),apply(train_set[,-1],2,function(str) {
  str<-str_split(str,":",simplify = T)
  str<-as.numeric(str[,2])
  }))

# Set the name for first column of train_set
names(train_set)<-c("class",names(test_set))

test_set<-cbind.data.frame(apply(test_set,2,function(str) {
  str<-str_split(str,":",simplify = T)
  str<-as.numeric(str[,2])
}))

# Fit model
model<-rpart(train_set$class~.,
               data=as.data.frame(train_set[,-1]),
               method = "class",
               parms=list(split = "gini"),
              control=list(cp = 1e-3))
pr_train<-predict(object=model, newdata=train_set[,-1],
                    type = "class")
ac_train<-mean(pr_train==train_set$class)
print(ac_train)


pr_test<-as.numeric(predict(object=model, newdata=test_set,
                            type = "class"))

fwrite(x=data.table(pr_test) ,file='result.txt',col.names = F)


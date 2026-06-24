# inputting the data
#setwd("~/Library/Mobile Documents/com~apple~CloudDocs/medicine/intercalation/R")
diabetes <- read.csv("diabetes.csv")
# initial exploration
summary(diabetes)
table(diabetes[,9])
table(diabetes$Outcome)
table(diabetes$Pregnancies)
pairs(diabetes)
dim(diabetes)
diabetes[,1:8]
pairs(diabetes[,1:8])
# cleaning the data
diabetes[,9] <- as.factor(diabetes[,9])
pairs(diabetes[,1:8], col=diabetes[,9])
colSums(diabetes[,2:8] == 0)
diabetes[,2:8][diabetes[,2:8] == 0] <- NA
head(diabetes)
pairs(diabetes[,1:8], col=diabetes[,9])
# further exploration
plot(BMI~Glucose, data = diabetes, col=Outcome, pch=19)
boxplot(Glucose~Outcome, data = diabetes)
boxplot(BMI~Outcome, data = diabetes)
plot(BMI~SkinThickness, data = diabetes, col=Outcome, pch=19)
boxplot(SkinThickness~Outcome, data = diabetes)

# linear models (regression)
plot(BMI~SkinThickness, data = diabetes, pch=19,
     xlim=c(0,100), ylim=c(0,80))
abline(lm(BMI~SkinThickness, data = diabetes))
summary(lm(BMI~SkinThickness, data = diabetes))
summary(lm(BMI~SkinThickness+BloodPressure+Glucose+Age, data = diabetes))
# linear models by factor
diabetes_D<-subset(diabetes,Outcome=="1")
diabetes_ND<-subset(diabetes,Outcome=="0")
plot(BMI~SkinThickness, data = diabetes, col=Outcome, pch=19,
     main="BMI against Skin Thickness",
     xlab="Skin Thickness(mm)")
legend("topleft", col=c("#d1446a","black"), c("Diabetes","No Diabetes"),
       pch=c(19,19))
abline(lm(BMI~SkinThickness, data = diabetes_D), col="#d1446a")
abline(lm(BMI~SkinThickness, data = diabetes_ND), col="black")
summary(lm(BMI~SkinThickness, data = diabetes_D))
summary(lm(BMI~SkinThickness, data = diabetes_ND))
summary(lm(BMI~SkinThickness+BloodPressure+Glucose+Age+Outcome,
           data = diabetes))

#library("ggplot2")
install.packages("tidyverse")
library("tidyverse")

# grammar of graphic
ggplot(data = diabetes, aes(SkinThickness, BMI)) +
  geom_point() +
  stat_smooth(method=lm, se=FALSE)   # no need to include the formula here as we've already defined the x and y in the aes(). 










library(OpenImageR)  
library(imageData)
#library(R.matlab)
library(matlib)
#install.packages("glmnet")
library(glmnet)
#install.packages("caret")
library(caret)



### LOAD DATA
fashion = read.csv("./archive/fashion-mnist_test.csv", header = TRUE)

end = ncol(fashion)
# test an image
img <- matrix(as.matrix(fashion[80,2:end]), nrow = 28, ncol = 28)
imageShow(img)


## separate labels
label = 1  ##first column
response <- fashion[,label]
fashion <- fashion[,-label]



p <- dim(fashion)[2]      #Number of parameters
n <- dim(fashion)[1]      #Number of observations 



####################
####  B-splines ####
####################

library(splines)
x = seq(0,1,length.out = p)

#### Using 10 knots
k=10
knots = seq(0,1,length.out = k)  ##interior knots only  
B = bs(x, knots = knots, degree = 3)[,1:(k+2)]  ###  degree 3 for cubic polynomial


Bcoef = matrix(0,dim(fashion)[1],k+2)
for(i in 1:dim(fashion)[1])
{
  Bcoef[i,] = solve(t(B)%*%B)%*%t(B)%*%t(as.matrix(fashion[i,]))
}

Bsp_model = cbind.data.frame(Bcoef,response)  



####
### Split train/test 80%/20%
set.seed(12345)
s = sample.int(n,n*0.8, replace=FALSE)  
train = Bsp_model[s,]
test = Bsp_model[-s,]


param <- dim(train)[2] -1
label <- ncol(train)
ntr <- dim(train)[1]
nts <- dim(test)[1]

x_train = as.matrix(train[,1:param],ntr,param)
x_test = as.matrix(test[,1:param],nts,param)
y_train = train[,label]
y_test = test[,label]




### Lasso B-splines
lasso = cv.glmnet(x_train, y_train, family="multinomial", alpha = 1, intercept = FALSE)
lambdal = lasso$lambda.min
lambdal
coef.lasso = matrix(coef(lasso, s = lambdal)) ##[2:(p+1)]
#coef(lasso, s = lambdal)

lasso = glmnet(x_train, y_train, family = "multinomial", alpha = 1, intercept = FALSE)
plot(lasso, xvar = "lambda", label = TRUE, main="B-splines" )
abline(v = log(lambdal))

y_lasso = predict(lasso, x_test, s = lambdal, type="class")
mse_lassob = sum((y_test==y_lasso)^2)/length(y_test)
mse_lassob

y_true = as.factor(y_test)
y_pred = as.factor(y_lasso)

cfm <-confusionMatrix(y_pred, y_true)
as.table(cfm)


##coef(lasso, s = lambdal)



####################################################################
####################
####    PCA     ####
####################

### Split train/test 80%/20%
#reuse s, same split as before
trainp = fashion[s,]
testp = fashion[-s,]
x_trainp = as.matrix(trainp,dim(trainp)[1],dim(trainp)[2])
x_testp = as.matrix(testp,dim(testp)[1],dim(testp)[2])
#y_trainp = response[s,]  ### same as before
#y_testp = response[-s,]

pca_res <- prcomp(x_trainp, rank. = 12)  ###, scale=TRUE)  ## no need to scale?
#pca_res$x


np <- dim(pca_res$rotation)
x_trainrot = x_trainp%*%as.matrix(pca_res$rotation,np[1],np[2])
x_testrot = x_testp%*%as.matrix(pca_res$rotation,np[1],np[2])

#all.equal(as.matrix(pca_res$x), x_trainrot)

###################
### Lasso PCA
lassop = cv.glmnet(x_trainrot, y_train, family="multinomial", alpha = 1, intercept = FALSE)
lambdalp = lassop$lambda.min
lambdalp
coef.lassop = matrix(coef(lassop, s = lambdalp)) ##[2:(p+1)]
#coef(lassop, s = lambdalp)

lassop = glmnet(x_trainrot, y_train, family = "multinomial", alpha = 1, intercept = FALSE)
plot(lassop, xvar = "lambda", label = TRUE, main="PCA" )
abline(v = log(lambdalp))

y_lassop = predict(lassop, x_testrot, s = lambdalp, type="class")
mse_lassop = sum((y_test==y_lassop)^2)/length(y_test)
mse_lassop

y_true = as.factor(y_test)
y_pred = as.factor(y_lassop)

cfmp <-confusionMatrix(y_pred, y_true)
as.table(cfmp)




 
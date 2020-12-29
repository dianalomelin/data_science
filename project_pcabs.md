<div class="centered">
<img src="images/fashion.JPG?raw=true" style="width:100%">
</div>

## PCA vs B-splines dimension reduction in a fashion data set

**Project description:** I've been recently learning about regularization methods paired with dimensionality reduction algorithms like PCA and B-splines. I found this collection of images intended as a substitute to the MNIST handwritten digits used extensively in the Data Science community and I wanted to apply these algorithms comparatively to classify these images.
The Fashion-MNIST is a dataset of Zalando's fashion articles images. Each example is a 28 x 28 grayscale image, associated with a label of 10 classes. Learn more about this dataset from Kaggle [here](https://www.kaggle.com/zalando-research/fashionmnist?select=fashion-mnist_train.csv).

### 1. Dimensionality Reduction and Regularization.
When presented with a data set that has many dimensions it becomes difficult to process it. High-dimensional data usually has a low dimensional structure where the relevant information is contained in fewer dimensions that can be extracted to conduct further analysis, the rest are treated as non-informative and noise. One common approach to dimensionality reduction is Principal Component Analysis (PCA), which transforms the original data projecting it onto a set of orthogonal axes. We select the vectors that have the greatest explained variance and discard the rest.

Another approach is to fit a polynomial regression using splines which are linear combinations of piecewise polynomial functions that allow for local fitting. Basis splines are computationally more efficient than splines and since any spline function can be expressed as a linear combination of B-splines, they are a preferred method.

Similarly, regularization can help adjust model complexity to avoid overfitting allowing to remove coefficients that have little information about the response variable. One such form of regularization, the LASSO (Least Absolute Shrinkage and Selection Operator) shrinks large coefficients and truncates small coefficients to zero.


### 2. Experiment
I used the test data set of 10000 observations for this experiment, split in 80/20% for training/testing. Combining dimensionality reduction and regularization methods, we deploy simpler models that achieve sparsity and shrinkage. For the first method, I used B-splines with 10 knots to reduce dimensionality and then applied LASSO regularization. Each observation is assigned one of the following labels:
- 0 T-shirt/top
- 1 Trouser
- 2 Pullover
- 3 Dress
- 4 Coat
- 5 Sandal
- 6 Shirt
- 7 Sneaker
- 8 Bag
- 9 Ankle boot

 

```{r}
library(splines)
x = seq(0,1,length.out = p)


#### B-splines using 10 knots
k=10
knots = seq(0,1,length.out = k)  ##interior knots only  
B = bs(x, knots = knots, degree = 3)[,1:(k+2)]  ###  degree 3 for cubic polynomial

Bcoef = matrix(0,dim(fashion)[1],k+2)
for(i in 1:dim(fashion)[1])
{
  Bcoef[i,] = solve(t(B)%*%B)%*%t(B)%*%t(as.matrix(fashion[i,]))
}

Bsp_model = cbind.data.frame(Bcoef,response)  

```

```{r}
### Lasso B-splines
lasso = cv.glmnet(x_train, y_train, family="multinomial", alpha = 1, intercept = FALSE)
lambdal = lasso$lambda.min
lambdal
coef.lasso = matrix(coef(lasso, s = lambdal))

lasso = glmnet(x_train, y_train, family = "multinomial", alpha = 1, intercept = FALSE)
plot(lasso, xvar = "lambda", label = TRUE, main="B-splines" )
abline(v = log(lambdal))
```

Similarly, I applied Principal Component Analysis and kept the 12th largest eigenvectors to do a LASSO regularization with them. 
```{r}
## Principal Components
pca_res <- prcomp(x_trainp, rank. = 12) 

np <- dim(pca_res$rotation)
x_trainrot = x_trainp%*%as.matrix(pca_res$rotation,np[1],np[2])
x_testrot = x_testp%*%as.matrix(pca_res$rotation,np[1],np[2])
```
``` {r}
### Lasso PCA
lassop = cv.glmnet(x_trainrot, y_train, family="multinomial", alpha = 1, intercept = FALSE)
lambdalp = lassop$lambda.min
lambdalp
coef.lassop = matrix(coef(lassop, s = lambdalp))


lassop = glmnet(x_trainrot, y_train, family = "multinomial", alpha = 1, intercept = FALSE)
plot(lassop, xvar = "lambda", label = TRUE, main="PCA" )
abline(v = log(lambdalp))
```

### 3. Results
The following plots show the regularization for the reduced coefficients on each algorithm and for the different response values at different lambdas - the tunning parameter that controls sparsity.

<div class="row">
  <div class="column" float="left" >
    <img src="images/bsp0.png?raw=true" width="450" height="250">
  </div>
  <div class="column" float="left">
    <img src="images/pca0.png?raw=true" width="450" height="250">
  </div>

</div>

<div class="row">
  <div class="column" float="left" >
    <img src="images/bsp1.png?raw=true" width="450" height="250">
  </div>
  <div class="column" float="left">
    <img src="images/pca1.png?raw=true" width="450" height="250">
  </div>

</div>

<div class="row">
  <div class="column" float="left" >
    <img src="images/bsp2.png?raw=true" width="450" height="250">
  </div>
  <div class="column" float="left">
    <img src="images/pca2.png?raw=true" width="450" height="250">
  </div>

</div>

<div class="row">
  <div class="column" float="left" >
    <img src="images/bsp3.png?raw=true" width="450" height="250">
  </div>
  <div class="column" float="left">
    <img src="images/pca3.png?raw=true" width="450" height="250">
  </div>

</div>

<div class="row">
  <div class="column" float="left" >
    <img src="images/bsp4.png?raw=true" width="450" height="250">
  </div>
  <div class="column" float="left">
    <img src="images/pca4.png?raw=true" width="450" height="250">
  </div>

</div>
<div class="row">
  <div class="column" float="left" >
    <img src="images/bsp5.png?raw=true" width="450" height="250">
  </div>
  <div class="column" float="left">
    <img src="images/pca5.png?raw=true" width="450" height="250">
  </div>

</div>
<div class="row">
  <div class="column" float="left" >
    <img src="images/bsp6.png?raw=true" width="450" height="250">
  </div>
  <div class="column" float="left">
    <img src="images/pca6.png?raw=true" width="450" height="250">
  </div>

</div>

<div class="row">
  <div class="column" float="left" >
    <img src="images/bsp7.png?raw=true" width="450" height="250">
  </div>
  <div class="column" float="left">
    <img src="images/pca7.png?raw=true" width="450" height="250">
  </div>

</div>

<div class="row">
  <div class="column" float="left" >
    <img src="images/bsp8.png?raw=true" width="450" height="250">
  </div>
  <div class="column" float="left">
    <img src="images/pca8.png?raw=true" width="450" height="250">
  </div>

</div>

<div class="row">
  <div class="column" float="left" >
    <img src="images/bsp9.png?raw=true" width="450" height="250">
  </div>
  <div class="column" float="left">
    <img src="images/pca9.png?raw=true" width="450" height="250">
  </div>

</div>


We can also review the Confusion Matrix for both methods and their MSE on the test data set. We observe that the PCA method achieves better accuracy than B-splines. 
```{r}
y_lasso = predict(lasso, x_test, s = lambdal, type="class")
mse_lassob = sum((y_test==y_lasso)^2)/length(y_test)
mse_lassob

y_true = as.factor(y_test)
y_pred = as.factor(y_lasso)

## Confusion Matrix
cfm <-confusionMatrix(y_pred, y_true)
as.table(cfm)
```

<div class="row">
  <div class="column" float="left" >
    <img src="images/cm_bsp.JPG?raw=true" width="450" height="250">
  </div>
  <div class="column" float="left">
    <img src="images/cm_pca.JPG?raw=true" width="450" height="250">
  </div>

</div>


MSE B-Splines: 0.5905

MSE PCA: 0.752
### 4. Conclusions

The algorithms presented in this exercise were able to reduce dimensionality of the data set of 10000 images and further select only the most important ones applying LASSO regularization. The PCA method performed better than B-splines suggesting that this data set might be better described through the eigenvectors that explain their variance rather than fitting a polynomial regression.

I'll be interesting to observe how the LASSO regularization alone performs as well as PCA on its own as an extension.

You can find the R code [here](/code/pca_bsplines_classification_fashion.R).


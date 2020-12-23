## PCA vs B-splines dimension reduction in a fashion data set

**Project description:** I've been recently learning about regularization methods paired with dimensionality reduction algorithms like PCA and B-splines. I found this collection of images intended as a substitute to the MNIST handwritten digits used extensively in the Data Science community and I wanted to apply these algorithms comparatively to classify these images.
The Fashion-MNIST is a dataset of Zalando's fashion articles images. Each example is a 28 x 28 grayscale image, associated with a label of 10 classes. Learn more about this dataset from Kaggle [here](https://www.kaggle.com/zalando-research/fashionmnist?select=fashion-mnist_train.csv).

### 1. Dimensionality Reduction and Regularization.
When presented with a data set that has many dimensions it becomes difficult to process it. High-dimensional data usually has a low dimensional structure where the relevant information is contained in fewer dimensions that can be extracted to conduct further analysis, the rest are treated as non-informative and noise. One common approach to dimensionality reduction is Principal Component Analysis (PCA), which transforms the original data projecting it onto a set of orthogonal axes.

Another approach is to fit a polynomial regression using splines which are linear combinations of piecewise polynomial functions that allow for local fitting. Basis splines are computationally more efficient than splines and since any spline function can be expressed as a linear combination of B-splines, they are the preferred method.

Similarly, regularization can help adjust model complexity to avoid overfitting allowing to remove coefficients that have little information about the response variable. One such form of regularization, the LASSO (Least Absolute Shrinkage and Selection Operator) shrinks large coefficients and truncates small coefficients to zero.


### 2. The experiment
Combining dimensionality reduction and regularization methods, we deploy simpler models that achieve sparcity and shrinkage. To compare both methods, I used B-splines with 10 knots to reduce dimensionality and then applied LASSO regularization. Similarly, I applied Principal Component Analysis and kept the 12th largest eigenvectors to do a LASSO regularization with them. 

 

```javascript
if (isAwesome){
  return true
}
```

### 3. The results
The following plots show the regularization for the reduced coefficients on each algorithm and for the different response values.

<img src="images/dummy_thumbnail.jpg?raw=true"/>

### 4. Conclusions

Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. 

You can find the R code [here](/code/pca_bsplines_classification_fashion.R).

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

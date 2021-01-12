<div class="centered">
<img src="images/logo_ranfortraff.JPG?raw=true" style="width:100%">
</div>


## Traffic Accident Severity Prediction

### Using Random Forest Classification to predict severity of traffic accidents.

**Project description:** We aim to create an analytic model to predict the severity of a car accident by identifying similar conditions between accidents of different severities. We chose to use Random Forest Classifiers from Python's Scikit-learn library and compared the accuracy of a single CART model versus a Random Forest.
This project was presented in a grad school Machine Learning class with another team member. 


### 1. Problem Definition
Every year in the United states, nearly 40,000 people lose their lives in care related accidents. By predicting the severity of car accidents, the Department of Transportation and other related government agencies can better understand the underlying conditions that contribute to the severity of a car accident. This can lead to safer road designs, better driver education, and overall decrease in the severity of car accidents across the country. Additionally, we believe the self-driving car industry and route finding applications, such as Waze and Google Maps, could utilize our model to plan for low-risk routes based on safety.

### 2. Data Source
We selected a public dataset from Kaggle.com to train our model called US Accidents.

https://www.kaggle.com/sobhanmoosavi/us-accidents

File name: US_Accidents_Dec19.csv (1.05 GB - ~3M records). 
The dataset is a large-scale publicly available database that includes data on location, time, natural language description of event, weather, period-of-day, and relevant points-of-interest. 


### 3. Model Selection
We chose to implement a Random Forest model to predict the severity of a traffic accident due to its ability to handle multi-class classification problems and its easily interpreted results. Our implementation makes use of the entropy method for information gain and uses the Out-Of-Bag (OOB) metric to determine accuracy for the model.

### 4. Data Collection and Preprocessing
After reviewing the available features from our dataset, we removed those that had no predictive power, such as ID, Source and TMC. We then decided to drop the features that had a high percentage (50% or more) of invalid inputs, for example, Wind_Chill and Precipitation. Additionally, we removed features that were very similar, such as the three Twilight features.

**1. Balanced Sampling**
When inspecting the dataset, we noted an imbalance with the following count of samples per ‘Severity’ value:

Severity | Count
--------- | -------------
1 |     968
2 | 1993410
3 |  887620
4 |   92337
Total | 2974335

In order to balance the data, we first identified the smallest category, severity 1, and included all of those samples. Then we added additional samples from the population with severities of 2,3,4 until we had 10,000 samples total.

**2. Correlation**
With the remaining features, we checked for correlation and only found one highly correlated pair: ‘Bump’ and ‘Traffic_Calming’. We removed the ‘Traffic_Calming’ feature from our samples. It also showed that a couple of the binary features had no predicting power since all samples had the same value (‘Turning_Loop’ and 'Roundabout') and so we removed that as well.


<div class="centered">
<img src="images/ranfor/corr.jpg?raw=true">
</div>


**3. Outliers**
We reviewed all continuous features and found that most of them had outliers present. However, since our dataset was already much more compact and our sample was only 0.3% of the original file, we decided to keep all data points to train and test our models and see what results we would get.

<div class="centered">
<img src="images/ranfor/outliers.JPG?raw=true" width="500" height="500">
</div>

**4. Imputation**
Since the raw data file had over 3 million records, we had more than enough data to train our model on without needing any imputation methods.

**5. Variable Selection**
Due to the presence of both continuous, and categorical features, we split our features into the following groups for preprocessing:
* Response variable:
As stated before, our model is trying to predict the severity of the accident, determined as an integer between 1 (less severe) and 4 (more severe) in the feature ‘Severity’.
* Continuous Features:
The continuous features were not standardized since Decision Trees can handle them correctly without scaling.
* Categorical Features:
We applied one hot encoding to our categorical features for our model to make decision splits on them effectively. One downside of this approach is that we significantly increased the number of variables in our model. This not only increases the complexity, but can create biases in favor of attributes with more categories.[5] From the splitting algorithm’s point of view, all the dummy variables are independent. If the tree decides to make a split on one of the dummy variables, the gain in purity per split is marginal. As a result, the tree is unlikely to select one of the dummy variables closer to the root as the best split attribute. [8]
* Binary Features:
We processed all binary features and converted them to integer values since they had different text inputs for their True/False values.
* Features to transform:
We believe that the time of day an accident occurs as well as its duration can be important factors when predicting severity. To test this, we transformed the ‘Start_Time’ and ‘End_Time’ features into an ‘Hour’ feature to represent when the accident happened (0-23) and a ‘Duration’ feature calculated as (End_Time – Start_Time).

<div class="centered">
<img src="images/ranfor/features.JPG?raw=true">
</div>

**6. Interactions**
When plotting the continuous features, we could not find any evident relationship that suggests an interaction term would be beneficial. We decided to keep all of our features linear.

<div class="centered">
<img src="images/ranfor/pairwise.jpg?raw=true" width="500" height="500">
</div>

**7. Experiments**
Our experiments consist of varying the number of trees in our Random Forest implementation, as well as the maximum depth of the trees, influencing both Random Forest and Decision Tree models. We anticipate that both random forests and single decision trees would benefit from additional depth up to a certain point and that the random forests models should outperform the single decision trees on the test set.

**8. Train-Validation-Test Set Split**
Our random forest model implements the OOB (Out-Of-Bag) algorithm that literature suggests is nearly identical to that obtained by N-fold cross-validation. Scikit-learn allows hyperparameters to implement OOB and takes care of bootstrapping. For the single Decision Tree models, we used the train_test_split function and reported the accuracy by predicting labels on the test set.

### 5. Model Fitting
We implemented and compared the following models:
1.  Decision Tree from Scikit-learn
2. Random Forest from Scikit-learn
We set the following parameters to Scikit-learn RandomForestClassifier:
bootstrap=True, criterion='entropy', oob_score = True


### 6. Model Validation
1. Accuracy metrics
The following table shows the best accuracy achieved by each model after tuning with the corresponding parameters:

MODEL | FOREST SIZE | MAX DEPTH | ACCURACY
--------- | ------------- | --------- | ----------
Decision Tree |   0| 5| 0.585
Random Forest |  30|30| 0.998

We are satisfied that given our pre-processing of the data we were able to achieve 99.8% accuracy using Sci-kit learn’s implementation of random forest. This validates that we chose the correct model for this problem and pre-processed our data accordingly.

2. Visualization of results

<div class="centered">
<img src="images/ranfor/chartDT.jpg?raw=true">
</div>

<div class="centered">
<img src="images/ranfor/chartRF.jpg?raw=true">
</div>

Sci-kit learn’s implementation of random forest increased in accuracy as more trees were added to the forest and as more depth were added to each tree, up until a forest size of 30 and tree depth of 30. This is in line with our expectations of model behavior.


### 7. Model Prediction
Based on the feature analysis of the random forest, the most important feature is the Distance attribute accounting for 14% of the predictive power of the model. This attribute represents the length of road that was impacted by the accident in miles. To verify the impact of this attribute, we took an existing record from our test set that had a severity of 4 and a distance value of .81 and tested the prediction of our model on that same sample before and after reducing its distance to .1. Our model correctly predicted a severity of 4 before we changed the distance attribute of the sample. After reducing the distance attribute to .1, our model changed its prediction to a severity of 3, clearly showing that reducing the distance of an accident reduces its severity.

<div class="centered">
<img src="images/ranfor/importance.jpg?raw=true" width="500" height="300">
</div>

### 8. Evaluation and Final Results
It was surprising to find that the accuracy of Sci-kit learn’s implementation of single decision trees did not increase significantly when we added more depth. This can be explained by the additional depth leading to overfitting causing worse performance on the test sets. However, we are quite happy with the 99.8% accuracy score achieved by Sci-kit learn’s random forest, as well as the interpretable feature importance that allows us to clearly explain what factors impact the severity of accidents. Additionally, we were pleased to see that both of the transformed features that we came up with were among the top 10 most important features (Hour, Duration).
The following are potential next steps that could be implemented in the future to expand upon our implementation:
- Since the model performance was sensitive to sample dataset initialization, we could try several different samples.
- Scale numerical features to see if it helps the algorithm to converge faster or perform better.
- A broader variety of hyper parameter tuning.
- Consider an implementation for pruning the tree to avoid overfitting.
- Consider implementing gini-index as an alternative for split criteria on Decision Tree.

### 9. Conclusions
In summary, we built a Random Forest model to predict the severity of a traffic accident, taking into account 27 different features of the accident such as location, weather and length of road that was impacted. After pre-processing and balancing our data, we were able to tune a random forest model that achieved 99.8% accuracy. Our analysis found that the distance the accident covered was the best predictor of the severity of the accident, as well as the location (longitude/latitude), temperature, air pressure, humidity, time of day etc. The features identified in this analysis can be used by governments to help repair and design safer roadways, as well as help route finding algorithms construct optimal routes based on safety.

You can find the code [here](/code/randfortraff).

[Back](/index)


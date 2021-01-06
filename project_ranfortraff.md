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
1 | 968
2 | 1993410
3 | 887620
4 | 92337
Total | 2974335

In order to balance the data, we first identified the smallest category, severity 1, and included all of those samples. Then we added additional samples from the population with severities of 2,3,4 until we had 10,000 samples total.

**2. Correlation**
With the remaining features, we checked for correlation and only found one highly correlated pair: ‘Bump’ and ‘Traffic_Calming’. We removed the ‘Traffic_Calming’ feature from our samples. It also showed that a couple of the binary features had no predicting power since all samples had the same value (‘Turning_Loop’ and 'Roundabout') and so we removed that as well.


<div class="centered">
<img src="images/corr.png?raw=true" width="300" height="300">
</div>


**3. Outliers**
We reviewed all continuous features and found that most of them had outliers present. However, since our dataset was already much more compact and our sample was only 0.3% of the original file, we decided to keep all data points to train and test our models and see what results we would get.

<div class="centered">
<img src="images/outliers.jpg?raw=true" width="300" height="150">
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
<img src="images/features.jpg?raw=true" width="300" height="150">
</div>

**6. Interactions**
When plotting the continuous features, we could not find any evident relationship that suggests an interaction term would be beneficial. We decided to keep all of our features linear.

<div class="centered">
<img src="images/pairwise.png?raw=true" width="300" height="300">
</div>

**7. Experiments**
Our experiments consist of varying the number of trees in our Random Forest implementation, as well as the maximum depth of the trees, influencing both Random Forest and Decision Tree models. We anticipate that both random forests and single decision trees would benefit from additional depth up to a certain point and that the random forests models should outperform the single decision trees on the test set.
**8. Train-Validation-Test Set Split**
Our random forest model implements the OOB (Out-Of-Bag) algorithm that literature suggests is nearly identical to that obtained by N-fold cross-validation. Scikit-learn allows hyperparameters to implement OOB and takes care of bootstrapping. For the single Decision Tree models, we used the train_test_split function and reported the accuracy by predicting labels on the test set.




### 4. Conclusions

**Real-world epidemic studies**

The SIR Model can be useful to approximate the spread of a disease, but is based on an ideal scenario and depends on certain assumptions that will not apply to a real-life situation where many other complex factors are present, for example:
- Asymptomatic and mildly infectious people
- Incubation periods
- Different age groups with different immune responses
- Traveling individuals, births and deaths
- Hospital system capacity
When facing a pandemic, normally only the more severe cases seek help, which delays the detection and severity of the spread since the milder cases won’t get officially diagnosed. This might lead to public alarm since the severe cases are more likely to result in deaths. There’s also the issue of lack of accurate testing and its distribution on new diseases. Undoubtedly, the timeline of confirmed cases will be dependent on local testing policies and availability.
We can see the many challenges that a model will need to address to match official published numbers. But even if models are far from perfect, insights from mathematical modeling are vital
to ensuring that authorities can prevent as many deaths as possible and take preventive measures to avoid healthcare systems becoming overwhelmed.

**Future work**

With our current model, we could update variables to admit a different population size, a higher probability of infection, more days of being infectious, more initial kids that are infectious on Day 1 and even a larger area of infectious spread.
To improve the model, we could model weekends to allow for those 2 days of no exposure, we could expand to a larger physical area (beyond the 10 x 10 grid), and include compartments and attributes to model incubation periods, asymptomatic entities, traveling, mask use, etc. Another interesting experiment to model would be super-spreader events.

You can find the ARENA code [here](/code/simulationflu/PandemicSchool.doe).


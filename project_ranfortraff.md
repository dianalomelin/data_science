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
1. Balanced Sampling
When inspecting the dataset, we noted an imbalance with the following count of samples per ‘Severity’ value:

table

In order to balance the data, we first identified the smallest category, severity 1, and included all of those samples. Then we added additional samples from the population with severities of 2,3,4 until we had 10,000 samples total.

2. Correlation
With the remaining features, we checked for correlation and only found one highly correlated pair: ‘Bump’ and ‘Traffic_Calming’. We removed the ‘Traffic_Calming’ feature from our samples. It also showed that one of the binary features had no predicting power since all samples had the same value (‘Turning_Loop’) and so we removed that as well.

##################################


<div class="centered">
<img src="images/sim/day1.jpg?raw=true" width="300" height="150">
</div>





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


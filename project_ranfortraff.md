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
File name: US_Accidents_Dec19.csv (1.05 GB - ~3M records)
The dataset is a large-scale publicly available database that includes data on location, time, natural language description of event, weather, period-of-day, and relevant points-of-interest. 


### 3. Output Analysis
Our Agent Based model does not match the experiment of having 20 trials on the first day, since the entities move randomly inside the classroom, we cannot force a single contact time of Tommy with each kid per day. To approximate this behavior, we ran the simulation limiting it to 1 day, and found that keeping a Delay of 25 minutes will produce an average contact times (trials) of 20.6.

<div class="centered">
<img src="images/sim/day1.jpg?raw=true" width="300" height="150">
</div>

We can observe that the infected number of kids is close to our formula above for Day 1, including Tommy: 1.4
Similarly, if we run the simulation for only a couple of days, we obtain the following numbers. As before, we compare the average number of infected kids with our formula above, that gave us 1.94.

<div class="centered">
<img src="images/sim/day2.jpg?raw=true" width="300" height="150">
</div>

Running the simulation until there are no more Infectious or all kids have recovered:

<div class="centered">
<img src="images/sim/toend.jpg?raw=true" width="300" height="150">
</div>

We can observe that the average of infected and recovered kids is 5.16, and Susceptible kids that didn’t get sick average 15.84. The epidemic lasts 14.5 days maximum.
The following figure shows the kids that are still infectious on a certain day. By day 4, we subtract Tommy, who has recovered after 3 days. By day 5 we remove the kids that got infected on day 1.

<div class="centered">
<img src="images/sim/perday.jpg?raw=true" width="400" height="250">
</div>

One advantage to modeling with agents is that our simulation allows for other experiments when updating the delay time, closer to a real-life situation where kids would have multiple contact times through the day. If kept at 5 minutes, all or mostly all kids get sick and recover by day 8 maximum. 

<div class="centered">
<img src="images/sim/5min.jpg?raw=true" width="300" height="150">
</div>

If increased to 10 minutes, the simulation ends with most Infectious that Recovered, and a few Susceptible that didn't get it.

<div class="centered">
<img src="images/sim/10min.jpg?raw=true" width="300" height="150">
</div>

Conversely, if we change the delay to once a day (for 6 hours of school – delay of 360 minutes), almost no one else gets infected (since the contact times reduce to 2 or less considering the 10 x 10 area), and the epidemic ends when Tommy recovers, without infecting anyone else.
With the probability of success given, we expect roughly 100 contact times with an infectious for 2 kids to get infected. In any delay case, we observe that we get our first infectious (after Tommy) at around 65 contact times.

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


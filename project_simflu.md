<div class="centered">
<img src="images/logo_simflu.JPG?raw=true" style="width:100%">
</div>


## Classroom Flu Spread

### Analyzing the spread of infection in a hypothetical classroom.


**Project description:** The issue of the current pandemic is of paramount importance to societies around the globe as governments and healthcare industries try frantically to find successful treatments and make a viable vaccine that would allow us to return to our normal lives.

This project was presented in a grad school Simulation and Modeling class with another team member. We decided to work on the Flu Spread project for its current relevance, aiming to understand the basic factors involved in a setting as small as a classroom and to be able to reproduce those in a simulation. We came across the SIR model that was proposed in the 1920s and studied Agent Based models to conceive a solution that would combine the two approaches.

We used Arena Simulation Software v.16, licensed to us for academic purposes. You can find more about it [here](https://www.arenasimulation.com/)


### 1. Problem Definition
We start with a classroom of 21 elementary school kids. 20 of the kids are healthy (and susceptible to flu) on Day 1. Tommy (the 21st kid) walks in with the flu and starts interacting with his potential victims. To keep things simple, let's suppose that Tommy comes to school every day (whether or not he's sick) and will be infectious for 3 days. There are 3 chances for Tommy to infect the other kids on Days 1, 2, and 3. Suppose that the probability that he infects any individual susceptible kid on any of the three days is p = 0.02; and suppose that all kids and days are independent (so that you have i.i.d. Bern(p) trials).

### 2. Simulation Steps and Assumptions
1. This is a simple model demonstrating how to mimic the effect of an epidemic in a school setting. We used the SIR notation to denote Susceptible, Infectious and Recovered entities and we keep track of each group with counters.
Initially 20 kids are created and then they are assigned coordinates in the system, they will move around in the system having a nice day at school. The arrivals happen all together, since we are not modeling a process with service times, we disregard the effect of a distribution for arrivals.
Tommy, the infectious kid, is created and arrives at school too. He's placed in a random coordinate space and then the Susceptible kids next to him can become Infectious. They in turn can infect other Susceptible kids.
They go to school from 9:00 am to 3:00 pm. Then go home for 18 hours. We did not model weekends.
They remain sick for 3 days, starting the next day and then recover with immunity.
The simulation ends when there are no more infectious kids or all of them have recovered.
2. When the kids are initially created, they will choose a random starting location. The arrayed variable v Grid shows the SID status of the kid at each space in the grid. Susceptible kids are yellow, Infectious are red and Recovered are green. After choosing the location, the kid will check the v Grid to make sure that the chosen location is not already occupied. If it is, they will select another location.
3. The kids will delay for certain number of minutes at its initial location and then move to a new location within "v Step" (2) places of its current location. Through expressions we evaluate if the new location is off the grid and wrap it to the other side of the grid. These expressions evaluate the newly assigned location and reassign it if needed.
4. After the Susceptible kids have moved to their new location, it will then check if the new location is next to an Infectious (Search). If it is, the kid will become infectious with a certain probability (2%). Since their infectious period will begin the next day, we keep an attribute to flag them, and update their SID status to infectious when sent home
5. All kids pick a new random location and move to it if available. Then we'll check that it's still school hours and continue or send them home.
6. When sent home, we clear the grid and update counters and status. We also check if they're all recovered or no one is infectious anymore to end the simulation.
7. A simulation clock was created to keep track of periods.
8. A 10 x 10 variable array (v Grid) is used to define the coordinate space for the system (Classroom). This provides 100 spaces available for occupation. As the kids are created, they will set the value of the variable space they occupy to -1 for Susceptible, 1 for Infectious and 2 for Recovered. The entities will occupy the coordinates and look to move again. If they cannot find a space to move, they will repeat the attempt to move again.
 


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

[Back](/index)
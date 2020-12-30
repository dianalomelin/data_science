<div class="centered">
<img src="images/logo_saywh.JPG?raw=true" style="width:100%">
</div>

## #SayWhatYouMean. 
### A deeper look into a Twitter Account

**Project description:** 
#SayWhatYouMean is a project which aims to provide users with an interactive, visual representation of an individual Twitter handle. It does this by leveraging NLP (natural language processing), sentiment analysis, and CUSUM change detection. The most frequently discussed topics (hashtags) are first summarized to show the distribution of tweeted sentiment. An individual topic can be filtered further to show the individual tweets over time vs. the general population sentiment. Finally, CUSUM change detection is used to identify key areas of change in population sentiment.

This was a grad school project for a Data and Visual Analytics class in which members of the team web scraped tweets from @realDonaldTrump Twitter account and processed them in Python with the VADER sentiment model to get their sentiment scores. We selected only 4 of the most used hashtags from 2016 through May of 2020: #americafirst, #draintheswamp, #maga and #obamacare. We also applied exponential smoothing and CUSUM to visualize how the sentiment of this account tweets compares to the overall sentiment of the hashtags he tweets about. We created static files including those filtered tweets in JSON format. My contribution to the project was to put together the interactive visualizations using D3 to read and process the JSON files.

[Visit the interactive webpage](/code/saywhatyoumean/saywhatyoumean.html)

The UI for this project is geared towards helping consumers of Twitter quickly identify if they would find value from following a particular handle. One of the main graphics consisted of the unique hashtags used by the user historically along with the distribution of the sentiment for their tweets.

The next chart of interest in the UI is a line chart of general population sentiment for a given hashtag. This chart has many layers of information, so displaying everything
in a clean and meaningful was was especially challenging. Given the significant size of these datasets, the sentiment for each day was summarized as the average.

As with the top chart, the y axis was labeled in the same fashion to remain consistent with the messaging. Also, given the fact that population sentiment on average remains relatively neutral, the line is plotted as a fixed color without the sentiment color scale applied.

Quickly identifying significant changes in the population was a task given to the CUSUM analysis. While the underlying CUSUM analysis has already been done, the UI grants the ability to interactively choose the threshold where a change would be identified. This is accomplished through the use of a slider, where again numeric scales are removed. 

Sliding the threshold value from 1.2 to 3.8 doesn’t add much value, instead the range is labeled from less to more sensitive. As the slider moves the chart updates with shaded areas of positive and negative shift in the general public sentiment.

A major goal of this project was to effectively show how a user either influences or is influenced by public opinion. Exploring different sensitivities for change detection and seeing how these line up with the plotted individuals tweets helps to shed light on this question.



In order to obtain the raw twitter data for each of the 4 hashtags we chose to analyze, we utilized the twitterscraper libray. Read more about it at https://github.com/taspinar/twitterscraper.

For more detail on the sentiment model we used, please see https://github.com/cjhutto/vaderSentiment. 


# DE1 TERM PROJECT 1

## INTRODUCTION

 I put myself in the poisition of an economist who wants to analyze [WASH] https://en.wikipedia.org/wiki/WASH data to see if access to sanitation and hygiene has improved over the years. An economist would add 'open defecation' vaiable as it's sometimes not recorded under sanitiation facilities questionnaire. It is a large contributing factor to diseases such as chronic diarrhea and even reduced Height-For-Age Z score in children under the age of 5 hence holding a high significance level when regressed upon. Using a relational database would help investiagte the trends rapidly for example finding which countries are following certain WASH standards. They could narrow down their research and suggest targed-based policies. 

## Dataset Explanation

I chose my dataset via world bank data bank [here](https://databank.worldbank.org/source/world-development-indicators#). I chose my database to be 'World Development Indicators', then I simply selected all countries followed by extraction of variable data from series and lastly, I chose time period to be 2010 - 2020. 
This data set compromises of four tables. The table named 'handwash', to which the other tables are joined, explains the percentage of people having access to basic handwashing facilities in rural, urban and an accumalation of both areas. Similarly, 'drinkingwater' explains the percentage of people have basic facilities of drinking water and 'sanitation' explains percentage of people having access to basic sanitation facilities in all three categories. The term 'basic' defines the criteria all three WASH variables are assesed upon. The table 'opendefecate' shows the percentage of people in all three area divisions continuing to practice this due to lack of WASH availability. 

## Variable Description

### Please note that the following variables are similar for all four data sets

Variables | Description
------------ | -------------
country | Name of country
country_code | Abbreviation for Country Name
indicator | Explains the numerical reading i.e percentage
area_divide | A categorical variable created that informs if data is for Rural, Urban or Whole Country area.
series_code | A code for a particular data (ignore)
period | Year of data recorded
period_code | Character form for year
unique_code | A variable created by joing 'country_code', 'area_divide' and 'period_code'as the data lacked a primary key

### handwash table

Variable| Description
------------ | -------------
percent_basic_handwash | The percentage of people having access to basic handwash facilities such as a service with running water

### sanitization table

Variable| Description
------------ | -------------
percent_basic_sanitization | The percentage of people having access to basic sanitization facilities such as functional improved sanititation for both genders

### drinkingwater

Variable| Description
------------ | -------------
percent_basic_dwater | The percentage of people having access to basic drinking water facilities from an improved source

### opendefecate

Variable| Description
------------ | -------------
percent_opendef | The percentage of people practicing open defecation that is no method of disposal

## Data Cleaning
#### On Excel: 
To remove commas from the indicator coloumn input as it was interferring with loading data. 
To create a new categorical variable 'Area_Divide' so the data could be viewed methodically. 

#### On SQL:
Created the 'unique_code' on SQL with CONCAT command. It gave a primary key to the datasets and allowed smooth joining of datasets.
The null values in excel file were shown as '..' so SQL was used to load the coloumns as characters and defined all such values to be null. Followed by a conversion of the numerical values to integers. 

## Analytical Plan

![AnalyticalPlan](https://github.com/MahrukhKhan/DataEngineering1/blob/main/Term-Project-1/MahrukhKhan_AnalyticsPlan.png)


## ETL: Operational Layer
My operational layer consists of three tables that are joined to the handwash table. I ensured that coloumns in different datasets representing same data had consistent names. 
![EER](https://github.com/MahrukhKhan/DataEngineering1/blob/main/Term-Project-1/MahrukhKhan_Operational_Layer_EER.png)

To load the unique code in this operational layer, a variable 'unique_code' was created causing it to initially have null values. Once data was loaded in the tables from csv files, the sql safe updates command was turned off. Utilizing the uploaded variables, data for unique code was created through 'CONCAT' hence replacing all the null values. Then safe update command was turned back on.  

## ETL: Analytical Layer

A policy-maker would be interested in viewing data that allows them to narrow down research to create targets efficiently. I joined the 4 tables together on country, area_divide and period summed in 'unique_code' to create a denormalized central data warehouse. It neatly alligned the country description followed by the three WASH variables and open defecation for a very clear cut view. It is arranged so that for a particular year the user can compare the percentages for all variables in Rural/Urban areas in a country or view as a whole.  

![AnalyticalLayer](https://github.com/MahrukhKhan/DataEngineering1/blob/main/Term-Project-1/MahrukhKhan_DenormalizedTable_DTL.png)

## ETL: Data Mart

Three separate views were created using the denormalized central data warehouse. 

### 1.SelectCountry

The user can select a particular county to view the trend from 2010-2020 in WASH variables. If they write 'YES' in the second parameter, they can also view the data of open defecation for that particular country. This data mart helps in funneling analysis on a single country by only showing the total percentages hence getting a broader sense of the country's progress without going into unecessary details. 

### 2. FiftyPercentUrban

Urban areas continuously innovate to bring improvement in quality of life. Almost all have completely eradicated open defecation and are working towards providing better WASH services. The stored procedure will show the policy maker the list of countries progressing and allow comparison of whether the countries have been able to sustain their growth. 
To support the latter an option of adding range of years is given in the parameter to view lists of countries falling in this criteria for each year. 

### 3. OpenDefRural

As studies have shown, rural areas have not been able to sway away from the practice of open defecation due to a slower progress in improving their services. Open defecation largely reduces the quality of living due to the exposure of various diseases that comes with it. 
This view will allow an economist/policy maker to view the change in percentage points of open defecation over 10 years. By taking an average of the percentage of rural areas practicing open defecation in each year, it shows a 10 year trend as well as counts the number of countries practicing it in each year. From this data, extra information can be extracted to see which contries were able to eradicate open defecation and which are failing immensely. 

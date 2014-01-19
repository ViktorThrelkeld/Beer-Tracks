#User Stories

##Create, Update and Delete Data

####Create a Journal Entry
<pre>
  As a person who drinks,
  In order to add information about beer consumed,
  I want to be able to create an entry.
    
  *Usage: ruby beer.rb add "style" "beer_name" "oz" "cost"
   
  Acceptance Criteria:
  *I can create a data entry.
  *I cannot make an entry without all fields correctly filled in.
</pre>
***

####Update Data
<pre>
    As a person who may have entered in the wrong data,
    In order to keep accurate records,
    I want to be able to update data.
    
     *Usage: ruby beer.rb update "beer_name"
   
    Acceptance Criteria:
    *I can update data.
    *Prints out beer names and dates and asks which one to update.
    *I cannot make an entry without all fields correctly filled in.
</pre>
***

####Delete Data
<pre>
    As a person who may have entered in too much data,
    In order to keep accurate records,
    I want to be able to delete data.
    
     *Usage: ruby beer.rb delete "beer_name"
   
    Acceptance Criteria:
    *I can delete data.
    *Prints out beer names and dates and asks which one to delete.
    *I cannot delete an entry without confirmation.
</pre>
***

##Query Data

####List Kinds of Beer Consumed
<pre>
  As a beer connoisseur,
  In order to remember what different beers I have enjoyed,
  I want to track the different kinds of beer I drink.
 
   *Usage: ruby beer.rb kinds
 
  Acceptance Criteria:
  *Prints out the different kinds of beer consumed.
</pre>
***

####List Oz. of Beer Consumed
<pre>
  As a healthy person,
  In order to keep a leash on my compulsive tendencies,
  I want to track the oz of beer I drink.
  
  *Usage: ruby beer.rb oz
 
  Acceptance Criteria:
  *Prints out the total amount of beer consumed in ounces.
</pre>
***

####List Calories Consumed
<pre>
  As a healthy person,
  In order to keep a leash on my weight,
  I want to track the amount of calories in the beer I drink.
  
  *Usage: ruby beer.rb cal
 
  Acceptance Criteria:
  *Prints out approximate calories consumed.
</pre>
***

####List Money Spent
<pre>
  As a frugal husband,
  In order to stay within the bounds of a set budget,
  I want to track the amount of money I spend on beer.
  
  *Usage: ruby beer.rb money
 
  Acceptance Criteria:
  *Prints out the total amount of money spent.
</pre>
***

####List Money Spent Per ABV
<pre>
  As a drinker who wants the most amount of alcohol for the buck,
  In order to see how much actual alcohol I consume for my money,
  I want to see how much i am spending on the percentage of alcohol in the beer.
  
  *Usage: ruby beer.rb abv
 
  Acceptance Criteria:
  *Prints out the amount of mony spent per ABV.
</pre>
***





 


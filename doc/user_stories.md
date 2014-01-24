#User Stories

##Create, Update and Delete Data

####Create a Journal Entry
<pre>
  As a person who drinks,
  In order to add information about beer consumed,
  I want to be able to create an entry.

  *Usage: ruby beer.rb add "persons_name" "style" "beer_name" date num_oz num_dollars

  Acceptance Criteria:
  *I can create a data entry.
  *I cannot make an entry without all fields filled in.
</pre>
***

####Update Oz
<pre>
    As a person who may have entered in the wrong data,
    In order to keep accurate records,
    I want to be able to update oz.

    *Usage: ruby beer.rb update "person_name" "beer_name" date num_oz
    *example: ruby beer.rb update "Brian" "Yazoo Pale Ale" 1-14-14 20

    Acceptance Criteria:
    *I can update oz by typing update command and setting oz.
    *Prints updated record.
</pre>
***

####Update Cost
<pre>
    As a person who may have entered in the wrong data,
    In order to keep accurate records,
    I want to be able to update cost.

    *Usage: ruby beer.rb update oz "person_name" "beer_name" date num_dollars
    *example: ruby beer.rb update "Brian" "Yazoo Pale Ale" 1-14-14 15

    Acceptance Criteria:
    *I can update cost by typing update command and setting cost.
    *Prints updated record.
</pre>
***

####Delete Data
<pre>
    As a person who may have entered in too much data,
    In order to keep accurate records,
    I want to be able to delete data.

     *Usage: ruby beer.rb delete "person_name" "beer_name" "date"

    Acceptance Criteria:
    *I can delete a record by typing delete command.
    *Confirms deletion
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










./beertracks add 'Green Man' --oz 12 --cost 5 --style IPA
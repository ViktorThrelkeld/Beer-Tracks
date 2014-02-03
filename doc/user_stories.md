#User Stories

##Create, Update and Delete Data

####Create a Journal Entry
<pre>
  As a person who drinks,
  In order to add information about beer consumed,
  I want to be able to create an entry.

  *Usage: ./beertracks add "beer_name" ounces cost
  *Example: ./beertracks Heineken --ounces 12 --cost 4.50

  Acceptance Criteria:
  *I can create a data entry.
  *I cannot make an entry without all fields filled in.
  *After entering data manually, the user is prompted as to what style of beer they entered.
  *If no style is selected and the user hits enter, Unknown is selected by default with an average calorie per ounce of 12.
  *Prints entry.
</pre>
***

####Update Oz
<pre>
    As a person who may have entered in the wrong data,
    In order to keep accurate records,
    I want to be able to edit data

    *Usage: ./beertracks edit --id (id_to_edit)  --ounces (updated_ounces)
    *Example ./beertracks edit --id 12 --ounces 6

    Acceptance Criteria:
    *I can update oz by typing edit command and setting oz.
    *Prints updated record.
</pre>
***

####Update Cost
<pre>
    As a person who may have entered in the wrong data,
    In order to keep accurate records,
    I want to be able to update cost.
 
    *Usage: ruby beer.rb update oz "beer_name" --id (id) --cost (updated_cost)
    *Example: ./beertracks update --id 12 --cost 4.50

    Acceptance Criteria:
    *I can update cost by typing edit command and setting cost.
    *Prints updated record.
</pre>
***

####Delete Data
<pre>
    As a person who may have entered in too much data,
    In order to keep accurate records,
    I want to be able to delete data.

     *Usage: ./beertracks delete --id (id_of_entry_to_be_deleted)
     *Example: ./beertracks delete --id 12
     
    Acceptance Criteria:
    *I can delete a record by typing delete command.
    *Confirms deletion
</pre>
***

##Query Data

####Search Data
<pre>
    As a person who may want to see the entries of a specific beer by name,
    In order to keep track of that brand of beer,
    I want to be able to search the entries.

     *Usage: ./beertracks search 
     
     
    Acceptance Criteria:
    *I can search a entries for a specific beer by name.
    *After using the search command I will be prompted for its name.
    *Lists entries of beer by that name as well as id.
</pre>
***

####List Kinds of Beer Consumed
<pre>
  As a beer connoisseur,
  In order to remember what different beers I have enjoyed,
  I want to track the different kinds of beer I drink.

   *Usage: ./beertracks list

  Acceptance Criteria:
  *Prints out the different kinds of beer consumed.
</pre>
***

####List Calories Consumed
<pre>
  As a healthy person,
  In order to keep a leash on my weight,
  I want to track the amount of calories in the beer I drink.

  *Usage: ./beertracks total

  Acceptance Criteria:
  *Prints out approximate calories consumed based on the style of beer, as well as total cost.
</pre>
***

####List Money Spent
<pre>
  As a frugal husband,
  In order to stay within the bounds of a set budget,
  I want to track the amount of money I spend on beer.

  *Usage: ./beertracks total

  Acceptance Criteria:
  *Prints out approximate calories consumed based on the style of beer, as well as total cost.
</pre>
***

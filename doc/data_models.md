Domain Model

<pre>
People
many People to many Events

Events
One Event to many Beers

Beer
Many or No Beers to one Style

Style
</pre>






Data model
<pre>
 Beer
  ID: int  PK
  Name: varchar(30)
  Cost: int
  Oz: int
  StyleID: int  FK
</pre>

<pre>  
 Style
  ID: int  PK
  Style_Type: varchar(30)
  calories_per_ounce: int
  ABV: float? (ie 6.5%)
</pre>

<pre>
Event
 ID: int PK
 Date: timestamp or int
 BeerID FK
 
</pre>

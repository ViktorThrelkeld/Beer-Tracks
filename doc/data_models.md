Domain Model

<pre>
Person
one person to none or many Beers

Beer


Style
</pre>






data model
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

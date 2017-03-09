# Theory Of Algorithms 

The following project will hopefully solve the Countdown Numbers Game.

The project will be written in Racket and will hopefully demonstrate the uses of functional programming.

## Things to Keep in Mind
* **13,243** Possible combinations that can be selected and can be combined to make **10,871,986** distinct solutions of numbers and target numbers.

* All target numbers achievable given the correct starting numbers.

* Set **{1,1,2,2,3,3}** is the only set that cant produce a 3 digit number, Total **81**.

## Possible Solution Ideas
* Brute Force  
  Loop through every posible combination and evaluate the results;
  
* Map, Permutations, Combinations  
  ```(map minus (permutations (combinations (list a b c d) 2)))```   
  Get every permentation of the list of combinations of 2 from the List of Choosen numbers.
  Then pass that list into the required function E.g minus , plus , divide , mult
  Map maps each item in the list to a function.

* Cartisian-Product  
  Create a list of every compination between the 3 lists given, (operators) (choosen nums) (choosen nums)
  Then eval the list using a function.

## Optimisations - Things to keep in mind for later

* No benefit in Multiply/Dividing by 1 at any stage.

* Posible Solution cannot becomes negative at any stage.

* Similarly if the solution becomes non-integer.

* If x÷y=y or x-y=y , than this step is redundant.

* Check for Operators used on a Zero value.


## Installation

TODO: Describe the installation process


## Rules of The Game

* Six numbers are selected at random from the following list of twenty-four:
```
[1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 25, 50, 75, 100]
```

* There are two different sets to choose from: Large Numbers and Small Numbers.

* There are four numbers in the Large Set 
```
{ 25 , 50 , 75 , 100 }
```

* There are twenty numbers in the Small Set, two of each of the numbers 1-10
```
{ 1 , 1 , 2 , 2 , 3 , 3 , 4 , 4 , 5 , 5 , 6 , 6 , 7 , 7 , 8 , 8 , 9 , 9 , 10 , 10 }
```

* Once the six desired numbers have been choosen, A random three-digit target number is then chosen by a computer.

* The target number is a randomly generated three digit integer between 101 and 999 inclusive.

* The objective of the game is to get as close as possible to the chosen target by using just the four basic arithmetic operators listed:
```
+ - × ÷
```

* Not all the digits need to be used.

* Concatenation of the digits is not allowed (You can’t use a "2" and "2" to make "22").

* At no intermediate step in the process can the current running total become negative or involve a fraction.

* Each numbered tile can only be used once in the calculation.

## References
[Racket Documentation](https://docs.racket-lang.org/).

[Reverse Polish Notation](https://en.wikipedia.org/wiki/Reverse_Polish_notation) Wiki Explained.

[CountDown Numbers Game](http://datagenetics.com/blog/august32014/index.html) Information And Solver.

[Combinations / Permutations](http://www.mathsisfun.com/combinatorics/combinations-permutations.html) Explained.

[Math 24 game](https://rosettacode.org/wiki/24_game/Solve#Racket) Similar Solution.

[C# Solution](https://www.codeproject.com/Articles/740035/Countdown-Number-Puzzle-Solver).

[Helpful Solutions](https://rosettacode.org/wiki/Category:Programming_Tasks) To Multiple Games.



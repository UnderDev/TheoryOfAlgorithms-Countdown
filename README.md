# Theory Of Algorithms 

The following project sets out to solve the Countdown Numbers Game, seen on the popular Tv Show [Countdown.](https://en.wikipedia.org/wiki/Countdown_(game_show))

The project will be written in [Racket](https://racket-lang.org/) and will hopefully demonstrate the different concepts of [Functional Programming](Functional programming).

Running the program picks 6 random numbers from a list, and a Random target between 101-999 inclusive. The program will then try to find the target following the ruls of the game, printing to the screen all the Reverse Polish Notation equations that equal the target number or '() if no solutions are found.

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

## Things to Keep in Mind
* **13,243** Possible combinations that can be selected and can be combined to make **10,871,986** distinct solutions of numbers and target numbers.

* All target numbers achievable given the correct starting numbers.

* Set **{1,1,2,2,3,3}** is the only set that cant produce a 3 digit number, Total **81**.

 
## Possible Solution Ideas
* [Brute Force](https://en.wikipedia.org/wiki/Brute-force_search)  
  Loop through every posible combination and evaluate the results;
  
* [Reverse Polish Notation](https://en.wikipedia.org/wiki/Reverse_Polish_notation) (Best Approach)
  Convert the given List of posible answers to RPN and return any equation from the stack that equals the given target number.
  The stack cannot contain fractions/Decemals/uneven numbers at any time. If it dose, move onto the next item on the list.
  
* Map, [Permutations, Combinations](https://www.mathsisfun.com/combinatorics/combinations-permutations.html)
  ```(map minus (permutations (combinations (list a b c d) 2)))```   
  Get every permentation of the list of combinations of 2 from the List of Choosen numbers.
  Then pass that list into the required function E.g minus , plus , divide , mult
  Map maps each item in the list to a function.

* [Cartisian-Product](https://en.wikipedia.org/wiki/Cartesian_product#A_deck_of_cards)  
  Create a list of every compination between the 3 given lists, (operators) (choosen nums) (choosen nums)
  Then eval the list using a function.

## Optimisations - Things to keep in mind during development

* No benefit in Multiply/Dividing by 1 at any stage.

* Posible Solution cannot becomes negative at any stage.

* Similarly if the solution becomes non-integer.

* If x÷y=y or x-y=y , than this step is redundant.

* Check for Operators used on a Zero value.

* Check the stack for Integer,Positive,Numbers 

## The Algorithm Used  
Steps Involved in function below
 1. Take in a list called e, and 2 optional lists.
 1. Check if the list is null Recursivly
 1. If the list is null, Check dose it equal the target number and return the equation, ELSE return #f
 1. If the list is null, Check the Following condition:
 
    * If True - Check the stack for the target number. Else return false.   
    * Else - Check for the Following Conditions.   
       * Is the stacks NOT null AND the first number on the stack is the Target, if yes, return the Equation.   
       * If the car of the List is an operator, AND check the stack to make sure everything is a Number / Positive / Real and an Integer. This evaluates only valid RPN at each stage of the stack.   
       IF True then check the following:                
          
          * Call RPN on the Cdr of the List, and check the following coditions:    
             * Is the length of the stack > 2. IF True?, Create a lambda function that pops 2 numbers off the stack and evaluates them. Then Adds them to the stack with the last item that didnt get evaluated from the stack.   
             * Is the stack length equal 2, Pops 2 numbers off the stack, applys the opperator to them and evaluates it.   
             * Else return (#f).   
         
           * Then construct a new list with the car of the equation.
         
  1. Else #f
  
 ```
 (define (is-valid-rpn? e [s '()] [eq '()])
  (begin
    (if (null? e)
        (if (equal? (first s) targetNum)
            (reverse eq)
            #f)
        (cond
          [(and (not (null? s)) (equal? (first s) targetNum)) (reverse eq)]
          [(and (number? (car e)) (andmap number? s)) (is-valid-rpn? (cdr e) (cons (car e) s) (cons (car e) eq))]
          [(and (procedure? (eval(car e) ns)) (andmap real? s)  (andmap positive? s) (andmap number? s) (andmap integer? s))
           (is-valid-rpn? (cdr e)
                          (cond
                            [(> (length s) 2) (flatten((lambda (x y) (reverse(list y x))) (eval ((eval(car e)ns) (cadr s) (car s))ns) (list-tail s 2)))]
                            [(equal? (length s) 2) (list(eval ((eval(car e)ns) (cadr s) (car s)) ns))]
                            [else (list #f)])
                          (cons (car e) eq))]
          [else #f]))))
 
 ```

This Algorithm takes in posible solutions and uses a [Stack](https://en.wikipedia.org/wiki/Stack_(abstract_data_type)) to control if the solution is Valid RPN and follows all the ruls of the game, returning all valid equations that equal the target number.

## Limitations of the Algorithm
The Algorithm dose calculate and return all equations to get the taraget number, but the method i use to geterate all posible pemutations for six numbers and 4 opperators dosnt return all posibilities. The idea was to get all permutations of 4 random numbers and the 4 opperators , then append the last 2 chossen numbers onto each permutation(shuffeled) and a random opperator to the end. This resulted in 8! (40320) posible solutions. Compared to 11! (39916800) which takes up alot of space and time to generate and evaluate.

As a result, when testing the Algorithm on different target numbers i found that it seemed to find equations for smaller target more frequently.


**Posible Solution**   
A solution to this, given more time, would be to first find all the valid ways to generate Valid RPN for 6 numbers and 4 opperators using placeholders for the numbers and opperators.

With this list, i could then take my choosen numbers and opperators and replace each item from the lists into my Valid RPN list, getting all the permutations.

This method, should increase performance in generating all the permutations as it only makes valid RPN.




## Installation
1) Download [Racket](https://racket-lang.org/download/)

2) Download/Fork this Repository.

3) Open/Run the Script CountDown Numbers Game.rkt




## References
[Racket Documentation](https://docs.racket-lang.org/).

[Reverse Polish Notation](https://en.wikipedia.org/wiki/Reverse_Polish_notation) Wiki Explained.

[Reverse Polish Notation Calculator](https://rosettacode.org/wiki/Parsing/RPN_calculator_algorithm#Racket) Racket Code.

[CountDown Numbers Game](http://datagenetics.com/blog/august32014/index.html) Information And Solver.

[Combinations / Permutations](http://www.mathsisfun.com/combinatorics/combinations-permutations.html) Explained.

[Math 24 game](https://rosettacode.org/wiki/24_game/Solve#Racket) Similar Solution.

[C# Solution](https://www.codeproject.com/Articles/740035/Countdown-Number-Puzzle-Solver).

[Helpful Solutions](https://rosettacode.org/wiki/Category:Programming_Tasks) To Multiple Games.



#lang racket

;=================================>  Inital Setup <=======================================
; Define The NameSpace for Eval function
(define ns (make-base-namespace))

; Defining the List of Small Numbers
(define posNums (list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100))

;Opperators Allowd
(define operators '(- + / *))

;Function to get n random Numbers from the List Passed in
(define (pickRandom l num [t'()])
  (if(null? l)
     #f
     (cond
       [(equal? (length t) num) t]
       [else (pickRandom (shuffle(cdr l)) num (cons (first l) t))])))

;Define rndChosenNums, which is the 6 randomly generated numbers choosen
(define rndChosenNums (pickRandom posNums 6))

; Random Number Function Takes in Two Numbers and returns a number in that range
(define (rnd-num a b)
  (random a b))

; Defining The Target Number (randdom number Between 101 and 999)
(define targetNum (rnd-num 101 999))



;=================================> Handy Things To Keep In Mind <=========================
;(remove-duplicates posEval) ;Removes duplicates from a list
;(random 101 999) ;Random Num Between 101 999
;(modulo 10 4)) ;Gets the Moduls of 2 numbers
;(list-tail lst 2) Gets the remaining items from the list after pos 2
;(andmap positive? (list 1 2 3 -8) Checks every item on the list to see if positive this returns #f
;==========================================================================================



;==========================================================================================
;===========================>  Two Numbers Solved & Optimized <============================
;==========================================================================================

; Cartesian cartesian-product gets all permemtations of the lists passed in 
(define posEval (remove-duplicates (cartesian-product '(* - + /) ( list 5 25)  (list 5 25))))
(define trgtNum 125)

;Pass in a list and an empty list,
;check each item in the list and evaluate the result, adding it to the empty list only
;IF its an integer, a positive number and the Evaluation is the target number.
(define (evalCond l a)
  (cond ((null? l) a)
        ((and (integer? (eval (car l) ns)) (positive? (eval (car l) ns)) (equal? trgtNum (eval (car l) ns))) (evalCond (cdr l)(cons (car l)  a)))
        (else (evalCond (cdr l) a))))

;Defines a function that takes in a list and a function,
(define (evaluateList l )(evalCond l null))

;Call The Function evaluateList And Pass in the List
"Target For 2 Numbers"
trgtNum

"Solution for 2 Numbers"
(evaluateList posEval)



;=======================> Simular Problem To CountDown Numbers Game <======================
; Solution Below is used for a game called 24
;Copyed From https://rosettacode.org/wiki/24_game/Solve#Racket
; Dosnt Work For All Numbers
; Eg goal 879,  Numbers '(2 7 9 10 50 25) "Solution Should be 879 = (2×(7+(9×50)))-(10+25)"

(define (in-variants n1 o1 n2 o2 n3 o3 n4)
  (let ([o1n (object-name o1)]
        [o2n (object-name o2)]
        [o3n (object-name o3)])
    (with-handlers ((exn:fail:contract:divide-by-zero? (λ (_) empty-sequence))) 
      (in-parallel 
       (list  (o1 (o2 (o3 n1 n2) n3) n4)
              (o1 (o2 n1 (o3 n2 n3)) n4)
              (o1 (o2 n1 n2) (o3 n3 n4))
              (o1 n1 (o2 (o3 n2 n3) n4))
              (o1 n1 (o2 n2 (o3 n3 n4))))
       (list `(((,n1 ,o3n ,n2) ,o2n ,n3) ,o1n ,n4)
             `((,n1 ,o2n (,n2 ,o3n ,n3)) ,o1n ,n4)
             `((,n1 ,o2n ,n2) ,o1n (,n3 ,o3n ,n4))
             `(,n1 ,o1n ((,n2 ,o3n ,n3) ,o2n ,n4))
             `(,n1 ,o1n (,n2 ,o2n (,n3 ,o3n ,n4))))))))

(define (find-solutions numbers (goal 173))
  (define in-operations (list + - * /))
  (remove-duplicates
   (for*/list ([n1 numbers]
               [n2 (remove-from numbers n1)]
               [n3 (remove-from numbers n1 n2)]
               [n4 (remove-from numbers n1 n2 n3)]
               [o1 in-operations]
               [o2 in-operations]
               [o3 in-operations]
               [(res expr) (in-variants n1 o1 n2 o2 n3 o3 n4)]
               #:when (= res goal))
     expr)))
 (define (remove-from numbers . n) (foldr remq numbers n))
;Uncomment Line Below For Results
;(find-solutions '(2 7 9 10 50 25))



;=================================> Calculate Reverse Polish Notation <====================
;Copyed From https://rosettacode.org/wiki/Parsing/RPN_calculator_algorithm
; Algorithm Checks items on the list passed in for VALID RPN 
(define (calculate-RPN lst)
  (for/fold ([stack '()]) ([token (reverse lst)])
    ;(printf "~a\t -> ~a~N" token stack) ;Print out the Stack at each iteration
    (with-handlers ([exn:fail? (lambda (exn) #f)])
    (match* (token stack)
     [((? number? n) s) (cons n s)]
     [('+ (list x y s ___)) (cons (+ x y) s)]
     [('- (list x y s ___)) (cons (- y x) s)]
     [('* (list x y s ___)) (cons (* x y) s)]
     [('/ (list x y s ___)) (cons (/ y x) s)]
     ))))
;Uncomment Line Below For Results
;(calculate-RPN '(10 * * 2 / 7 + 3 - 8 50));Example 



;==========================================================================================
;==================>  Countdown Numbers Game, Full Solution Below <========================
;==========================================================================================


;=================================> Build RPN List <=======================================
;The following method is used to generate all posible Permutations and is not complete. As it only gives 40320 solutions. 

;Function - Gets a random item from the list passed in
(define (rand-element l)
  (list-ref l (random (length l))))

;Create my starting rpn list
(define rpnList (flatten (cons operators (pickRandom rndChosenNums 4))))

;Gets the permutaions and Removes all duplicates from the list
(define permu (remove-duplicates (permutations rpnList)))


;Appends the 2 numbers (shuffled) at the start of the list passed in and a random operator at the end
(define (makePosRpn l)
  (append (shuffle(list 50 8)) l (list(rand-element operators))))

;Maps the list to the function, 8! or 40320 Posible Permutations  
(define (pos-Solu lst)(map makePosRpn permu));

;Brute Force -> Not recommended 
;A Brute force method might generate all possible permutations but is 11! and has 39916800 Permutations.
;Running the following will take a long time to complete.

;Uncomment the 3 lines below to use Brute Force Approach
;(define bruteForce (remove-duplicates (permutations (list '- '+ '/ '*  3 7 2 10 50 8))))
;(define (rpnBF l)(append l (list(rand-element operators))))
;(define (pos-SoluBF lst)(map rpnBF permu));



;=================================> Check & Calculate RPN <================================
; Steps Involved in function below
; 1) Take in a list called e, and 2 optional lists.
; 2) Check if the list is null Recursivly
; 3) If the list is null, Check dose it equal the target number and return the equation, ELSE return #f
; 4) If the list is null, Check the Following condition:
;
;   (a)If true - Check the stack for the target number. Else return false
;   (b)Else - Check for the Following Conditions
;     [i]Is the stacks NOT null AND the first number on the stack is the Target, if yes, return the Equation.
;     [ii]If the car of the List is an operator, AND check the stack to make sure everything is a Number / Positive / Real ;         and an Integer. This evaluates only valid RPN at each stage of the stack. IF TRUE then check the following:
;
;         Call RPN on the Cdr of the List, and check the following coditions: 
;          (1) Is the length of the stack > 2. IF TRUE? create a lambda function that pops 2 numbers off the stack and ;              evaluates them. Adds them to the stack with the last item that didnt get evaluated from the stack.
;          (2) Is the stack length equal 2, Pops 2 numbers off the stack, applys the opperator to them and evaluates it.
;          (3) Else return (#f)
;         Then construct a new list with the car of the equation 
;   (c) Else #f


(define (is-valid-rpn? e [s '()] [eq '()])
  (begin
   ;(printf "~a\t -> ~a~N \n" e s); Prints out the List and Stack. Use only for testAlgo Below.
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

;Testing, only For a smaller amount of numbers, Useful for seeing whats on the stack
(define testAlgo (remove-duplicates(permutations (list 2 8 3 '/ '*))))
;Uncomment Below To use
;(remove-duplicates (filter identity(filter identity(map is-valid-rpn? testAlgo))))

"Target To Reach"
targetNum

"Choosen Numbers"
rndChosenNums

"Solution's for full Game"
(remove-duplicates (filter identity(map is-valid-rpn? (pos-Solu permu))))


;Brute Force Approach (Not Recommended) - Uncomment Below to use
;(remove-duplicates (filter identity(map is-valid-rpn? (rpnBF bruteForce))))


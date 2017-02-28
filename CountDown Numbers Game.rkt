#lang racket

;() Empty List

;=================================>  Inital Setup <=================================================================
; Defining the List of Small Numbers
(define sNums (list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10))

; Defining the List of Large Numbers
(define lNums (list 25 50 75 100))

; Defining the List of Large Numbers
(define operators '(list - + / *))


; Defining the List of Chosen Numbers
(define ChosenNums (list 5 25 10))

;Define The NameSpace for Eval
(define ns (make-base-namespace))

;Random Number Function Takes in Two Numbers and returns a number in that range
(define (rnd-num a b)
  (random a b))

;OR

;(rnd-num 101 999)

; Defining The Target Number (randdom number Between 101 and 999)
(define targetNum (rnd-num 101 999))


;=================================> Print out the lists <===========================================================
"Small Number Lists"
sNums

"Large Numbers List"
lNums

"Operators List"
operators

"Chosen Numbers List"
ChosenNums

"TargetNum:"
targetNum
;====================================================================================================================



;Cartesian cartesian-product gets all permemtations of the lists passed in 
(define posEval (cartesian-product '(* - + /) ( list 5 25 10)  (list 5 25 10)))


;=================================> Eval On List of Pos Combinations <===============================================
;Recursion On List of posible combinations
;Then Evaluate them and return a new list
'(define (evalListRec l a)
  (if (null? l)
      a
      (evalListRec (cdr l)(cons (eval (car l) ns) a))))
;====================================================================================================================



;=================================> Eval On List of Pos Combinations Optimized <=====================================
;Pass in a list and an empty list,
;check each item in the list and evaluate the result, adding it to the empty list only
;IF its an integer and a positive number

(define (evalListRec l a)
  (cond ((null? l) a)
        ((and (integer? (eval (car l) ns)) (positive? (eval (car l) ns))) (evalListRec (cdr l)(cons (eval (car l) ns) a)))
        (else (evalListRec (cdr l) a))))

;====================================================================================================================



;Defines a function that takes in a list and a function,
;passing that list into the function aswell 
(define (evaluateList l )(evalListRec l null))


;Call The Function And Pass in the List
(evaluateList posEval)




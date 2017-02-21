#lang racket

;() Empty List

; Defining the List of Small Numbers
(define sNums (list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10))

; Defining the List of Large Numbers
(define lNums (list 25 50 75 100))

; Defining the List of Large Numbers
(define operators (list - + / *))

; Defining the List of Choosen Numbers
(define choosenNums (list 5 25))

;Target Number Between 101 and 999
;Print out the lists
sNums
lNums
operators
choosenNums

(define (random-choice a b)
  (if (zero? (random 4)) a b))

(random-choice 101 999)


;Generate a Random Number In the Range 101 - 999 *Not Sure is 101/999 can be picked
(random 101 999)



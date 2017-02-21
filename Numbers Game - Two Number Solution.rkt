#lang racket

; Define The List etc
(define ops (list + - * /))
(define a 5)
(define b 25)
(define t 125)

(define numsPicked (list 5 25))

; Hard Coded List of Posible Solutions
(define eval (list
	(+ a b)
	(+ b a)
	(- a b)
	(- b a)
	(* a b)
	(* b a)
	(/ a b)
	(/ b a)
))

eval


; Recursion - Defining a function that you can pass in an operator and a list
; If The Null List? Return the List otherwise 1 - Do the following

; Steps:
; l(5 25)

(define (f oper l)
  (if (null? l)
     1    
     (oper (car l)(f oper(cdr l)))))


; 
(f * numsPicked)

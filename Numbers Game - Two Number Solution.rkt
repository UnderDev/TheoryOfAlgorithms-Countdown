#lang racket

; Define The List etc
(define ops (list - + * /))
(define a 5)
(define b 25)
(define t 125)

(define p *)

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

'eval
 p

; Recursion - Defining a function that you can pass in an operator and a list
; If The Null List? Return the List otherwise 1 - Do the following
; Begin alows you to do 3 things (3 functions etc
; Steps:
; l(5 25)
; Get the cdr of the List (25)

(define (f oper l)
  (if (null? l)
     1
     (begin
       (display l)
       (display oper)
       (newline)
       ((car oper)(car l)(f(cdr oper)(cdr l))))))

; 
(f ops numsPicked)





; The two functions above look very similar.
; Define a generic function with the pattern (from sum and mult).
; oper is the operation to apply to the function elements.
; id is the identity for oper (when used with oper nothing changes).
(define (g oper id l)
  (if (null? l)
      id
      (begin
      (display l)
      (newline)
      (oper (car l) (g  oper id (cdr l))))))

; Now define fsum, which does the same thing as sum above, but define it using f.
; Note that f takes three arguments, and all fsum does is hard-code two of those.
(define (fsum l) (g  + 0 l))

; Test fsum out - same result as sum.
(fsum (list 1 2 3 4 5))

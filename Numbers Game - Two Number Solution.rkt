#lang racket

; Define The List etc
(define ops (list + - * /))
(define a 5)
(define b 25)
(define c 50)
(define d 10)
(define e 7)
(define f 3)



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
; Begin alows you to do 3 things (3 functions etc)

(define (fun oper l)
  (if (null? l)
     1
     (begin
       (display l)
       (display oper)      
       (newline)
       ((car oper)(car l)(fun(cdr oper)(cdr l))))))

; 
'(fun ops numsPicked)

;Addition
(define (plus l)
  (if (null? l)
      0
      (begin
       (display l)
      (+ (car (car l)) (plus (cdr (cdr l)))))))

;Addition2
(define (plus2 l)
  (if (null? l)
      0
      (+ (car l) (plus2 (cdr l)))))


;Multiply 
(define (mult l)
  (if (null? l)
      0
      (* (car l) (mult (cdr l)))))

;Divide 
(define (divide l)
  (if (null? l)
      0
      (/ (car l) (divide (cdr l)))))

;Minus
(define (minus l)
  (if (null? l)
      0
      (begin
       (display l)
      (- (car (car l)) (minus (cdr (cdr l)))))))

#|
   a = 5 , b = 25 , c = 50
   combinations = ((5 25) (5 50) (25 50))
   permutations = ((5 25 50) (25 5 50) (5 50 25) (50 5 25) (25 50 5) (50 25 5))
  (permutations (combinations (list a b c) 2)) =
  (((5 25)  (5 50)  (25 50))
  ( (5 50)  (5 25)  (25 50))
  ( (5 25)  (25 50) (5 50))
  ( (25 50) (5 25)  (5 50))
  ( (5 50)  (25 50) (5 25))
  ( (25 50) (5 50)  (5 25)))
|#

'(combinations (list a b c d e f) 2)
(permutations (combinations (list a b c) 2))
'(permutations (list a b c d e f))

;Maps all the combinations
'(map minus (permutations(list a b)))
'(map mult  (permutations(list a b)))
'(map divide(permutations(list a b)))

'(map plus2  (combinations (list a b c d) 2))
'(map minus (permutations (combinations (list a b c d) 2)))


'(list->set (map minus (permutations(list a b))))

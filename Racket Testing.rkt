#lang racket

; Define The List etc
(define ops (list + - * /))
(define a 5)
(define b 25)
(define c 10)
(define d 50)
(define e 7)
(define f 3)

(define t 125)

(define numsPicked (list 5 25 10))

; Hard Coded List of Posible Solutions
(define evall (list
	(+ a b)
	(+ b a)
	(- a b)
	(- b a)
	(* a b)
	(* b a)
	(/ a b)
	(/ b a)
))
evall

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
      (+ (car l) (plus (cdr l))))))

;Addition2
(define (plus2 l)
  (if (null? l)
      0
      (begin
      (display l)
      (+ (car (car l)) (plus2 (cdr l))))))


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
   a = 5 , b = 25 , c = 10
   combinations = ((5 25) (5 50) (25 50))
   permutations = ((5 25 50) (25 5 50) (5 50 25) (50 5 25) (25 50 5) (50 25 5))
  (permutations (combinations (list a b c) 2)) =
  (5 25)  (5 10)  (25 10)


(combinations(permutations (list a b c) ))
|#


(define (plussss l)
  (if (null? l)
      1
      (begin
       (display l)
      ;(+ (car l)) (plussss (car (cadr l)))))))
       (+ (car (car l)) (plussss (cadr(car l)))))))
      ;( +(car(car l)) (car (cadr l))))))

;first item in the list and the first value + first item in the list and cdr of the first value
;( + (car(car posEval)) (cadr (car posEval)))
;(car (cdr (car posEval)))
;(car (car posEval))

;(map plussss (list posEval))


'(map minus (permutations(list a b)))
'(map mult  (permutations(list a b)))
'(map divide(permutations(list a b)))


'(map plus2  (combinations (list a b c d) 2))
'(map minus (permutations (combinations (list a b c d) 2)))


'(list->set (map plus (permutations(list a b))))



'(combinations (list a b c d e f) 2)
'(permutations (combinations (list a b c) 2))
'(permutations (combinations(list a b c) 2))

;Maps all the combinations
'(combinations(list numsPicked) 2)
'(permutations(list numsPicked))


;Define a list of the cartesian-product of the following lists
;Results
;(* 5 5)
  ;(* 5 25)
  ;(* 5 10)
  ;(* 25 5)
  ;Etc
(define posEval (cartesian-product '(* - + /) ( list 5 25 10)  (list 5 25 10)))

;(define posEval (cartesian-product (list 1 2) (list 4 3)))


;Print out the cartesian-product
posEval


;Define a Namespace (needed for eval)
(define ns (make-base-namespace))

;(car(posval) ns)


;Atempted Recursion on list +using eval to evaluate them
(define (evalListRec l a)
  (if (null? l)
      a
      (evalListRec (cdr l)(cons (eval (car l) ns) a))))

;New function passing in a list, and calling anoter function 
(define (stuff l )(evalListRec l null))

;
(define p (stuff posEval))

;Call the function and evaluate
p



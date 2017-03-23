#lang racket

;() Empty List

;=================================>  Inital Setup <===========================================================
; Defining the List of Small Numbers
(define sNums (list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10))

; Defining the List of Large Numbers
(define lNums (list 25 50 75 100))

; Defining the List of Large Numbers
(define operators '(list - + / *))

;Function to get a random Number from the List Passed in
(define (pick-item l)
  (list-ref l (random (length l))))

(pick-item(list 3 4 5 6 7)) ;Working But need to do several times

;Maby get a random number in the range 1-10 for small numbers

; Defining the List of Chosen Numbers
(define ChosenNums sNums)

; Define The NameSpace for Eval
(define ns (make-base-namespace))

; Random Number Function Takes in Two Numbers and returns a number in that range
(define (rnd-num a b)
  (random a b))

; Defining The Target Number (randdom number Between 101 and 999)
'(define targetNum (rnd-num 101 999))

; Cartesian cartesian-product gets all permemtations of the lists passed in 
(define posEval (remove-duplicates (cartesian-product '(* - + /) ( list 5 25)  (list 5 25))))

; Temp Target Number For Testing
(define targetNum 30)

;=================================> Print out the lists <=====================================================
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



;=================================> Handy Things To Keep In Mind <============================================

;(remove-duplicates posEval) ;Removes duplicates from a list
;(random 101 999) ;Random Num Between 101 999
;(modulo 10 4)) ; gets the Moduls of 2 numbers

;=================================> Eval On List of Pos Combinations <========================================
;Recursion On List of posible combinations
;Then Evaluate them and return a new list
;(define (evalListRec l a)
  ;(if (null? l)
      ;a
      ;(evalListRec (cdr l)(cons (eval (car l) ns) a))))


;=================================> Eval On List of Pos Combinations Optimized <==============================
;Pass in a list and an empty list,
;check each item in the list and evaluate the result, adding it to the empty list only
;IF its an integer and a positive number

(define (evalListRec l a)
  (cond ((null? l) a)
        ((and (integer? (eval (car l) ns)) (positive? (eval (car l) ns))) (evalListRec (cdr l)(cons (eval (car l) ns) a)))
        (else (evalListRec (cdr l) a))))


;==> Attempt 2 Match all with target number <==
(define (evalCond l a)
  (cond ((null? l) a)
        ((and (integer? (eval (car l) ns)) (positive? (eval (car l) ns)) (equal? targetNum (eval (car l) ns))) (evalCond (cdr l)(cons (car l)  a)))
        (else (evalCond (cdr l) a))))



;Defines a function that takes in a list and a function,
;passing that list into the function aswell 
(define (evaluateList l )(evalCond l null))

;Remove Duplicates from the List of pos combinations
;(define solutions (remove-duplicates posEval))
"Pos Solutions duplicates removed"
;solutions
posEval
;Call The Function evaluateList And Pass in the List
;Use an if here to check if empty list, then display message
"Solutions Shown Below For Target"
targetNum
(evaluateList posEval)









;=================================> Pos Solution Six Numbers <==============================
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

;(find-solutions '(2 7 9 10 50 25))





;=================================> Calculate Reverse Polish Notation <==============================
;Adapted From https://rosettacode.org/wiki/Parsing/RPN_calculator_algorithm
(define (calculate-RPN lst)
  (for/fold ([stack '()]) ([token lst])
    (printf "~a\t -> ~a~N" token stack);Print out the Stack
    (match* (token stack)
     [((? number? n) s) (cons n s)]
     [('+ (list x y s ___)) (cons (+ x y) s)]
     [('- (list x y s ___)) (cons (- y x) s)]
     [('* (list x y s ___)) (cons (* x y) s)]
     [('/ (list x y s ___)) (cons (/ y x) s)]
     [('^ (list x y s ___)) (cons (expt y x) s)]
     [(x s) (error "calculate-RPN: Cannot calculate the expression:" 
                   (reverse (cons x s)))])))


'(calculate-RPN '(6 3 1 / -));Example 


































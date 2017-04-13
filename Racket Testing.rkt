#lang racket

; Define The List etc
(define opers (list + - * /))

(define target 125)

;Define a Namespace (needed for eval)
(define ns (make-base-namespace))


(define numsPicked (list 5 25 10))

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


"Numbers Used"
numsPicked

;Define a list of the cartesian-product of the following lists
(define posEval (cartesian-product opers numsPicked  numsPicked))

;Print out the cartesian-product
"cartesian-product Of List"
'posEval


;(define Comb (combinations numsPicked 2))
(define Permut (permutations numsPicked))
'Permut
(define PermutCart (cartesian-product opers Permut))
'PermutCart


(append opers (car Permut))

#|
(permutations numsPicked) 
'((5 25 10)
  (25 5 10)
  (5 10 25)
  (10 5 25)
  (25 10 5)
  (10 25 5))


|#


;Recursion on list + using eval to evaluate them
(define (evalListRec l a)
  (if (null? l)
      a
      (evalListRec (cdr l)(cons (car l) a))))

;New function passing in a list, and calling anoter function 
(define (stuff l )(evalListRec l null))

(define p (stuff posEval))
;p




(define (testCond l a)
  (cond ((null? l) a)
        ((and (integer? (eval (car l) ns)) (positive? (eval (car l) ns)) (equal? 250 (eval (car l) ns))) (testCond (cdr l)(cons (car l)  a)))
        (else (testCond (cdr l) a))))




;============================= Custom Cartisian-product ============================
(define (X . sets)
  (if (null? sets) '(())
      (let ((tails (apply X (cdr sets))))
        (apply append
               (map (lambda (h)
                      (map (lambda (t) (cons h t)) tails))
                    (car sets))))))


(define lst (X opers numsPicked numsPicked))

(define (stuffff l )(testCond lst null))

(define ccc (stuffff lst))
'ccc


;Not Correct but looks promising
(define posEval2 (cartesian-product opers numsPicked  numsPicked))

'(X opers numsPicked numsPicked numsPicked) ; (- 25 5 5) etc
'(eval (car posEval2) ns)
;===================================================================================

;Working through the list of pos solutions
;(car posEval);'(* 5 5)
;(cdr (car posEval));'(5 5)
;(car(cdr (car posEval)));5
;(cadr(cdr (car posEval)));5
;(equal? (car(cdr (car posEval))) (cadr(cdr (car posEval))));#t


;Atempted Recursion on list + using eval to evaluate them
(define (evalCond l a)
  (cond ((null? l) a)
        ((and (integer? (eval (car l) ns)) (positive? (eval (car l) ns)) (equal? target (eval (car l) ns))) (evalCond (cdr l)(cons (car l)  a)))
        (else (evalCond (cdr l) a))))

; Works for getting all the pairs as a list that give me a number = 30
;((and (integer? (eval (car l) ns)) (positive? (eval (car l) ns)) (equal? 30 (eval (car l) ns))) (evalCond (cdr l)(cons (car l)  a))) ; evaluates the list of pos com(cons (eval(car l)ns)a)))
;((equal? (car(cdr (car l))) (cadr(cdr (car l)))) (evalCond (cdr l)(cons (car l)  a))) ;EQUAL 
;((not(equal? (car(cdr (car l))) (cadr(cdr (car l))))) (evalCond (cdr l)(cons (car l)  a))) ;NOT EQUAL





;New function passing in a list, and calling anoter function 
(define (stuffCond l )(evalCond l null))

;
(define solutions (remove-duplicates(stuffCond posEval)))

;Call the function and evaluate
"Solution"
solutions




;============================> Reverse Polish Notation Solution <=============================
"==========> Reverse Polish Notation"
;https://rosettacode.org/wiki/Parsing/RPN_calculator_algorithm#Racket

(define (calculate-RPN lst)
  (for/fold ([stack '()]) ([token lst])
    ;(printf "~a\t -> ~a~N" token stack)
    (match* (token stack)
     [((? number? n) s) (cons n s)]
     [('+ (list x y s ___)) (cons (+ x y) s)]
     [('- (list x y s ___)) (cons (- y x) s)]
     [('* (list x y s ___)) (cons (* x y) s)]
     [('/ (list x y s ___)) (cons (/ y x) s)]
     [('^ (list x y s ___)) (cons (expt y x) s)]
     [(x s) (error "calculate-RPN: Cannot calculate the expression:" 
                   (reverse (cons x s)))])))


'(calculate-RPN '(6 3 1 / -))

(calculate-RPN '(6 3 / 1 -))

;(define emptylst '())
;(append emptylst (permutations (list 2 7 9 10 50 25)))


;(append emptylst (permutations (list "a" "b" "c" "d")))

;(define posEval3 (cartesian-product emptylst (permutations (list "a" "b" "c" "d"))))


;Racket Help In Class

;RACKET HELP RPN
;see num. add to stack
;see operator , pop 2 nums from stack, apply the operator to the 2 nums and add back to the list
;every per/combination ,check on every part of the stack if the number gets to a - fraction etc.

;!quote on operators to not eval


;print stack on getting the right

;evaluate correct RPN
;(1 1 1 -1 -1 1 1 1 -1 -1 -1)

;cart (op op op op op) 1024 pos 
;list length ********

;cp all ops all nums




;permutatin factorial

;filter 
; (100 25 '- 1 '+ )

;Picks a random item from the list Passed in
(define (rand-item l)
  (list-ref l (random (length l))))

(define startPerm (list '- '+ '/ '* 5 3 25 100))
(define posSolPerm (remove-duplicates (permutations startPerm)))

(define (make-rpn l)
  (append (list 2 9) l(list (rand-item opers))))


(define (posSolu lst)(map make-rpn posSolPerm))
(length (posSolu posSolPerm))
'(posSolu posSolPerm)

;(calculate-RPN (posSolu posSolPerm))
;car and the car of the cdr pops the 2 off the list
;(map make-rpn x)
;(calculate-RPN (posSolu x))


;e = expresion
;s=stack
;[s 0] optional argument s=0
;(if (=(car (list 1 1 -1)) 1)#t #f)

;======= Checking to see if passed in list is valid RPN
(define (is-valid-rpn? e [s 0])
  (begin
    (printf "~a\t -> ~a~N" e s)
    (if (null? e)
        (if (= s 1) #t #f);If the Stack is = 1 at the end, RPN = true else false
        (if (= (car e) 1);If the car of the list is 1
            (is-valid-rpn? (cdr e) (+ 1 s));Call is-valid-rpn? with the Cdr and add 1 to the stack
            (is-valid-rpn? (cdr e) (+ (car e) (cadr e))));ELSE RPN, Add 1 to what ever is on the stack
        )))
  ;call valid-rpn? again. pop 2 off stack and eval it, then push to the stack 
      ;()))
(define templst (list -1 1 1))
'(is-valid-rpn? templst)





#| Steps To RPN

- Pass the list of all posible Combinations into RPN Function 8! = 40320 posible combinations
- 

|#

;VERSION 2
(define (is-valid-rpn2? e [s '()])
  (begin
    (printf "~a\t -> ~a~N" e s)
    (if (null? e)
        (if (= (car s) 1) #t #f);If the Stack is = 1 at the end, RPN = true else false
        (if (= (car e) 1);If the car of the list is 1
            (is-valid-rpn2? (cdr e) (cons (car e) s));Call is-valid-rpn? with the Cdr and add 1 to the stack
            (is-valid-rpn2? (cdr e) (cons(+(car s) (cadr s))'()));ELSE RPN, Add whatevers on the stack together
        ))))
  ;call valid-rpn? again. pop 2 off stack and eval it, then push to the stack 
      ;()))

'(is-valid-rpn2? (list 1 1 -1))

(define templst2 (remove-duplicates(permutations (list 1 1 -1))))
'(map is-valid-rpn2? templst2)




;VERSION 3
(define-syntax letcc
  (syntax-rules ()
    ((letcc var body ...)
     (call-with-current-continuation
       (lambda (var)  body ... )))))

(define-syntax try 
  (syntax-rules () 
    ((try var a . b) 
     (letcc success 
       (letcc var (success a)) . b))))


;kinda works on some expresions
(define (is-valid-rpn4? e [s '()] [x '()])
  (begin
    (printf "~a\t -> ~a~N" e s)
    (if (null? e)
        x
        (if (number? (car e));is Car a number?
            (is-valid-rpn4? (cdr e) (cons (car e) s) (cons (car e) x));if yes add it to the stack
            (if (> (length s) 1);else 
                (is-valid-rpn4? (cdr e) (cons(eval((car e) (car s) (cadr s))ns)'())(cons (car e) x))           
                #f
                )
            ))))
;PASS IN THE LIST TO IS-VALID-RPN
;CHECK IF THE LIST IS NULL (YES-> RETURN THE STACK)
; ELSE CHECK IF THE CAR OF THE LIST IS A NUMBER (YES -> ADD THE NUMBER TO THE STACK AND CALL IS-VALID-RPN WITH THE CDR)
;  ELSE IF (STACK LENGTH > 2) CREATE A NEW LIST FROM (EVAL(THE OPERATOR FROM THE LIST AND THE 2 NUMBERS FROM THE STACK)) AND CALL CDR ON THE REST OF THE LIST
;




;Function - Gets a random item from the list passed in
(define (rand-element l)
  (list-ref l (random (length l))))

; Gets the permutaions and Removes all duplicates from the list
(define permu (remove-duplicates (permutations (list - + / *  3 7 2 10))))

;Appends the 2 numbers at the start to the list passed in and a random operator at the end
(define (rpn l)
  (append (list 50  8) l (list(rand-element opers))))

;maps the list to the function 
(define (pos-Solu lst)(map rpn permu))
;(pos-Solu permu)


(length (pos-Solu permu))




(define (is-valid-rpn3? e [s '()] [x '()])
  (begin
    ;(printf "~a\t -> ~a~N" e s)
    (if (null? e)
        (list x s)
        (if (number? (car e));is Car a number?
            (is-valid-rpn3? (cdr e) (cons (car e) s) (cons (car e) x));if yes add it to the stack
              (with-handlers ([exn:fail? (lambda (exn) #f)]);catch errors can use 'message to write own message
                (is-valid-rpn3? (cdr e) (cons (eval((car e) (cadr s) (car s))ns)'()) (cons (car e) x)))            
            ))))


;(is-valid-rpn3? (list 1 1 -1))

;(remove-duplicates(permutations (list 1 2 '-)))
;(pos-Solu permu)


(define (f lst)
  (filter positive? lst))

(define (r lst)
  (filter real? lst))

(define (i lst)
  (eval lst))

;(define templst3 (remove-duplicates(permutations (list 1 2 3 + -))))
(filter identity(map is-valid-rpn3? (pos-Solu permu))) ;length = 576


             














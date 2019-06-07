;Importing packages

(import nrc.fuzzy.*)
(import nrc.fuzz.jess.*)
(load-package nrc.fuzzy.jess.FuzzyFunctions)


;Define Business Template
 
(deftemplate Business_Portfolio
    (slot customer_name)
    (slot age (type INTEGER))
    (slot ssn_yesno (allowed-values Yes No))
    (slot number_credit (type INTEGER)) 
    (slot credit_score (type INTEGER))
    (slot stock_invest)
	(slot number_property)
	(slot est_prop_val)
	(slot bank_bal)
	(slot loan_owed)	
)


;Define Templates for fuzzy variables

(deftemplate credit_score
    "Auto-generated"
    (declare (ordered TRUE)))
(deftemplate stock_invest
    "Auto-generated"
    (declare (ordered TRUE)))
(deftemplate number_property
    "Auto-generated"
    (declare (ordered TRUE)))	
(deftemplate est_prop_val
    "Auto-generated"
    (declare (ordered TRUE)))	
(deftemplate bank_bal
    "Auto-generated"
   (declare (ordered TRUE)))
(deftemplate loan_owed
    "Auto-generated"
   (declare (ordered TRUE)))


;Declare fuzzy variables with value range  

(defglobal ?*creditScoreVar* = (new FuzzyVariable "credit_score" 300 850))
(defglobal ?*stockVar* = (new FuzzyVariable "stock_invest" 0 200000))
(defglobal ?*propNumVar* = (new FuzzyVariable "number_property" 0 10))
(defglobal ?*propValVar* = (new FuzzyVariable "est_prop_val" 0 1000000))
(defglobal ?*bankBalVar* = (new FuzzyVariable "bank_bal" 0 250000))
(defglobal ?*loanVar* = (new FuzzyVariable "loan_owed" 0 200000))
(call nrc.fuzzy.FuzzyValue setMatchThreshold 0.1)


;Define other variables

(defglobal ?*cname* = nil)
(defglobal ?*cAge* = nil)
(defglobal ?*cSsn* = nil)
(defglobal ?*cCards* = nil)
(defglobal ?*cCredit* = nil)
(defglobal ?*cStock* = nil)
(defglobal ?*cProp* = nil)
(defglobal ?*cVal* = nil)
(defglobal ?*cBal* = nil)
(defglobal ?*cLoan* = nil)

;Declaring the rules of the system

;Rule 1
(defrule MAIN::init-FuzzyVariables
    (declare (salience 101))
    ?Business_Portfolio <- (Business_Portfolio (customer_name ?customer_name))
    =>
	
    (call ?*creditScoreVar* addTerm "poor" (new ZFuzzySet 350 580))
    (?*creditScoreVar* addTerm "fair" (new TrapezoidFuzzySet 580 620 660 700))
    (?*creditScoreVar* addTerm "good" (new SFuzzySet 700 850))
	
    (?*stockVar* addTerm "low" (new ZFuzzySet 0 50000))
    (?*stockVar* addTerm "medium" (new TrapezoidFuzzySet 50000 80000 120000 150000))
    (?*stockVar* addTerm "high" (new SFuzzySet 150000 200000))
	
	(?*propNumVar* addTerm "low" (new ZFuzzySet 1 2))
    (?*propNumVar* addTerm "moderate" (new TrapezoidFuzzySet 3 4 5 6))
    (?*propNumVar* addTerm "high" (new SFuzzySet 8 10))
    
	(?*propValVar* addTerm "low" (new ZFuzzySet 0 200000))
    (?*propValVar* addTerm "moderate" (new TrapezoidFuzzySet 200000 400000 500000 600000))
    (?*propValVar* addTerm "high" (new SFuzzySet 800000 1000000))
    
	(?*bankBalVar* addTerm "low" (new ZFuzzySet 0 50000))
    (?*bankBalVar* addTerm "moderate" (new TrapezoidFuzzySet 50000 100000 150000 200000))
    (?*bankBalVar* addTerm "high" (new SFuzzySet 200000 250000))
    
	(?*loanVar* addTerm "less" (new ZFuzzySet 0 40000))
    (?*loanVar* addTerm "medium" (new TrapezoidFuzzySet 40000  80000 120000 150000))
    (?*loanVar* addTerm "high" (new SFuzzySet 150000 200000))
    
	(assert (credit_score (new FuzzyValue ?*creditScoreVar* (new SingletonFuzzySet ?Business_Portfolio.credit_score))))
	(assert (stock_invest (new FuzzyValue ?*stockVar* (new SingletonFuzzySet ?Business_Portfolio.stock_invest))))
    (assert (number_property (new FuzzyValue ?*propNumVar* (new SingletonFuzzySet ?Business_Portfolio.number_property))))
    (assert (est_prop_val (new FuzzyValue ?*propValVar* (new SingletonFuzzySet ?Business_Portfolio.est_prop_val))))
	(assert (bank_bal (new FuzzyValue ?*bankBalVar* (new SingletonFuzzySet ?Business_Portfolio.bank_bal))))
    (assert (loan_owed (new FuzzyValue ?*loanVar* (new SingletonFuzzySet ?Business_Portfolio.loan_owed))))        
)

;Rule 2
(defrule printFacts
    (declare (salience 102))
    =>
    (printout t " " crlf)
	(printout t " " crlf)
    (facts)
)

;Rule 3
(defrule InitSetup
    (declare (salience 100))
    =>
    (printout t crlf crlf)
    (printout t "*******************BUSINESS PORTFOLIO RATING SYSTEM****************" crlf)
    (printout t "Enter all your details to generate your portfolio and to review it" crlf)
    (printout t crlf crlf)    
)


;Rule 4
(defrule CustomerDetails
    (declare (salience 95))
    =>
	(printout t crlf "Enter your name: ")
	(bind ?*cname* (read t))
	(printout t crlf "Enter age: ")
	(bind ?*cAge* (read t))
	(printout t crlf "Do you have an SSN(Yes/No): ")
	(bind ?*cSsn* (read t))
	(printout t crlf "How many credit cards do you own: ")
	(bind ?*cCards* (read t))
	(printout t crlf "What is your credit score (Enter value between 350-850): ")
	(bind ?*cCredit* (read t))
	(printout t crlf "Enter the amount of your stock investments in dollars(0-200000): ")
	(bind ?*cStock* (read t))
	(printout t crlf "Enter the number of properties that you own (0-10): ")
	(bind ?*cProp* (read t))
	(printout t crlf "What is the estimated value of your overall properties in dollars(0-1000000): ")
	(bind ?*cVal* (read t))
	(printout t crlf "What is your bank balance in dollars(0-250000): ")
	(bind ?*cBal* (read t))
	(printout t crlf "What amount do you owe in loans in dollars(0-200000): ")
	(bind ?*cLoan* (read t))
	(assert (Business_Portfolio (customer_name ?*cname*)
            (age ?*cAge*) (ssn_yesno ?*cSsn*) (number_credit ?*cCards*)
            (credit_score ?*cCredit*)  (stock_invest ?*cStock*)  (number_property ?*cProp*)  (est_prop_val ?*cVal*)
            (bank_bal ?*cBal*)  (loan_owed ?*cLoan*)))
)


;Rule 5
(defrule DerivationsScreen
    (declare (salience 90))
    ?Business_Portfolio <- (Business_Portfolio (customer_name ?customer_name))
    =>
    (printout t crlf)
    (printout t "Review of your portfolio along with the reasons that helped us estimate your chances: " crlf)
    (printout t "____________________________________________________________________________________________________________" crlf)        
    (printout t crlf) 
    (printout t "Hello " ?Business_Portfolio.customer_name " !!!" crlf crlf )
)

;Rule 6
(defrule ssnAvailable
    (declare (salience 85))
    ?Business_Portfolio <- (Business_Portfolio (customer_name ?customer_name))
    =>
    (if (= ?Business_Portfolio.ssn_yesno No) then
        (printout t "Please try to apply for SSN soon in order to have a stronger candidacy for starting a private business." crlf)
        )
)

;Rule 7
(defrule creditCardsHigh
    (declare (salience 85))
    ?Business_Portfolio <- (Business_Portfolio (customer_name ?customer_name))
    =>
    (if (> ?Business_Portfolio.number_credit 8) then
        (printout t "You have a high number of credit cards issued under your name. Please make sure to make timely payments in order to keep your credit score within check as it might inturn affect your candidacy." crlf)
    )
)

;Rule 8
(defrule creditscore_poor
    (declare (salience 85))
    (credit_score ?Business_Portfolio&:(fuzzy-match ?Business_Portfolio "poor"))
    =>
    (printout t "Customer has a poor credit score which is a hindrance while starting a private business" crlf)  
)

;Rule 9
(defrule creditscore_fair
    (declare (salience 85))
    (credit_score ?Business_Portfolio&:(fuzzy-match ?Business_Portfolio "fair"))
    =>
    (printout t "Customer has a fair credit score which might be a problem for starting a private business. Please try to make timely payments of credit dues to ensure good score." crlf)  
)

;Rule 10
(defrule creditscore_good
    (declare (salience 85))
    (credit_score ?Business_Portfolio&:(fuzzy-match ?Business_Portfolio "good"))
    =>
    (printout t "Customer has a good credit score. Starting a private business shouldn't be an issue here." crlf)  
)

;Rule 11
(defrule stock_low
    (declare (salience 85))
    (stock_invest ?Business_Portfolio&:(fuzzy-match ?Business_Portfolio "low"))
    =>
    (printout t "You have lower stock investments which hampers your portfolio." crlf)  
)

;Rule 12
(defrule stock_med
    (declare (salience 85))
    (stock_invest ?Business_Portfolio&:(fuzzy-match ?Business_Portfolio "medium"))
    =>
    (printout t "Medium stock investments of yours would be helpful to your cause." crlf)  
)

;Rule 13
(defrule stock_high
    (declare (salience 85))
    (stock_invest ?Business_Portfolio&:(fuzzy-match ?Business_Portfolio "high"))
    =>
    (printout t "High stock investments of yours would be helpful." crlf)  
)

;Rule 14
(defrule propNum_low
    (declare (salience 85))
    (number_property ?Business_Portfolio&:(fuzzy-match ?Business_Portfolio "low"))
    =>
    (printout t "You own a low number of properties which might be problematic." crlf)  
)

;Rule 15
(defrule propNum_mod
    (declare (salience 85))
    (number_property ?Business_Portfolio&:(fuzzy-match ?Business_Portfolio "moderate"))
    =>
    (printout t "You own a decent number of properties which might help your cause." crlf)  
)

;Rule 16
(defrule propNum_high
    (declare (salience 85))
    (number_property ?Business_Portfolio&:(fuzzy-match ?Business_Portfolio "high"))
    =>
    (printout t "You own a good number of properties which might help your cause." crlf)  
)

;Rule 17
(defrule propVal_low
    (declare (salience 85))
    (est_prop_val ?Business_Portfolio&:(fuzzy-match ?Business_Portfolio "low"))
    =>
    (printout t "Your estimated property value is somewhat low which is a bad indicator." crlf)  
)

;Rule 18
(defrule propVal_moderate
    (declare (salience 85))
    (est_prop_val ?Business_Portfolio&:(fuzzy-match ?Business_Portfolio "moderate"))
    =>
    (printout t "Your estimated property value is somewhat moderate which is a positive indicator." crlf)  
)

;Rule 19
(defrule propVal_high
    (declare (salience 85))
    (est_prop_val ?Business_Portfolio&:(fuzzy-match ?Business_Portfolio "high"))
    =>
    (printout t "Your estimated property value is quite high which is a good indicator." crlf)  
)

;Rule 20
(defrule bankBal_low
    (declare (salience 85))
    (bank_bal ?Business_Portfolio&:(fuzzy-match ?Business_Portfolio "low"))
    =>
    (printout t "You have a low bank balance which is a hindrance while starting a private business" crlf)  
)

;Rule 21
(defrule bankBal_mod
    (declare (salience 85))
    (bank_bal ?Business_Portfolio&:(fuzzy-match ?Business_Portfolio "moderate"))
    =>
    (printout t "You have a moderate bank balance. This may or may not affect your profile though." crlf)  
)

;Rule 22
(defrule bankBal_high
    (declare (salience 85))
    (bank_bal ?Business_Portfolio&:(fuzzy-match ?Business_Portfolio "high"))
    =>
    (printout t "You have a good bank balance which is crucial for starting a new business." crlf)  
)

;Rule 23
(defrule loan_less
    (declare (salience 85))
    (credit_score ?Business_Portfolio&:(fuzzy-match ?Business_Portfolio "poor"))
    =>
    (printout t "You owe low amount in loans. This wont affect your profile but you must try to clear any loans under your name to boost your chances." crlf)  
)

;Rule 24
(defrule loan_med
    (declare (salience 85))
    (credit_score ?Business_Portfolio&:(fuzzy-match ?Business_Portfolio "fair"))
    =>
    (printout t "You owe a moderate amount in loans which might affect your profile." crlf)  
)

;Rule 25
(defrule loan_high
    (declare (salience 85))
    (credit_score ?Business_Portfolio&:(fuzzy-match ?Business_Portfolio "good"))
    =>
    (printout t "You have a high loan amount impending." crlf)  
)

;Rule 26
(defrule ageLower
    (declare (salience 85))
    ?Business_Portfolio <- (Business_Portfolio (customer_name ?customer_name))
    =>
    (if (< ?Business_Portfolio.age 18) then
        (printout t "You are under the age of 18." crlf)
    )
)

;Rule 27
(defrule ageUpper
    (declare (salience 85))
    ?Business_Portfolio <- (Business_Portfolio (customer_name ?customer_name))
    =>
    (if (>= ?Business_Portfolio.age 18) then
        (printout t "You are over 18 years of age which makes you eligible." crlf)
    )
)

;Rule 28
(defrule printFacts
    (declare (salience 102))
    =>
    (printout t " " crlf)
	(printout t " " crlf)
    (facts)
)

;Rule 29
(defrule portfolio_rating
    (declare (salience 91))
    ?x <- (Business_Portfolio (customer_name ?customer_name))
    =>
	(if (or (< ?x.age 18) (= ?x.ssn_yesno No) (> ?x.loan_owed 150000) (< ?x.credit_score 580) (< ?x.bank_bal 50000)) then
		(printout t crlf crlf "************Portfolio Evaluation Completed*********" crlf)
		(printout t " " crlf)
        (printout t "Considering all the factors such as credit score, bank balance, stock investments, loan owed, etc. you might face issues while starting a private business. The candidacy might be improved if you look into the summary/review of your portfolio for potential shortcomings." crlf crlf)
		(printout t "__________________________________________________________________________________________________________" crlf)
	else
		(printout t crlf crlf "************Portfolio Evaluation Completed*********" crlf)
		(printout t " " crlf)
        (printout t "Considering all the factors such as credit score, bank balance, stock investments, loan owed, etc. you have a satisfactory portfolio for starting a private business." crlf crlf)
        (printout t "__________________________________________________________________________________________________________" crlf)      
        )
)

;Rule 30
(defrule creditCardsFine
    (declare (salience 85))
    ?Business_Portfolio <- (Business_Portfolio (customer_name ?customer_name))
    =>
    (if (< ?Business_Portfolio.number_credit 8) then
        (printout t "You have some credit cards issued under your name. Please make sure to make timely payments in order to keep your credit score within check as it might inturn affect your candidacy." crlf)
    )
)

;Rule 31
(defrule finishExecute
    (declare (salience 70))
    =>
    (printout t "__________________________________________________________________________________________________________" crlf)
)

(reset)
(run) 
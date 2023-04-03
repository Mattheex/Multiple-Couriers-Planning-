# Multiple-Couriers-Planning - Project Work Combinatorial Decision Making Optimization 2022/2023

## Introduction
objective is to minimize the maximum distance travelled by any courier
![image](https://user-images.githubusercontent.com/90778803/229518691-5d854f34-75cf-40e6-a91a-f66634a00683.png)
The project work includes building models as well as conducting an experimental
study to assess the performance of the solvers using different models and search
strategies


The CP model must be implemented in **MiniZinc** and run using at least
Gecode, whereas the **SAT model** must be implemented using at least **Z3**.
For both **SMT and MIP models**, students can use their favourite theories, solvers and languages.

Solving processes that exceed a time limit of 5 minutes (300 secs) should
be aborted.

While a MiniZinc
notation could be acceptable to describe a CP model, it is required in general
to use propositional logic, first-order logic and appropriate mathematical notations. Do not copy and paste code!

The report should be written in LATEX max 15 pages

## CP Model - Description of our model

### Decision variables
Describe all the decision variables of your model, their initial domains (such as the lower and upper bounds), and their semantics

### Objective function
Describe here what is not covered in Section 1. Then explain the objective function. For example, “the objective function is to minimize area"

### Problem constraints
State the problem constraints, give their formulation and explain them

### Experimental study
Explain which solvers you used and which search strategies you employed, as well as your experimental set up

### Experimental results
1. rows are labeled with the identifier of the instances
2. columns are labeled with the different approaches you tried
3. cells contain the best objective value (not the runtime)

##  SAT Model
Groups up to 3 students can choose between SAT and SMT (Bonus point if they do both)
If we choose to do SMT -> duplicate the SAT Model part

### Decision variables
Describe all the literals of your model and their semantics.

### Objective function
Explain how you managed to do optimization in SAT

### Constraints
Describe all the clauses of your model and their semantics. In particular, describe the encoding(s) that you used

### Validation
The model must be implemented using at least Z3

## MIP Model

### Decision variables

### Objective function

### Constraints

### Validation

## How did we split the work

## Difficulties encountered

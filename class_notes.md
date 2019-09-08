# A class on Bayesian Statistics using Stan

A list of topics for an 8 week course on Bayesian statistics that takes you from understanding probability to multilevel modeling in Stan. The main reference is _A Student's Guide to Bayesian Statistics_ by Ben Lambert. Below are links to additional book and course references, including links to freely available lectures on YouTube.

## Bayesian book references:
1. _A Student's Guide to Bayesian Statistics_ by Ben Lambert. [Video Lectures](https://www.youtube.com/playlist?list=PLwJRxp3blEvZ8AKMXOy0fc0cqT61GsKCG) and [book website](https://ben-lambert.com/a-students-guide-to-bayesian-statistics/)
2. _Statistical Rethinking_ by Richard McElreath. [Course video lectures](https://www.youtube.com/playlist?list=PLDcUM9US4XdNM4Edgs7weiyIguLSToZRI) and [GitHub repo](https://github.com/rmcelreath/rethinking/tree/Experimental)
3. _Bayesian Analysis for the Social Sciences_ by Simon Jackman [publisher link](https://onlinelibrary.wiley.com/doi/book/10.1002/9780470686621)

## Probability references
1. _Introduction to Probability_ by Joseph Blitzstein and Jessica Hwang, published by CRC Press in 2015. [Book, materials, and video lectures here](https://projects.iq.harvard.edu/stat110).
2. _Probability Theory: The Logic of Science_ by E.T. Jaynes, published by Cambridge University Press in 2003, [PDF available here](http://www.medicine.mcgill.ca/epidemiology/hanley/bios601/GaussianModel/JaynesProbabilityTheory.pdf)

## Links to academic courses
1. Columbia's _Bayesian Statistics for the Social Sciences_ [Class website](https://courseworks2.columbia.edu/courses/72393), [Video Lectures](https://www.youtube.com/playlist?list=PLSZp9QshJ8wwWjrsGDbguwcPLUwHWUxo0)
2. _Statistical Thinking for Data Science and Analytics_ by Gelman and friends [edX course page](https://www.edx.org/course/statistical-thinking-for-data-science-and-analytics)

## Stan References
1. [Stan homepage](https://mc-stan.org/) which includes programming references, examples, and guidance on how to implement a robust Stan workflow.
2. [Stan documentation](https://mc-stan.org/users/documentation/)
3. [Online discussion forum](https://discourse.mc-stan.org/)
4. [Case studies with Stan](https://mc-stan.org/users/documentation/case-studies)
5. [StanCon Talks](https://github.com/stan-dev/stancon_talks)

## Course Outline by Week

### Course goals
1. Understand the basic theory and motivation of Bayesian inference.
2. Know how to critically assess a statistical model.
3. Appreciate why we often need to use sampling in Bayesian inference.
4. Grasp how modern MCMC algorithms work intuitively and how to implement these in practice.
5. Know how to code up most models in Stan.
6. Recognize the benefits of multilevel models and how these can be used to provide robust inferences.

### Why Bayes?
1. Simple and intuitive model building (unlike frequentist statistics there is no need to remember lots of specific formulae).
2. Exhaustive and creative model testing.
3. Straightforward interpretation of results.
4. Bayes rule is the only method to invert the probability of the data given a hypothesis that is consistent with the logic of probability.


### Informed interactions with data

>  Blind allegiance to theory or unequivocal adherence to data will not deliver useful knowledge. Optimal gains in knowledge can only occur when we engage in an informed dialogue with data
>  Todd D. Little



## Week 1, the theory of inference

Chapters 2 and 3 of _Student's Guide_.

### Knowledge goals
1. Become aware of the motivation for statistical inference.
2. Understand the similarities and differences between Frequentist and Bayesian approaches to inference.
3. Know how to manipulate probability distributions.

### Computational goals
1. Compute conditional distributions of a table of multivariate data.
2. Develop code to plot probability distributions and slices of conditional distributions.
3. Develop intuition for the central limit theorem through simulation exercises.


## Week 2, Bayes formula in detail

Chapters 4, 5, 6, and 7 of _Student's Guide_.

### Knowledge goals
1. Understand how to choose a likelihood for any given situation.
2. Intuition for maximum likelihood estimation.
3. Knowledge of the role and philosophies behind prior distributions.
4. Appreciate the complexity of calculating the denominator in Bayes' formula.
5. Grasp of the posterior and how to summarize it.

### Computational goals
1. Compute maximum likelihood of a given probability model.
2. Estimate probabilities of various events from a given model.
3. Construct a Bayes box for simple problems.
4. Given draws from a posterior, compute summaries (mean, median, MAP estimator).
5. Generate samples from a prior predictive distribution.
6. Generate samples from a posterior predictive distribution.

_**Introduction Stan this week?**_

## Week 3, Analytic Bayesian inference

Chapters 8 and 9 of _Student's Guide_.

### Knowledge goals
1. Familiarity with the most commonly used probability distributions.
2. Knowledge of standard choices for the likelihood in a given situation.
3. Understanding of conjugate priors.
4. Ability to write down and test a conjugate model in a range of settings.
5. Grasp of the limits of conjugate models.

### Computational goals
1. Basic knowledge of Stan.
2. Experience sampling from distributions in Stan, Python, and R.
3. Knowledge of documentation in Stan, Python, and R on probability distributions.
4. Develop toolkit for estimating a conjugate model.


## Week 4, Bayesian inference in practice

Chapter 10 of _Student's Guide_.

### Knowledge goals
1. one
2. two

### Computational goals
1. one
2. two

## Week 5, introduction to MCMC

Chapter 12 of _Student's Guide_.

### Knowledge goals
1. one
2. two

### Computational goals
1. one
2. two

## Week 6, modern MCMC methods

Chapters 13, 14, and 15 of _Student's Guide_.

### Knowledge goals
1. one
2. two

### Computational goals
1. one
2. two

## Week 7, introduction to Stan and multilevel modeling

Chapters 16 and 17 of _Student's Guide_.

### Knowledge goals
1. one
2. two

### Computational goals
1. one
2. two

## Week 8, applied Bayesian inference

Chapters 18 and 19 of _Student's Guide_.

### Knowledge goals
1. one
2. two

### Computational goals
1. one
2. two

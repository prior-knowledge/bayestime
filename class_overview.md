# An introduction to Bayesian statistical computing using Stan

This course provides an 8-week journey from the basics of probability to being proficient in a modern Bayesian statistical workflow. Throughout the course students will complete cycles of the workflow, successively learning more about the bits and pieces. Lectures provide the intuition and theory underpinning a part of the process, and computer labs provide the opportunity to apply this newly acquired knowledge in a series of experiments and challenges.

The main reference is _A Student's Guide to Bayesian Statistics_ by Ben Lambert. Below are links to additional book and course references, including links to freely available lectures on YouTube.

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
4. Grasp how modern MCMC algorithms work intuitively and how to recognize when they fail.
5. Know how to code up most models in Stan.
6. Recognize the benefits of multilevel models and how these can be used to provide robust inferences.

### Why Bayes?
1. Simple and intuitive model building (unlike frequentist statistics there is no need to remember lots of specific formulae).
2. Exhaustive and creative model testing.
3. Straightforward interpretation of results.
4. Bayes rule is the only method to invert the probability of the data given a hypothesis that is consistent with the logic of probability.


## Week 0, introduction to probability

### Knowledge goals
1. Intuition of reasoning under uncertainty.
2. Basic probability definitions.

### Computational goals
1. None

## Week 1, probability and the theory of inference

Chapters 2 and 3 of _Student's Guide_.

### Knowledge goals
1. Become aware of the motivation for statistical inference.
2. Understand the similarities and differences between Frequentist and Bayesian approaches to inference.
3. Know how to manipulate probability distributions.

### Computational goals
1. Compute conditional distributions of a table of multivariate data.
2. Develop code to plot probability distributions and slices of conditional distributions.
3. Become familiar with Stan, a probabilistic programming language.
4. Develop intuition for the central limit theorem through simulation exercises.
5. Begin to develop understanding of how to summarize a posterior.
6. Conduct inference and use results to inform a decision.

## Week 2, Bayesian inference engine

### Knowledge goals
1. Become familiar with a Bayesian model: prior and likelihood.
2. Experience applying the Bayesian inference engine to real data.
3. Understand the process of encoding prior knowledge in a Bayesian model.
4. Grasp how priors constrain a model and when that can be fatal.
5. Understand the usefulness of prior predictive checks.

### Computational goals
1. Apply Bayesian inference engine to an actual dataset.
2. Conduct prior predictive checks.


## Week 3, While my sampler gently weeps

### Knowledge goals
1. Understand why computation is an essential part of modern Bayesian inference.
2. Develop an intuition for Markov Chain Monte Carlo algorithms.
3. Become familiar with convergence statistics.

### Computational goals
1. Develop a simple Metropolis Hastings algorithm and apply it to King Markov's island.
2. Visualize MCMC chains produced by a Stan model.
3. Compute Rhat convergence statistics.

## Week 4, Posterior Predictive Checks

### Knowledge goals
1. Experience creating and computing test statistics to check a model's fit.
2. Knowledge of common model fit statistics: WAIC and LOO-CV.
3. Awareness of graphical posterior predictive checks.

### Computational goals
1. Apply posterior predictive checks on a real dataset.

## Week 5, Introduction to Regression

### Knowledge goals
1. Understanding of regression in its various forms.
2. Introduction to multilevel models.

### Computational goals
1. Estimate a regression model using the Bayesian inference engine.

## Week 6, we're on a whole other level

### Knowledge goals
1. Understand how multilevel models endow a model with memory and why that is important.
2. Develop strategy for adding levels to a model and testing their efficacy.

### Computational goals
1. Build, estimate, summarize, and test a multilevel model.

## Week 7, Hamilton crashes the party

### Knowledge goals
1. Intuition for Hamiltonian Monte Carlo and the No-U-Turn Sampler in Stan.
2. Grasp the limits of Metropolis Hastings.
3. Understanding how to tune Stan's sampler and address problems.

### Computational goals
1. Implement parts of HMC.
2. Estimate Stan models in situations where the stock settings fail.

## Week 8, Review of the process of developing, estimating, and testing Bayesian models

### Knowledge goals
1. Reinforce perspective of Bayesian modeling.

### Computational goals
1. Build a Bayesian model from scratch given a dataset.
2. Implement prior predictive checks.
3. Implement posterior predictive checks.
4. Present results in a briefing with graphics.

# Week 1
# _Theory of Inference_

### Goals of week 1:
1. Understand the motivation behind inference.
2. Appreciate the similarities and differences between Frequentist and Bayesian approaches to inference.
3. Know how to manipulate probability distributions.

### Materials for week 1:
1. Chapters 2 and 3 of _Student's Guide to Bayesian Statistics_
2. Lambert's _Lecture 1_ slides.
3. **Bonus** Video lecture on the [_Bayes' Rule: The Theory That Would Not Die_](https://youtu.be/2o-_BGqYM5U) by Sharon McGrayne, first 45 minutes of the video.


### A first take on the steps of Bayesian inference
Watch Lambert's YouTube lecture on [the intuition of Bayes' rule](https://youtu.be/yvWlpwnT1nw), 8 minutes.





1. Define the observables, ie the Big World, ie [Big Sky](https://youtu.be/zOusKPeH7nU) by the Kinks.
2. Specify a likelihood.
3. Specify a prior.
4. Input the data.


## Purpose of Statistical inference
Some questions we want to answer:
1. How much will a student earn after receiving an MBA?
2. Will the Democrats win the next US Presidential election?
3. Did the casino give me weighted dice to play craps?

To answer these questions, we develop theories, gather data, then test the theory. It is difficult to test those theories because we have uncertainty about how the world works (epistemological) and there are many factors outside of our control that introduce noise (ontological).
> It is like trying to listen to a classical orchestra which is playing on the side of a busy street, while we fly overhead in a plane

From _Student's Guide_ page 17
> Statistical inference is the logical framework which we can use to test our beliefs about the noisy world against data. We formalize our beliefs in models of probability.

There are two schools of thought for inference: Bayesian versus frequentist.

#### Statistical Inference, Bayesian versus Frequentist worlds
_Material: Sections 2.3, 2.4, 2.5, 2.6, 2.7 of Students' Guide_

1. Bayes' rule allows us to go from effect back to its cause.
2. Statistical inference is the logical framework which we can use to trial our beliefs about the noisy world against data.
3. Frequentists assume the data is random and results from sampling from a fixed and defined population.
4. Bayesians assume that we are witnesses to the data, which is fixed, and probabilities are an expression of subjective beliefs that can be updated in light of new data.
5. For Bayesians parameters are seen as varying or our knowledge about them is imperfect, while frequentists assume parameters are constant and represent a long run average.

#### Frequentist and Bayesian Inference
_Material: Sections 2.8, 2.9 of Students' Guide_

1. Bayesian inference is the only logical and consistent way to modify our beliefs to account for new data.
2. Frequentists use inverse probability as evidence for a given hypothesis and compute the probability of obtaining a sample as extreme as or more than the one actually obtained assuming a hypothesis is true.
3. Bayes' forumla circumvents the problem of generating fictious samples by inverting the Frequentist probability to obtain the probability of the hypothesis given the data we obtained.
4. Examples: murder trials, radio control towers, coin flipping, ...
5. Inference via Bayes' rule: parameters, probability distribubtions, likelihoods, priors, denominator, posterior.

### Probability Distributions
_Material:_
* _Chapter 3 of Students' Guide_
* _Slides 239 to 285 from Lecture 1_
* _Lambert's YouTube lecture on [random variables and probability distributions](https://youtu.be/pvkhK03aFDM), 7 minutes.
* _Lambert's YouTube lecture on [continuous distributions](https://youtu.be/s87mffcX0xU), 8 minutes._
* _Lambert's YouTube lecture on [discrete distributions](https://youtu.be/4Ghtj_iTSpI), 6 minutes._

#### Why is this important?
Bayesian inference quantifies uncertainty through probability distributions.

#### Discrete Distributions


#### Continuous Distributions


### Two-dimensional probability distributions
_Material:_
* _Sections 3.3.4, 3.3.5 of Students' Guide_
* _Slides 286 to 285 from Lecture 1_



### Conditional distributions
_Material:_
* _Sections 3.3.4, 3.3.5 of Students' Guide_
* _Slides 286 to 285 from Lecture 1_






# Lab

## Central limit theorem
Simulate samples from various probability distributions and compute the mean. Does the distribution of the mean approximate a normal distribution as you increase the number of experiments you conduct?

## Intuition of Bayesian reasoning with coin flips
Work through various coin flipping scenarios to see how Bayesian updates compare with your intuition.

## Decisions about elevators
_Material: slides 130 to 233 of Lecture 1_

Imagine we want to create a model for the frequency a lift (elevator) breaks down in a given year, X . This model will be used to plan expenditure on lift repairs over the following few years.

An aside: [how to survive a falling lift](https://www.npr.org/sections/krulwich/2010/09/17/129934849/how-to-survive-when-your-elevator-plunges)

1. Assume a range of unpredictable and uncorrelated factors (temperature, lift usage, etc.) affect the functioning of the lift, so we say X ∼ Poisson(θ), where θ is the mean number of times the lift breaks in one year.
2. By specifying that X is Poisson-distributed we assume that there is a continuous probability of failure over time.
3. _Important_: we don’t a priori know the true value of θ therefore our model defines collection of probability models; one for each value of θ. We call this collection of models the Likelihood.

By specifying a model framework X ∼ Poisson(θ) we defined the boundaries of the “Small World”. The Small World contains a collection of probability distributions known as the Likelihood.

### First question
Compute the posterior of the average number of failures per year given the data for the last 10 years. Compute the 90 percent credible interval. (```np.quantile```)

### Second question
Using the posterior you computed in the first question, it costs $1000 per repair visit, and we budget $10,000 a year for lift repairs. Over the next 5 years, how many times do we expect to face a repair bill of $15,000 or greater?

### Third question
Suppose you can sign a service contract with an elevator repair company. You can pre-pay for as many repairs in a year as you want for $1000 per repair visit. If the repair is not prepaid, a repair visit costs $1500. How many visits should you prepay? Write a paragraph justifying to your boss why you chose this number and a prediction for the number of times in the next 5 years you expect to exceed the prepaid budget.

### Challenge problem
Suppose you have 4 friends in other buildings who face the same problem as you, and you are able to collectively buy a service contract. Compute the combined Poisson parameter and its credible interval. Would you save money over the next 5 years if you collectively bought a contract?

# Week 1
# _Theory of Inference_

### Goals of week 1:
1. Understand the motivation behind inference.
2. Appreciate the similarities and differences between Frequentist and Bayesian approaches to inference.
3. Know how to manipulate probability distributions.

### Materials for week 1:
1. Chapters 2 and 3 of _Student's Guide to Bayesian Statistics_
2. Lambert's [Lecture 1 slides](https://benlambertdotcom.files.wordpress.com/2016/05/bayesian-course-1-vfinal-vfinal.pdf).
3. **Bonus** Video lecture on the [_Bayes' Rule: The Theory That Would Not Die_](https://youtu.be/2o-_BGqYM5U) by Sharon McGrayne, first 45 minutes of the video.


## Where does all this fit? Inductive vs Deductive research
7 minute video lecture on [inductive and deductive research approaches](https://youtu.be/QB41z6_mUxk) in social science.

There are a couple of paradigms for how we go about creating knowledge:
* **Inductive Research** begins with a research question and the collection of empirical data, which are used to generate hypotheses and theory. The question drives data collection and tests, which we can use to form theories about the world.
* **Deductive Research** approaches begin with a theory-driven hypothesis, which guide data collection and analysis. Theory provides the hypothesis, and we use observations to test.

A philosophical aside to motivate our approach. For more information see [Philosophy and the practice of Bayesian statistics](http://www.stat.columbia.edu/~gelman/research/published/philosophy.pdf) and references listed therein.

>To put it even more succinctly, ‘the model’, for a Bayesian, is the combination of the prior distribution and the likelihood, each of which represents some compromise among scientific knowledge, mathematical convenience and computational tractability

>Instead we make some assumptions, state them clearly, see what they imply, and check the implications. This applies just much to the prior distribution as it does to the parts of the model showing up in the likelihood function.

>We are not interested in falsifying our model for its own sake – among other things, having built it ourselves, we know all the shortcuts taken in doing so, and can already be morally certain it is false. With enough data, we can certainly detect departures from the model – this is why, for example, statistical folklore says that the chi-squared statistic is ultimately a measure of sample size (cf. Lindsay & Liu, 2009). As writers such as Giere (1988, Chapter 3) explain, the hypothesis linking mathematical models to empirical data is not that the data-generating process is exactly isomorphic to the model, but that the data source resembles the model closely enough, in the respects which matter to us, that reasoning based on the model will be reliable. Such reliability does not require complete fidelity to the model.

>The goal of model checking, then, is not to demonstrate the foregone conclusion of falsity as such, but rather to learn how, in particular, this model fails (Gelman, 2003). When we find such particular failures, they tell us how the model must be improved; when severe tests cannot find them, the inferences we draw about those aspects of the real world from our fitted model become more credible. In designing a good test for model checking, we are interested in finding particular errors which, if present, would mess up particular inferences, and devise a test statistic which is sensitive to this sort of misspecification.

>What we are advocating, then, is what Cox and Hinkley (1974) call ‘pure significance testing’, in which certain of the model’s implications are compared directly to the data, rather than entering into a contest with some alternative model. This is, we think, more in line with what actually happens in science, where it can become clear that even large-scale theories are in serious trouble and cannot be accepted unmodified even if there is no alternative available yet. A classical instance is the status of Newtonian physics at the beginning of the twentieth century, where there were enough difficulties – the Michaelson–Morley effect, anomalies in the orbit of Mercury, the photoelectric effect, the black-body paradox, the stability of charged matter, etc. – that it was clear, even before relativity and quantum mechanics, that something would have to give. Even today, our current best theories of fundamental physics, namely general relativity and the standard model of particle physics, an instance of quantum field theory, are universally agreed to be ultimately wrong, not least because they are mutually incompatible, and recognizing this does not require that one have a replacement theory (Weinberg, 1999)

> In practice, if we are in a setting where model A or model B might be true, we are inclined not to do model selection among these specified options, or even to perform model averaging over them (perhaps with a statement such as ‘we assign 40% of our posterior belief to A and 60% to B’) but rather to do continuous model expansion by forming a larger model that includes both A and B as special cases.

>In the social sciences, it is rare for there to be an underlying theory that can provide meaningful constraints on the functional form of the expected relationships among variables, let alone the distribution of noise terms.

> The common core of various conceptions of induction is some form of inference from particulars to the general – in the statistical context, presumably, inference from the observations y to parameters Theta describing the data-generating process.

>Just as the work of normal science proceeds within the presuppositions of the paradigm, updating a posterior distribution by conditioning on new data takes the assumptions embodied in the prior distribution and the likelihood function as unchallengeable truths. Model checking, on the other hand, corresponds to the identification of anomalies, with a switch to a new model when they become intolerable.


>Philosophy matters to practitioners because they use it to guide their practice; even those who believe themselves quite exempt from any philosophical influences are usually the slaves of some defunct methodologist. The idea of Bayesian inference as inductive, culminating in the computation of the posterior probability of scientific hypotheses, has had malign effects on statistical practice. At best, the inductivist view has encouraged researchers to fit and compare models without checking them; at worst, theorists have actively discouraged practitioners from performing model checking because it does not fit into their framework.
> In our hypothetico-deductive view of data analysis, we build a statistical model out of available parts and drive it as far as it can take us, and then a little farther. When the model breaks down, we dissect it and figure out what went wrong. For Bayesian models, the most useful way of figuring out how the model breaks down is through posterior predictive checks, creating simulations of the data and comparing them to the actual data. The comparison can often be done visually; see Gelman et al. (2004, Chapter 6) for a range of examples. Once we have an idea about where the problem lies, we can tinker with the model, or perhaps try a radically new design. Either way, we are using deductive reasoning as a tool to get the most out of a model, and we test the model – it is falsifiable, and when it is consequentially falsified, we alter or abandon it. None of this is especially subjective, or at least no more so than any other kind of scientific inquiry, which likewise requires choices as to the problem to study, the data to use, the models to employ, etc. – but these choices are by no means arbitrary whims, uncontrolled by objective conditions.
> Conversely, a problem with the inductive philosophy of Bayesian statistics – in which science ‘learns’ by updating the probabilities that various competing models are true – is that it assumes that the true model (or, at least, the models among which we will choose or over which we will average) is one of the possibilities being considered. This does not fit our own experiences of learning by finding that a model does not fit and needing to expand beyond the existing class of models to fix the problem.
> Our methodological suggestions are to construct large models that are capable of incorporating diverse sources of data, to use Bayesian inference to summarize uncertainty about parameters in the models, to use graphical model checks to understand the limitations of the models, and to move forward via continuous model expansion rather than model selection or discrete model averaging. Again, we do not claim any novelty in these ideas, which we and others have presented in many publications and which reflect decades of statistical practice, expressed particularly forcefully in recent times by Box (1980) and Jaynes (2003).
> Likelihood and Bayesian inference are powerful, and with great power comes great responsibility. Complex models can and should be checked and falsified. This is how we can learn from our mistakes.





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

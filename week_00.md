# Week 0, Introductions

### Goals of week 0:
1. Intuition of reasoning under uncertainty.
2. Basic definitions of all the pieces of inference.

### Materials for week 0:
1. An open mind.

## What is probability theory?

> Probability theory is nothing but common sense reduced to calculation.
> Laplace, 1819

## Interpretations of Probability
Simplest way is to think about the frequency of something occurring. We can generalize that to probability as the degree of belief in a hypothesis. Allows you to assign probability to things that you cannot repeat.

As a measure of belief or a frequency. By using it as a measure of belief, we can use probability to describe our own uncertainty about things. Belief is a generalization of the frequency definition.

We have two types of uncertainty. Things outside of the system can introduce randomness (ontological), and we have imperfect knowledge about how things work (epistemic):
* Epistemic uncertainty stems from our ignorance about how things work. We don't know exactly how an economy works. We don't exactly know how a disease progresses. We don't exactly know how a people make decisions.
* Ontological uncertainty is inherent to the system and reflects the fact that there are forces outside of our control and limits in our ability to measure them. If I knew the system worked a certain way, we would still have uncertainty about outcomes.

### Setting the Stage

We wanted to open this up to all of your because all of these ideas are useful, and we can start without any preparation. This week is more formal and involves a lot less computer time. In the future, we will be computing many more things, and you will have time to study the material.

### Goal of the course

The goal of this course is to enable you to responsibly answer questions using Bayesian models.

### After this it's just details

We plan to talk about all the topics involved with this goal. Everything after today will just be details. Different probability distributions, discrete versus continuous variables,  Having a grounding in probability theory, t provide a strong grounding in probabilistic

### Let's go to Vegas and not tell anyone

We're going to build up some intuition for the nuts and bolts of probability using examples that you're already familiar with. Suppose you and your friends head to Vegas, and you make a bet that the person who wins the least money buys dinner.

#### Starting at the craps table

You need to get good at craps, so we need to understand how likely certain events are. Rolling dice.
Start simple. Suppose we have one die.
* What is the sample space? {1, 2, 3, 4, 5, 6}.
* What is the event space? {{1}, {2}, ..., {6}, {1 or 2}, {1 or 3}, {1 or 4}, {1, 3, 5}, {2, 4, 6} ...}
* What is the probability of an event? Rolling a {1}? Rolling a {1 or 3}?
* What is the probability of rolling a 1 and an odd number? P(1,odd)
* What is the probability of rolling a 1 and an even number? P(1,even)
* What is the probability of rolling a 1, given that the outcome is odd? P(1 | odd)
* What is the probability of rolling a 1, given that the outcome is less than 4? P(1 | x < 4)
* Now let's rewrite the probability of a 1 as the sum of two joints: P(1) = P(1,even) + P(1,odd)
* What's the probability of rolling a 1 and rolling a number less than 4?
* Now let's rewrite the conditional probability of rolling a 1 given a number less than 4. (Write row of numbers on the board from 1 to 6. Show that sample space is now smaller.)

#### Sherlock Holmes
> Once you eliminate the impossible, whatever remains, however improbable, is the truth.

By ruling out a hypothesis, conditioning makes others more likely.

#### Backup example for independence
Shapes and color example from Lambert page 52.


Now let's graduate to 2 dice. Things are a little more complicated now.
* Event space is: {{1,1},{1,2},{1,3},...{6,5},{6,6}}
* Sample space is: {{1,1}, {same number},{total is 6},{total is 8}, ...}
* What is the probability both are even?
* What is the probability that the sum is 6?
* What is the probability that the sum is 8?
* What is the probability that the sum is 7?

Now let's win some money. If you have $10 to bet, the minimum bet is $5, and you don't care if you lose the $10, what two bets should you make?

#### Moving on to poker

Your friend hits the poker table. Suppose the dealer uses only one 52 card deck.

### Motivating example, disease detections

There has been a big push to detect cancers earlier using tests. Decisions around whether to test, how often to test, and what to do with a result affect millions of people every year. These decisions are informed by probabilistic judgments.

Let's jump in. Suppose you are a doctor specializing in breast cancer. You prescribe a test to a woman over 40, and she tests positive. What next steps do you advise her to take?

* How common is breast cancer among women over 40? According to [cancer.gov](https://www.cancer.gov/types/breast/risk-fact-sheet) a woman in her forties has a 1.47 percent chance of risk of being diagnosed with breast cancer.

* How good is the test? If a woman has cancer, the probability that the test will find the cancer is 75 percent. If the woman does not have cancer, the probability that the test will find cancer is 10 percent.

A quick derivation of Bayes' rule: start with conditional; P(A,B) = P(A|B) P(B)

For this example, we want to know the probability that you have breast cancer given that you tested positive. Start with the English language, then write the equation.

### If time, let's work through some decisions in an uncertain environment

How sensitive does your explosive detection system at an airport have to be before you should deploy it?

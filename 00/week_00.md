# Week 0
# _Building Blocks of Probability_

### Goals of week 0:
1. Develop understanding of the building blocks of probability.
2. The importance of thinking conditionally.

### Computational goals of week 0:
1. Sample from a pseudo random number generator to gain experience with counting and sampling variability.
2. Compute the probability of joint events.
3. Compute the probability of conditional events.

### Materials for week 0:
1. An open mind.

## What is probability theory?

> Probability theory is nothing but common sense reduced to calculation.
> Laplace, 1819

> The actual science of logic is conversant at present only with things either certain, impossible, or entirely doubtful, none of which (fortunately) we have to reason on. Therefore the true logic for this world is the calculus of Probabilities, which takes account of the magnitude of the probability which is, or ought to be, in a reasonable person's mind.
> James Clerk Maxwell, 1850

Our worlds are filled with reasoning about uncertain events. Before you sat down to read this material on probability, you likely thought about whether to bring an umbrella with you, which route to take to work, and whether to grab coffee at the cafe on the left or right side of the street. What reasoning process did you employ to arrive at your decisions? You weren't _certain_ that the route you chose would take less time than the alternatives, but you constructed a plausible argument to inform your choice. None of these situations provides enough information to permit deductive reasoning.

We cannot say with certainty that if the light at Elm Street turns green, our commute will be less than 20 minutes. We might not see the wreck that just happened, or we do not know that the construction crew picked up their barricades late. We can, however, say that if the light turns green, then it becomes more _plausible_ that our commute will be less than 20 minutes.

Why is it more plausible that our commute will take less than 20 minutes if the light at Elm turns green? We usually have prior information to asses the degree of plausibility. Maybe we just spoke with a friend who took the same route and said that was the outcome she had, maybe you have driven through Elm many times before and remember approximate commute times when the light was and was not green. Constructing the plausibility of this event is a complex process, but we might just call it common sense.

Suppose we want to encode this knowledge in mathematics, so that others can use it. To do this we need to define:
1. A sample space or the set of all possible outcomes,
2. The set of events that could occur in the sample space, and
3. A measure of the plausibility of each event.

### Example, flipping a coin
Suppose we flip a coin once, how do we set this up? The sample space is {H, T}. Some of the possible events are {H, T}; and the probabilities could be {P(H) = 0.5, P(T) = 0.5}

### Example, rolling a die
Suppose we roll a six sided die once. The sample space, S, is {1, 2, 3, 4, 5, 6}. Some of the possible events are {1, 2, 3, 4, 5, 6, even, odd, prime, divisible by 3, ...}; and the probabilities could be {P(1) = 1/6, P(2) = 2/6, P(even) = 3/6, ...}

### Some more questions
No equations yet, just simple counting and intuition. Suppose we roll one die.
* What is the sample space? {1, 2, 3, 4, 5, 6}.
* What is the event space? {{1}, {2}, ..., {6}, {1 or 2}, {1 or 3}, {1 or 4}, {1, 3, 5}, {2, 4, 6} ...}
* What is the probability of rolling a 1? rolling a {1 or 3}?
* What is the probability of rolling a 1 and an odd number? P(1,odd)
* What is the probability of rolling a 1 and an even number? P(1,even)
* What is the probability of rolling a 1, given that the outcome is odd? P(1 | odd)
* What is the probability of rolling a 1, given that the outcome is less than 4? P(1 | x < 4)
* Now let's rewrite the probability of a 1 as the sum of two joints: P(1) = P(1,even) + P(1,odd)
* What's the probability of rolling a 1 and rolling a number less than 4?

## A few definitions of sets
Getting a little more formal...we introduced the concept of a set. It will be useful to define a few definitions of sets when computing probabilities. Suppose the sample space of an experiment is S, and A, B are events.
1. The union of events A and B (A U B) is the event that occurs if and only if at least one of A and B occurs.
2. The intersection of A and B (A upside down "U" B) is the event that occurs if and only if both A and B occur.
3. The complement of A, A^c, is the event occurs if and only if A does not occur.

## Naive definition of probability
Suppose we restrict our analysis to events, A, that are equally likely and sample spaces, S, that are finite. We then define a probability measure: P(A) = (number of outcomes in A) / (total number of outcomes in S). We can write this in mathematical notation as, P(A) = |A| / |S|, where |A| denotes the size of set A. This definition says the probability of A is the fraction of events in A.

Back to our 6-sided die. Define the event A as rolling an even number, {2, 4, 6}. The naive probability of A is 1/2.

## Let's count things
Remaining in our finite world, let's define some useful terms:
1. _multiplication rule_ If experiment A has a possible outcomes and experiment B has b possible outcomes, then the compound experiment has ab outcomes. (Examples: rolling 2 dice, drawing cards from 2 decks). Using this rule, we can show that a set with n elements has 2^n possible subsets, including the empty set and the set itself. For each element, we can include or exclude it.

2. _Sampling with replacement_ is the process of choosing k objects from a set of n objects one at a time, allowing that any object to be chosen in each round. In this case, there are n^k ways to obtain a sample of size k. _Example: draw a card from a deck, then put it back and shuffle, draw another card, then put it back ..._

3. _Sampling without replacement_ is the process of choosing k objects from a set of n objects one at a time, precluding any object from being chosen more than once. In this case, there are n * (n -1) * (n -2) * ... (n - k + 1)  ways to obtain a sample of size k, for k <= n. _Example: draw a card from a deck, then draw another, ..._

4. A _permutation_ of 1,2, ..., n is an arrangement of them in some order. For example, 3, 2, 1 is a permutation of 1, 2, 3. There are n! permutations of 1,2,...,n where n! = n * (n - 1) * (n - 2) * ... * 1 and 0! = 1.

### Example, birthday problem
What is the probability that 2 people in a room of k people have the same birthday (assuming birthdays are equally likely, do not occur on February 29, and are independent, ie no twins!)? There are 365^k ways to assign birthdays to k people in a room, since we are sampling each of the 365 possible birthdays k times with replacement. We could count all the possible ways it could happen, but that's hard!
Let's instead find the number of ways that 2 people _cannot_ share the same birthday. There are 365 possibilities for the first person's birthday, 364 possibilities for the second person, ... (365 - k + 1) possibilities for the kth person. Applying the definition of naive probability, P(no birthday match) = (Number of ways to not match) / (Total number of ways to assign birthdays); P(no match) = (365 * 364 * ... (365 - k + 1)) / 365^k.
We can then compute the probability of a match as, P(birthday match) = 1 - P(no birthday match).

## Be careful counting things
Sometimes it is not easy to count each event once, but it is easy to count things c times. For example, how many possible two person committees can you pick from 4 people? There are 4 possibilities for the first person, and 3 possibilities for the second. If we apply the multiplication rule, we will count each committee twice.

Good thing there is a general formula for this situation, the binomial coefficient: for any nonnegative integers n and k, the binomial coefficient (n k), said "n choose k" is the number of subsets of size k for a set of size n and equals n! / ((n - k)! * k!).

### Example, counting cards, one pair
What's the probability of drawing a single pair in 5-card poker hand? There are 13 choose 1 ways to choose the first card of the pair, there are 4 choose 2 ways to pick the suits of the pair, there are 12 choose 3 ways to pick the remaining cards, and 4 choose 1 ways of picking the suits of the remaining cards. There are 52 choose 5 ways of drawing 5 cards from a deck of 52 cards. Applying the naive definition of probability, we get the probability of one pair is ((13 choose 1)* (4 choose 2) * (12 choose 3) * (4 choose 1) * (4 choose 1) * (4 choose 1)) / (52 choose 5) = 0.422569

### Example, counting cards, full house
What's the probability of drawing a full house, ie 2 of a kind and 3 of a kind? ((13 choose 1)* (4 choose 3) * (12 choose 1) * (4 choose 2)) / (52 choose 5) = 0.00144

## A more useful definition of probability
A probability space consists of a sample space, S; a set of events, E; and a probability function, P, which takes an event, A (which is a subset of S), as input and returns P(A), a real number between 0 and 1. The function P must satisfy these two properties:
1. P(empty set) = 0, P(S) = 1
2. If A_1, A_2, ... are disjoint events, then P(union of the A's) equals the sum of the probabilities of each A. _Draw a rectangle on the board to represent S. Then draw non intersecting shapes A_1, A_2, etc. The sum of the areas equals P(union of the A's)._

### Some properties of probability
1. P(A^c) = 1 - P(A)
2. If A is a subset of B, then P(A) <= P(B)
3. P(A or B) = P(A) + P(B) - P(A and B)

### Events and Probabilities
| Events             | Numbers                               |
| ------------------ |--------------------------------------:|
| A                  | P(A)                                  |
| not A              | P(A^c) = 1 - P(A)                     |
| A and B            | P(A intersect B)                      |
| A or B             | P(A or B) = P(A) + P(B) - P(A and B)  |
| something happened | P(S) = 1                              |

## Thinking conditionally
Probability is the mathematical language of uncertainty that provides a measure or yardstick of uncertainty. When we observe new evidence, how do we update our degree of uncertainty? Conditional probability is a concept that allows us to perform this update in a logical and coherent way.

_Conditional probability is the soul of statistics!_

### Examples galor
All of these settings involve thinking conditionally:
1. You wake up in the morning and see clouds. How does that change your belief that it will rain in the next hour?
2. The US Women's soccer team scores a goal in the first 10 minutes. How does this change the probability that they will win the game?
3. US manufacturing decreases by one percent in the last quarter, how does this change the probability of an economic recession in the next four quarters?
4. A witness testifies in a murder trial, how does this alter your belief in the innocence of the defendant?
5. Literally every detective show ever. Cop finds a new piece of evidence, do they pursue a new suspect?

## Fixing an example to introduce formality
We will return to our previous example concerning whether your commute into the office will take less than 20 minutes and define a set of events formally.

Here are events related to your commute:
| Variable   | Event                                     |
| ---------- |------------------------------------------:|
| D          | Your commute takes less than 20 minutes   |
| A          | The light at Elm street is green          |
| B          | Google maps shows your route is green     |
| C          | Construction crew picks up on time        |

And their corresponding probabilities
| Probability  |
| ------------ |
| P(D)         |
| P(A)         |
| P(B)         |
| P(C)         |

Suppose we're stopped at a light. We glance at Google maps, and it shows our route is green. How does this change our assessment of P(D)? In the language of probability we say, what is the probability of D conditional on B. We write this as P(D|B). When we go from P(D) to P(D|B) we say we are "conditioning on B". Now suppose the light at Elm is green. We can condition D on A and B, P(D|A,B). Throughout our commute we can update our belief that D will occur given that we observe other events.

Formally we define P(D|B) = P(D and B) / P(B).

### Example, pebble world
Going back to a world in which we can count things. Suppose we have a space of 9 pebbles. The event A includes 5 pebbles, the event B includes 4. A and B overlap on 1 pebble. Suppose we know B happened, what is the probability that A occurs?

### Example, shape world
Draw a rectangle on the board to represent S, the sample space. Draw a shape A, and a shape B where B overlaps A. Talk through how our belief in the plausibility of A changes if we know that B occurred.

### Example, playing cards
We shuffle a standard deck and draw 2 cards. A is the event that the first card is a heart, B is the event that the second card is red. What is P(A|B)?

First what is P(A and B)? There are 13 ways to get a heart, and there are 25 ways to get a red card after we draw a heart. So, P(A and B) = (13 / 52) * (25 / 51) = 25 / 204

Next, what is P(B)? Without knowing _anything_ about the first card, the probability that the second card is red is 26 / 52 or 1 / 2.

Putting these together: P(A|B) = P(A and B) / P(B) = (25/204) / (1/2) = 25/102

### Theorem
Now that we understand conditional probability, suppose we have two events, A and B, in sample space S. Plausibility of A is P(A) > 0, and B is P(B) > 0. Let's write down two equations:

#### one
P(A | B) = P(A and B) / P (B) (multiply both sides by P(B))
P(A | B) P(B) = P(A and B)

#### two
P(B | A) = P(A and B) / P (A) (multiply both sides by P(A))
P(B | A) P(A) = P(A and B)

Both equations have P(A and B) on the same side, so we can combine them:
P(A and B) = P(A | B) P(B) = P(B | A) P(A)

We just made a theorem. What does this say in words? That the probability of A _and_ B occurring can be computed using conditional probabilities, and it doesn't matter whether we condition on A or B. This can be really useful if the relationship between A and B is complex, but the conditional probability is straightforward to compute.

### Bayes' Rule
We're now ready to derive a very famous rule, Bayes' rule. Take our theorem,
P(A | B) P(B) = P(B | A) P(A)

and rearrange:
P(A | B) = ( P(B | A) P(A) ) / P(B)

This says that the probability of A conditional on observing B is a function of B conditional on A and the probabilities of A and B. Why is this significant? It is just a rearrangement of the definition of conditional probability.

Instead of A, B; suppose B is a set of observations from a series of coin flips and A is the observed probability of a fair coin:

P(fair coin | series of coin flips) = P(series of coin flips | fair coin) P(fair coin) / P(series of coin flips)

Generalizing a bit, let's say we want to assess the plausibility of a hypothesis given a set of observations:

P(hypothesis | data) = P(data | hypothesis) P(hypothesis) / P(data)

### Law of total Probability
For now, take our word that computing the probability of observing a data can be very difficult. It can, however, help to break up this computation into smaller pieces. We can do this with conditional probabilities.

LOTP: Let A_1, A_2, ..., A_n be a partition of the sample space S. This means A_i are disjoint events and their union is S. P(A_i) > 0 for all i. Then,

P(B) = Sum( P(B|A_i)P(A_i) over all i)

_draw figure on the board, S rectangular sample space. Draw vertical lines through it representing A_i's. Draw area B in S_

### Example using Bayes' Rule and LOTP
You have a fair coin, and one that is biased which lands heads with probability 3/4. You pick one of the coins at random and flip it three times. It lands heads all three times. Given these observations, what is the probability you picked the fair coin?

Let A be flipping a coin three times and having it land heads each time. Let F be the probability that you picked a fair coin. We want to know P(F|A).

Let's use Bayes' rule:
P(F|A) = P(A|F) P(F) / P(A)

What's P(A)? We have two states of the world, F and not F (F^C); and the probability of observing A differs depending on what coin we chose. F, F^C is a disjoint partition of the sample space, so we can use LOTP to write P(A) as:

P(A) = P(A|F)P(F) + P(A|F^C)P(F^C)

Let's compute this:
1. P(F) = P(F^C) = 1/2
2. P(A|F) = (1/2)^3
3. P(A|F^C) = (3/4)^3

Plugging all these values in we get:
P(F|A) = 0.23

### Example, rare disease
Fred is tested for a disease called conditionitis that affects 1 percent of the population. The test result is positive. Let D be the event that Fred has the disease and T be the event that he tests positive. Suppose that the test is 95 percent accurate, P(T|D) = 0.95 [true positive] and P(T^C|D^C) = 0.95 [false positive]. What is the probability that Fred has conditionitis given that he tested positive?

P(D|T) = P(T|D)P(D) / P(T)

P(D|T) = P(T|D)P(D) / (P(T|D)P(D) + P(T|D^C)P(D^C))

Let's plug in what we know:
P(D|T) = (0.95)(0.01) / ((0.95)(0.01) + (0.05)(0.99))
P(D|T) = 0.16

To explain this, draw a tree diagram on the board:
root: 10000 people
left branch: 100 people who have disease
right branch: 9900 people who are healthy

left left branch: test positive, 95 people; true positives
left right branch: test negative, 5 people; false negatives

right left branch: test positive, 495 people; false positives
left right branch: test negative, 9405 people; true negatives

Why is our estimate so low given that the test is 95 percent accurate? There are two factors:
1. prior information
2. evidence from the test

### Next steps
The remainder of this course is just the details involved in applying the logic of Bayes' rule.


## Old material

### Interpretations of Probability
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


## What is statistical inference?
> Statistical inference is concerned with drawing conclusions, from numerical data, about quantities that are not observed.
> Bayesian Data Analysis, 3rd edition

## What is Bayesian inference?
> Bayesian inference is the process of fitting a probability model to a set of data and summarizing the result by a probability distribution on the parameters of the model and on unobserved quantities such as predictions for new observations.
> Bayesian Data Analysis, 3rd edition




### Motivating example, disease detections

There has been a big push to detect cancers earlier using tests. Decisions around whether to test, how often to test, and what to do with a result affect millions of people every year. These decisions are informed by probabilistic judgments.

Let's jump in. Suppose you are a doctor specializing in breast cancer. You prescribe a test to a woman over 40, and she tests positive. What next steps do you advise her to take?

* How common is breast cancer among women over 40? According to [cancer.gov](https://www.cancer.gov/types/breast/risk-fact-sheet) a woman in her forties has a 1.47 percent chance of risk of being diagnosed with breast cancer.

* How good is the test? If a woman has cancer, the probability that the test will find the cancer is 75 percent. If the woman does not have cancer, the probability that the test will find cancer is 10 percent.

A quick derivation of Bayes' rule: start with conditional; P(A,B) = P(A|B) P(B)

For this example, we want to know the probability that you have breast cancer given that you tested positive. Start with the English language, then write the equation.

### If time, let's work through some decisions in an uncertain environment

How sensitive does your explosive detection system at an airport have to be before you should deploy it?

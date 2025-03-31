# Structured CPDs for Bayesian Networks

## Overview: Structured CPDs

### Tabular Representations

![alt text](assets/media/4/4-1-1.png)

### General CPD

don't have to use a explicit table, can use any function

### Many Models

![alt text](assets/media/4/4-1-2.png)

### Context-Specific Independence

![alt text](assets/media/4/4-1-5.png)

![alt text](assets/media/4/4-1-6.png)

#### Gemini 2.5 Pro Experimental 03-25

Rationale Breakdown:

1.  **Understand the Setup:** We have a Bayesian network with structure Y1 -> X <- Y2. The variables Y1 and Y2 are parents of X. We are given that X is a *deterministic OR* of Y1 and Y2. Assuming Y1, Y2, and X are binary variables (taking values 0 for false and 1 for true), the relationship is:
    *   X = 0 if Y1 = 0 and Y2 = 0
    *   X = 1 if Y1 = 1 or Y2 = 1 (or both)

2.  **Understand Context-Specific Independence (CSI):** We are looking for conditional independencies that hold only for specific values (contexts) of the conditioning variables. The notation (A ⊥ B | C=c) means A is independent of B given that the variable C takes the specific value c. This is different from the general conditional independence (A ⊥ B | C), which means independence holds for *all* possible values of C.

    *   **(Y1 ⊥ Y2 | X):** Does independence between Y1 and Y2 hold given X?
        *   **Context X = 0:** If X=0, we know with certainty that Y1=0 and Y2=0 (because X is the OR). Since both Y1 and Y2 are fixed at 0 in this context, they are independent. Knowing Y1=0 tells us nothing new about Y2 because we already knew Y2 must be 0. So, **(Y1 ⊥ Y2 | X=0) holds.**
        *   **Context X = 1:** If X=1, we know that at least one of Y1 or Y2 is 1. The possible states are (Y1=0, Y2=1), (Y1=1, Y2=0), (Y1=1, Y2=1). If we learn, for example, that Y1=0, we then know for sure that Y2 must be 1. If we learn Y1=1, Y2 could still be 0 or 1. Since learning the value of one parent changes our belief about the other parent (given the common child X=1), Y1 and Y2 are *dependent* given X=1 (this is the explaining away effect). So, (Y1 ⊥ Y2 | X=1) does not hold in general.
        *   Conclusion: (Y1 ⊥ Y2 | X) does not hold generally, but (Y1 ⊥ Y2 | X=0) holds as a CSI.

    *   **(X ⊥ Y1 | Y2):** Does independence between X and Y1 hold given Y2?
        *   **Context Y2 = 0:** If Y2=0, then X = Y1 OR 0 = Y1. X is completely determined by Y1. They are maximally dependent. So, (X ⊥ Y1 | Y2=0) does not hold.
        *   **Context Y2 = 1:** If Y2=1, then X = Y1 OR 1 = 1. X is fixed at 1 regardless of the value of Y1. Knowing Y1 tells us nothing new about X (it's always 1). So, **(X ⊥ Y1 | Y2=1) holds.**
        *   Conclusion: (X ⊥ Y1 | Y2) does not hold generally, but (X ⊥ Y1 | Y2=1) holds as a CSI.

    *   **(X ⊥ Y2 | Y1):** Does independence between X and Y2 hold given Y1? (This is symmetric to the previous case).
        *   **Context Y1 = 0:** If Y1=0, then X = 0 OR Y2 = Y2. X is completely determined by Y2. They are maximally dependent. So, (X ⊥ Y2 | Y1=0) does not hold.
        *   **Context Y1 = 1:** If Y1=1, then X = 1 OR Y2 = 1. X is fixed at 1 regardless of the value of Y2. Knowing Y2 tells us nothing new about X (it's always 1). So, **(X ⊥ Y2 | Y1=1) holds.**
        *   Conclusion: (X ⊥ Y2 | Y1) does not hold generally, but (X ⊥ Y2 | Y1=1) holds as a CSI.

---

## Tree-strucutred CPDs

### Tree CPD

![alt text](assets/media/4/4-2-1.png)

So we can see that we have a CPD that in this case depends on three binary variables. And so really we would need to represent in principle eight different probability distributions over the J variable. **But we've only represented four because in certain context some of the variables don't matter.**

![alt text](assets/media/4/4-2-2.png)

last one: mixed combination of context-specific independence and independence in the general sense.

![alt text](assets/media/4/4-2-3.png)

$$
(L_1 \perp L_2 | J, C)
$$

但是，从 PGM d-separation 的角度来看，given J, actually activated the flow of probability from L1 to L2

But! case analysis:

![alt text](assets/media/4/4-2-4.png)

in both case, the active path **disappear**! - implys independence

### Multiplexer CPD

![alt text](assets/media/4/4-2-5.png)

A：选择器，可以看作是r.v.的函数么？感觉怪怪的

以及结构必须是这样的么？

能否 Z_1, ..., Z_n -> A -> Y ？

![alt text](assets/media/4/4-2-6.png)

### Summary

- Compact CPD representation that captures context-specific dependencies
**可以理解为 通过context- specific dependencies，将BNs简化/具体化成 tree cpd？**
- Relevant in multiple applications
  - Hardware configuration variables
  - Medical settings
  - Dependence on agent's action
  - Perceptual ambiguity

---

## Independence of Causal Influence

### Noisy OR CPD

noisy transmitor

$X_i$ itself has a filter

![alt text](assets/media/4/4-3-1.png)

### Independence of Causal Influence

![alt text](assets/media/4/4-3-2.png)

### Sigmoid CPD

这就是 logistic regression 么？

PGM的视角看 LR，so cool!

![alt text](assets/media/4/4-3-3.png)

### Behavior of Sigmoid CPD

![alt text](assets/media/4/4-3-4.png)

<span style='color:red'>这题没太理解</span>
![alt text](assets/media/4/4-3-5.png)
![alt text](assets/media/4/4-3-6.png) 
![alt text](assets/media/4/4-3-7.png)
![alt text](assets/media/4/4-3-9.jpeg)

![alt text](assets/media/4/4-3-8.png)

---

## Continuous Variables

### Continuous Variables

Linear Gaussian & Conditional Gaussian

![alt text](assets/media/4/4-4-1.png)

![alt text](assets/media/4/4-4-2.png)

### Robot Localization

![alt text](assets/media/4/4-4-4.png)

### Nonlinear Gaussian

![alt text](assets/media/4/4-4-5.png)

### Robot Motion Model

![alt text](assets/media/4/4-4-6.png)


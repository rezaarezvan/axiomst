// Comprehensive example showcasing all homework features
#import "../src/lib.typ": *

#show: homework.with(
  title: "Problem Set 1: Linear Algebra",
  author: "Jane Doe",
  course: "MATH 201",
  email: "jane.doe@university.edu",
  date: datetime(year: 2025, month: 3, day: 15),
  due-date: "March 22, 2025",
  margin-size: 2.5cm,
  version: "solutions", // Use "questions", "answers", or "solutions"
)

#set text(font: "New Computer Modern")
#set math.equation(numbering: "(1)")

// ============================================================================
// Instructions block
// ============================================================================
#instructions[
  - Show all work for full credit.
  - You may collaborate, but write up solutions independently.
  - Late submissions will receive a 10% penalty per day.
]

// ============================================================================
// Problem 1: Definitions and Theorems
// ============================================================================
#problem(
  title: "Vector Spaces",
  answer: [
    Use the vector space axioms to compare two zero vectors, compare two additive
    inverses of the same vector, and cancel one copy of $0 dot bold(v)$ from
    $0 dot bold(v) + 0 dot bold(v) = 0 dot bold(v)$.
  ],
  solution: [
    *Part (a):* See Theorem 1 below.

    *Part (b):* Suppose $bold(w)$ and $bold(w)'$ are both additive inverses of $bold(v)$.
    Then:
    $
      bold(w) = bold(w) + bold(0) = bold(w) + (bold(v) + bold(w)') = (bold(w) + bold(v)) + bold(w)' = bold(0) + bold(w)' = bold(w)'
    $

    *Part (c):* We have $0 dot bold(v) + 0 dot bold(v) = (0 + 0) dot bold(v) = 0 dot bold(v)$.
    Adding $-(0 dot bold(v))$ to both sides gives $0 dot bold(v) = bold(0)_V$.
  ],
)[
  Let $V$ be a vector space over a field $F$. Prove the following properties:

  + The zero vector $bold(0)_V$ is unique.
  + For each $bold(v) in V$, the additive inverse $-bold(v)$ is unique.
  + For any $bold(v) in V$, we have $0 dot bold(v) = bold(0)_V$ where $0 in F$.
]

#definition(title: "Vector Space")[
  A *vector space* over a field $F$ is a set $V$ together with two operations:
  - *Addition*: $+: V times V -> V$
  - *Scalar multiplication*: $dot: F times V -> V$

  satisfying the eight vector space axioms.
]

#theorem(title: "Uniqueness of Zero")[
  In any vector space $V$, the zero vector $bold(0)_V$ is unique.
]

#proof[
  Suppose there exist two zero vectors $bold(0)$ and $bold(0)'$ in $V$.

  By the definition of zero vector:
  $ bold(0) + bold(0)' = bold(0)' #h(2em) "(since " bold(0) " is a zero vector)" $
  $ bold(0) + bold(0)' = bold(0) #h(2em) "(since " bold(0)' " is a zero vector)" $

  Therefore $bold(0) = bold(0)'$, proving uniqueness.
]

// ============================================================================
// Problem 2: Using columns for comparison
// ============================================================================
#problem(title: "Comparison of Vector Spaces")[
  Compare and contrast the following vector spaces.
]

#columns(count: 2, gutter: 1.5em)[
  #definition(title: "Real Vector Space", numbered: false)[
    A vector space over $RR$.

    *Example:* $RR^n$ with standard operations.

    *Properties:*
    - Ordered field
    - Complete (has limits)
    - Infinite dimensional examples exist
  ]
][
  #definition(title: "Complex Vector Space", numbered: false)[
    A vector space over $CC$.

    *Example:* $CC^n$ with standard operations.

    *Properties:*
    - Algebraically closed
    - Every polynomial factors
    - Important in quantum mechanics
  ]
]

// ============================================================================
// Problem 3: Lemmas and Corollaries
// ============================================================================
#problem(title: "Linear Independence")[
  Prove properties related to linear independence.
]

#lemma(title: "Steinitz Exchange")[
  If $S$ is a linearly independent set and $T$ is a spanning set with $|S| > |T|$,
  then $S$ cannot be linearly independent. Hence $|S| <= |T|$.
]

#proof(qed-symbol: "□")[
  The proof proceeds by induction on $|S|$. The base case is trivial.
  For the inductive step, we exchange elements between $S$ and $T$
  while preserving the spanning property...
]

#corollary(title: "Dimension is Well-Defined")[
  All bases of a finite-dimensional vector space have the same cardinality.
]

#example(title: [Basis of $RR^3$])[
  The standard basis of $RR^3$ is:
  $ cal(B) = {bold(e)_1, bold(e)_2, bold(e)_3} = {vec(1, 0, 0), vec(0, 1, 0), vec(0, 0, 1)} $
  This basis has exactly 3 elements, so $dim(RR^3) = 3$.
]

// ============================================================================
// Problem 4: Tables
// ============================================================================
#problem(
  title: "Matrix Properties",
  answer: [
    All three matrices satisfy $"rank"(A) + "nullity"(A) = 2$.
  ],
  solution: [
    The rank-nullity theorem states: $"rank"(A) + "nullity"(A) = n$ for an $n times n$ matrix.

    For matrix $A$: $2 + 0 = 2$ ✓

    For matrix $B$: $1 + 1 = 2$ ✓ (singular matrix)

    For $I_2$: $2 + 0 = 2$ ✓
  ],
)[
  Consider the following matrices and their properties.
]

#ptable(
  table(
    columns: 4,
    align: center,
    table.header([*Matrix*], [*Rank*], [*Nullity*], [*Determinant*]),
    [$A = mat(1, 2; 3, 4)$], [2], [0], [-2],
    [$B = mat(1, 2; 2, 4)$], [1], [1], [0],
    [$I_2 = mat(1, 0; 0, 1)$], [2], [0], [1],
  ),
  caption: "Properties of 2×2 matrices",
)

// ============================================================================
// Problem 5: Code blocks
// ============================================================================
#problem(
  title: "Computational Linear Algebra",
  solution: [
    ```python
    import numpy as np

    def gaussian_elimination(A, b):
        """Solve Ax = b using Gaussian elimination."""
        n = len(b)
        # Augmented matrix
        Ab = np.hstack([A.astype(float), b.reshape(-1, 1)])

        # Forward elimination
        for i in range(n):
            # Pivot
            max_row = np.argmax(np.abs(Ab[i:, i])) + i
            Ab[[i, max_row]] = Ab[[max_row, i]]

            for j in range(i + 1, n):
                factor = Ab[j, i] / Ab[i, i]
                Ab[j, i:] -= factor * Ab[i, i:]

        # Back substitution
        x = np.zeros(n)
        for i in range(n - 1, -1, -1):
            x[i] = (Ab[i, -1] - np.dot(Ab[i, i+1:n], x[i+1:])) / Ab[i, i]

        return x
    ```
  ],
)[
  Implement Gaussian elimination in Python.
]

// ============================================================================
// Problem 6: Custom colors
// ============================================================================
#problem(
  title: "Eigenvalues",
  color: red.darken(10%),
  answer: [
    The eigenvalues are $lambda_1 = 3$ and $lambda_2 = 2$.
  ],
  solution: [
    $ det(A - lambda I) = det mat(3-lambda, 1; 0, 2-lambda) = (3-lambda)(2-lambda) = 0 $

    Therefore $lambda_1 = 3$ and $lambda_2 = 2$.
  ],
)[
  Find the eigenvalues of $A = mat(3, 1; 0, 2)$.
]

#theorem(title: "Characteristic Polynomial", color: red.darken(10%))[
  The eigenvalues of $A$ are the roots of $det(A - lambda I) = 0$.
]

// ============================================================================
// Problem 7: Different QED symbols
// ============================================================================
#problem(title: "Proof Styles")[
  Demonstrate different QED symbol styles.
]

#proof(qed-symbol: "fill")[
  This proof uses the filled square (default).
]

#proof(qed-symbol: "hollow")[
  This proof uses the hollow square.
]

#proof(qed-symbol: "filled-cube")[
  This proof uses the filled cube.
]

#proof(qed-symbol: "Q.E.D.")[
  This proof uses the classical Q.E.D.
]

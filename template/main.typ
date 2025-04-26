#import "../src/lib.typ": *

// Document Configuration
#show: homework.with(
  title: "Problem Set 3",
  author: "Reza Rezvan",
  email: "rezvan@school.com",
  course: "MATH 242: Advanced Linear Algebra",
  instructor: "Prof. Johnson",
  date: datetime.today(),
  due-date: "April 30, 2025",
  collaborators: ["Alex Smith", "Jordan Lee"],
  accent-color: blue.darken(20%),
)

// Set equation numbering
#set math.equation(numbering: "(1)")

// Set enumeration style
#set enum(numbering: "1)")

// Optional: For a LaTeX-like look
#set text(font: "New Computer Modern")

// First problem
#problem(title: "Vector Spaces")[
  Let $V$ be a vector space over a field $F$. Prove the following properties:

  1. The zero vector $0_V$ is unique.
  2. For each $v in V$, the additive inverse $-v$ is unique.
  3. If $a in F$ and $a dot v = 0_V$ for some $v in V$, then either $a = 0$ or $v = 0_V$.
]

// Solution to first problem
*1. Uniqueness of the zero vector:*

Suppose there exist two zero vectors, $0_V$ and $0'_V$. By definition of a zero vector, we have:
$0_V + 0'_V = 0'_V$ (since $0_V$ is a zero vector)
$0_V + 0'_V = 0_V$ (since $0'_V$ is a zero vector)

Therefore, $0_V = 0'_V$, proving that the zero vector is unique.

*2. Uniqueness of the additive inverse:*

Suppose $v in V$ has two additive inverses, $w$ and $w'$. Then:
$v + w = 0_V$ and $v + w' = 0_V$

Adding $w$ to both sides of the second equation,

$
w + (v + w') &= w + 0_V \
(w + v) + w' &= w \
0_V + w' &= w \
w' &= w \
$

Therefore, the additive inverse is unique.

*3. Zero product property:*

Suppose $a in F$, $v in V$, and $a dot v = 0_V$.

If $a = 0$, we're done. Otherwise, $a != 0$, which means $a$ has a multiplicative inverse $a^(-1)$ in $F$.

Multiplying both sides by $a^(-1)$,

$
a^(-1) dot (a dot v) &= a^(-1) dot 0_V \
(a^(-1) dot a) dot v &= 0_V \
1 dot v &= 0_V \
v &= 0_V
$

Thus, either $a = 0$ or $v = 0_V$.

// Second problem
#problem(title: "Linear Transformations")[
  Let $T: R^3 -> R^2$ be a linear transformation defined by:
  $T(x, y, z) = (2x - y + 3z, 4x + 2y - z)$

  1. Find the standard matrix representation of $T$.
  2. Determine $"ker"(T)$ and $"im"(T)$.
  3. Verify that $"dim"("ker"(T)) + "dim"("im"(T)) = "dim"(R^3)$.
]

// Solution to second problem
*1. Standard matrix representation:*

For a linear transformation $T: R^3 -> R^2$, the standard matrix is found by applying $T$ to each standard basis vector of $R^3$ and using the results as columns.

$
T(1,0,0) &= (2(1) - 0 + 3(0), 4(1) + 2(0) - 0) = (2, 4) \
T(0,1,0) &= (2(0) - 1 + 3(0), 4(0) + 2(1) - 0) = (-1, 2) \
T(0,0,1) &= (2(0) - 0 + 3(1), 4(0) + 2(0) - 1) = (3, -1)
$

Therefore, the standard matrix representation is:
$ A = mat(
  2, -1, 3;
  4, 2, -1
) $

// Example of a code block with line numbers
```python
def matrix_multiply(A, v):
    """
    Multiply matrix A by vector v
    """
    result = []
    for row in A:
        product = sum(a_i * v_i for a_i, v_i in zip(row, v))
        result.append(product)
    return result

# Example usage
A = [[2, -1, 3], [4, 2, -1]]
v = [1, 2, 3]
print(matrix_multiply(A, v))  # Should output [7, 6]
```

*2. Determining $"ker"(T)$ and $"im"(T)$:*

For $"ker"(T)$, we solve $T(x, y, z) = (0, 0)$,

$
2x - y + 3z &= 0 \
4x + 2y - z &= 0
$

From the second equation: $z = 4x + 2y$
Substituting into the first equation,

$
2x - y + 3(4x + 2y) &= 0 \
2x - y + 12x + 6y &= 0 \
14x + 5y &= 0 \
y = -frac(14x, 5)
$

So, $"ker"(T) = \{(t, -frac(14t,5), frac(-8t,5)) | t in RR\}$

For $"im"(T)$, we analyze the column space of the matrix,
$
"span"((2, 4), (-1, 2), (3, -1))
$

Since we can find two linearly independent columns, $"im"(T) = R^2$.

*3. Verification of dimension equation:*

$
"dim"("ker"(T)) &= 1 ("it's a line in" RR^3) \
"dim"("im"(T)) &= 2 "(it's" RR^2) \
"dim"("ker"(T)) + "dim"("im"(T)) &= 1 + 2 = 3 = "dim"(R^3)
$

This verifies the rank-nullity theorem.

// Comprehensive example showcasing all slides features
#import "../src/lib.typ": *

#show: slides.with(
  title: "Introduction to Linear Algebra",
  author: "Jane Doe",
  date: datetime(year: 2025, month: 3, day: 15),
  ratio: "16-9",   // Also supports "4-3"
  handout: false,  // Set to true for print-friendly version (no subslides)
  margin: 1.5cm,
)

// ============================================================================
// Title Slide
// ============================================================================
#title-slide(
  title: "Introduction to Linear Algebra",
  subtitle: "Vectors, Matrices, and Beyond",
  author: "Jane Doe",
  institution: "University of Mathematics",
  date: datetime(year: 2025, month: 3, day: 15),
)

// ============================================================================
// Basic Slide with pause
// ============================================================================
#slide(title: "What We'll Cover")[
  This presentation introduces fundamental concepts:

  #pause

  - Vector spaces and subspaces

  #pause

  - Linear transformations

  #pause

  - Eigenvalues and eigenvectors

  #pause

  - Applications in data science
]

// ============================================================================
// Section Slide
// ============================================================================
#section-slide[Vector Spaces]

// ============================================================================
// Slide with uncover (preserves layout)
// ============================================================================
#slide(title: "Definition of Vector Space")[
  A *vector space* $V$ over field $F$ has two operations:

  #uncover(1)[
    == Addition
    $+: V times V -> V$ satisfies commutativity and associativity.
  ]

  #uncover((from: 2))[
    == Scalar Multiplication
    $dot: F times V -> V$ distributes over addition.
  ]

  #uncover((from: 3))[
    #v(0.5em)
    #align(center)[
      #text(fill: blue)[_Together, these satisfy the 8 vector space axioms._]
    ]
  ]
]

// ============================================================================
// Slide with only (affects layout)
// ============================================================================
#slide(title: "Examples of Vector Spaces")[
  #only(1)[
    == Euclidean Space $RR^n$

    The most familiar vector space:
    $ RR^3 = {(x, y, z) : x, y, z in RR} $

    With standard addition and scalar multiplication.
  ]

  #only(2)[
    == Polynomial Space $PP_n$

    Polynomials of degree at most $n$:
    $ PP_2 = {a_0 + a_1 x + a_2 x^2 : a_i in RR} $

    This is a 3-dimensional vector space!
  ]

  #only(3)[
    == Function Spaces

    Continuous functions $C[a,b]$ form an *infinite-dimensional* space:
    $ C[0,1] = {f : [0,1] -> RR : f "is continuous"} $
  ]
]

// ============================================================================
// Slide with subtitle
// ============================================================================
#slide(
  title: "Linear Independence",
  subtitle: "A key concept for bases"
)[
  Vectors $bold(v)_1, ..., bold(v)_n$ are *linearly independent* if:

  $ c_1 bold(v)_1 + c_2 bold(v)_2 + ... + c_n bold(v)_n = bold(0) $

  implies $c_1 = c_2 = ... = c_n = 0$.

  #pause

  #v(1em)
  *Example:* In $RR^2$, the vectors $vec(1,0)$ and $vec(0,1)$ are linearly independent.

  But $vec(1,2)$ and $vec(2,4)$ are *not* (one is a scalar multiple of the other).
]

// ============================================================================
// Section Slide
// ============================================================================
#section-slide[Linear Transformations]

// ============================================================================
// Slide using theorem boxes from common.typ
// ============================================================================
#slide(title: "The Rank-Nullity Theorem")[
  #theorem(title: "Rank-Nullity", numbered: false)[
    For linear $T: V -> W$ with $V$ finite-dimensional:
    $ dim(ker T) + dim(im T) = dim(V) $
  ]

  #pause

  #v(0.5em)
  *Intuition:* The dimensions you "lose" (kernel) plus what you "keep" (image) equals what you started with.
]

// ============================================================================
// Slide with columns
// ============================================================================
#slide(title: "Injective vs Surjective")[
  #columns(count: 2, gutter: 2em)[
    == Injective (One-to-One)

    $ker(T) = {bold(0)}$

    #pause

    - Different inputs → different outputs
    - Preserves distinctness
    - $dim(im T) = dim(V)$
  ][
    == Surjective (Onto)

    $im(T) = W$

    #pause

    - Every output is hit
    - "Covers" the codomain
    - $dim(ker T) = dim(V) - dim(W)$
  ]
]

// ============================================================================
// Section Slide
// ============================================================================
#section-slide[Eigenvalues & Eigenvectors]

// ============================================================================
// Slide with definition
// ============================================================================
#slide(title: "Eigenvalue Equation")[
  #definition(title: "Eigenvalue/Eigenvector", numbered: false)[
    For matrix $A$, scalar $lambda$ is an *eigenvalue* with *eigenvector* $bold(v) != bold(0)$ if:
    $ A bold(v) = lambda bold(v) $
  ]

  #pause

  #v(0.5em)
  The eigenvector $bold(v)$ is only scaled, not rotated, by $A$.

  #pause

  To find eigenvalues, solve:
  $ det(A - lambda I) = 0 $
]

// ============================================================================
// Slide with math display
// ============================================================================
#slide(title: "Example: 2×2 Matrix")[
  Let $A = mat(3, 1; 0, 2)$. Find its eigenvalues.

  #pause

  $ det(A - lambda I) = det mat(3-lambda, 1; 0, 2-lambda) $

  #pause

  $ = (3 - lambda)(2 - lambda) - 0 = 0 $

  #pause

  *Eigenvalues:* $lambda_1 = 3$ and $lambda_2 = 2$
]

// ============================================================================
// Slide with custom footer
// ============================================================================
#slide(
  title: "Applications",
  footer: [
    #line(length: 100%, stroke: 0.3pt + gray)
    #text(size: 0.7em, fill: gray)[Linear algebra is everywhere!]
  ]
)[
  Eigenvalues appear in many applications:

  #pause

  - *Google PageRank:* Principal eigenvector of link matrix

  #pause

  - *PCA:* Eigenvectors of covariance matrix

  #pause

  - *Quantum Mechanics:* Observable eigenvalues

  #pause

  - *Differential Equations:* Stability analysis
]

// ============================================================================
// Slide with no title (custom header)
// ============================================================================
#slide(
  header: [
    #align(center)[
      #text(size: 1.8em, weight: "bold", fill: blue.darken(20%))[Summary]
    ]
    #v(0.5em)
  ]
)[
  #v(1em)

  #align(center)[
    #table(
      columns: 2,
      align: (left, left),
      stroke: none,
      row-gutter: 0.8em,
      [*Vector Spaces*], [Sets with addition & scalar multiplication],
      [*Linear Maps*], [Structure-preserving transformations],
      [*Eigenvalues*], [Scaling factors for special directions],
      [*Rank-Nullity*], [$dim(ker) + dim(im) = dim(V)$],
    )
  ]
]

// ============================================================================
// Final slide
// ============================================================================
#slide(title: "Thank You!")[
  #v(2em)
  #align(center)[
    #text(size: 1.3em)[Questions?]

    #v(2em)

    *Contact:* jane.doe\@university.edu

    *Slides:* Made with #link("https://github.com/rezaarezvan/axiomst")[axiomst]
  ]
]

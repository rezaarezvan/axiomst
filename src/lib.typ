// axiomst: Academic homework and presentation slides template
// https://github.com/rezaarezvan/axiomst

// Re-export common components
#import "common.typ": (
  // Counters
  problem-counter,
  theorem-counter,
  definition-counter,
  remark-counter,
  proposition-counter,
  lemma-counter,
  corollary-counter,
  example-counter,
  algorithm-counter,
  // Layout
  columns,
  // Math
  num-counter,
  num,
  // Academic elements
  theorem-base,
  theorem,
  lemma,
  definition,
  remark,
  proposition,
  corollary,
  example,
  proof,
  problem,
  subquestions,
  pfigure,
  ptable,
  instructions,
)

// Re-export homework template
#import "homework.typ": homework

// Re-export slides components
#import "slides.typ": only, pause, section-slide, slide, slides, title-slide, uncover

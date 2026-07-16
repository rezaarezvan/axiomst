#import "../src/lib.typ": *

#let version = sys.inputs.at("version", default: "solutions")

#show: homework.with(
  title: "Homework Label Regression",
  author: "Tester",
  course: "MATH 101",
  email: "tester@example.edu",
  date: datetime(year: 2026, month: 7, day: 16),
  version: version,
  problem-label: [Global Exercise],
  answer-label: [Global answer!],
  solution-label: [Global solution?],
)

#problem(
  title: "Inherited Labels",
  answer: [GLOBAL-ANSWER-CONTENT],
  solution: [GLOBAL-SOLUTION-CONTENT],
)[
  GLOBAL-QUESTION-CONTENT
]

#problem(
  title: "Inherited Fallback",
  solution: [GLOBAL-FALLBACK-CONTENT],
)[
  GLOBAL-FALLBACK-QUESTION
]

#problem(
  title: "Local Labels",
  label: "Local Task",
  answer-label: [Local response!],
  solution-label: "Local solution?",
  solution: [LOCAL-FALLBACK-CONTENT],
)[
  LOCAL-QUESTION-CONTENT
]

== Referenced Heading <referenced-heading>

REFERENCE-TEXT: @referenced-heading

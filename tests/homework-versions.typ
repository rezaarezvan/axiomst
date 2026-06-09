#import "../src/lib.typ": *

#let version = sys.inputs.at("version", default: "solutions")

#show: homework.with(
  title: "Homework Version Regression",
  author: "Tester",
  course: "MATH 101",
  email: "tester@example.edu",
  date: datetime(year: 2026, month: 6, day: 9),
  due-date: "June 16, 2026",
  version: version,
)

#problem(
  title: "Both Slots",
  answer: [
    BOTH-ANSWER-CONTENT
  ],
  solution: [
    BOTH-SOLUTION-CONTENT
  ],
)[
  BOTH-QUESTION-CONTENT
]

#problem(
  title: "Solution Fallback",
  solution: [
    FALLBACK-SOLUTION-CONTENT
  ],
)[
  FALLBACK-QUESTION-CONTENT
]

#problem(title: "Question Only")[
  QUESTION-ONLY-CONTENT
]

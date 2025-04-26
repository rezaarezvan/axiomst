// Development test file for axiomst
#import "./src/lib.typ": *

// Simple test configuration
#show: homework.with(
  title: "Development Test",
  author: "Reza",
  course: "Test Course",
  instructor: "Test Instructor",
  accent-color: blue.darken(20%),
)

// Test a problem
#problem(title: "Test Problem")[
  This is a test problem to ensure the template is working correctly.

  1. Item one
  2. Item two
]

This is a test solution.

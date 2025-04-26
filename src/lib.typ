// axiomst: A clean, elegant template for academic problem sets and homework assignments
// Main library file

// Import any dependencies
#import "@preview/showybox:2.0.4": showybox

// Initialize problem counter for automatic numbering
#let problem_counter = counter("problem")

// Problem box function
#let problem(
  title: "",
  color: blue.darken(20%),
  numbered: true,
  ..body
) = {
  if numbered {
    [== Problem #problem_counter.step() #context {problem_counter.display()}]
  }

  showybox(
    frame: (
      border-color: color.darken(10%),
      title-color: color.lighten(85%),
      body-color: color.lighten(95%)
    ),
    title-style: (
      color: black,
      weight: "bold",
    ),
    title: title,
    ..body
  )
}

// Main template function
#let homework(
  title: "Homework Assignment",
  author: "Student Name",
  course: "Course Code",
  instructor: "Professor Name",
  email: none,
  date: datetime.today(),
  due-date: none,
  collaborators: [],
  accent-color: blue.darken(20%),
  body
) = {
  // Document metadata
  set document(title: title, author: author)

  // Page setup
  set page(
    paper: "us-letter",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),

    // Header only appears on pages after the first one
    header: context {
      if counter(page).get().first() > 1 [
        #set text(style: "italic")
        #course #h(1fr) #author
        #if collaborators != none and type(collaborators) == array and collaborators.len() > 0 {
          [w/ #collaborators.join(", ")]
        }
        #block(line(length: 100%, stroke: 0.5pt), above: 0.6em)
      ]
    },

    footer: [
      #align(center)[Page #context counter(page).display() of #context counter(page).final().first()]
    ],
  )

  // Add numbering and some color to code blocks (from problemst)
  show raw.where(block: true): it => {
    block(
      width: 100% - 0.5em,
      radius: 0.3em,
      stroke: luma(50%),
      inset: 1em,
      fill: luma(98%)
    )[
      #show raw.line: l => context {
        box(
          width: measure([#it.lines.last().count]).width,
          align(right, text(fill: luma(50%))[#l.number])
        )
        h(0.5em)
        l.body
      }
      #it
    ]
  }

  // Title page styled like problemst
  align(
    center,
    {
      // Title with course
      text(size: 1.6em, weight: "bold")[#course -- #title \ ]

      // Author with email
      text(size: 1.2em, weight: "semibold")[#author \ ]

      // Email in monospace if provided
      if email != none [
        #raw(email) \
      ]

      // Date, due date, and collaborators in italic
      emph[
        #date.display("[month repr:long] [day], [year]")

        #if due-date != none [
          \ Due: #due-date
        ]

        #if collaborators != none and type(collaborators) == array and collaborators.len() > 0 [
          \ Collaborators: #collaborators.join(", ")
        ]

        #if instructor != none and instructor != "" [
          \ #instructor
        ]
      ]

      // Separator line
      box(line(length: 100%, stroke: 1pt))
    },
  )

  pagebreak()

  // Custom heading styles with problem-focused numbering
  set heading(
    numbering: (..nums) => {
      nums = nums.pos()
      if nums.len() == 1 {
        [Problem #nums.at(0):]
      }
      else if nums.len() == 2 {
        [Part (#numbering("a", nums.at(1))):]
      }
    },
  )

  // Main content
  body
}

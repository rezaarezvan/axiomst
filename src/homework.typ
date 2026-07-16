// axiomst/homework.typ - Homework template
#import "common.typ": homework-labels-state, homework-version-state

#let homework(
  title: "Homework Assignment",
  author: "Student Name",
  course: "Course Code",
  email: "student@school.uni",
  date: datetime.today(),
  due-date: none,
  collaborators: [],
  margin-size: 2.5cm,
  version: "solutions",
  problem-label: [Problem],
  answer-label: [Answer:],
  solution-label: [Solution:],
  body,
) = {
  if not ("questions", "answers", "solutions").contains(version) {
    panic("homework version must be \"questions\", \"answers\", or \"solutions\"")
  }

  homework-version-state.update(version)
  homework-labels-state.update((
    problem: problem-label,
    answer: answer-label,
    solution: solution-label,
  ))

  let display-date = value => if type(value) == datetime {
    value.display("[month repr:long] [day], [year]")
  } else {
    value
  }

  set document(title: title, author: author)

  set page(
    paper: "a4",
    margin: (top: margin-size, bottom: margin-size, left: margin-size, right: margin-size),

    header: context {
      if counter(page).get().first() > 1 [
        #set text(style: "italic")
        #course #h(1fr) #author
        #block(line(length: 100%, stroke: 0.5pt), above: 0.6em)
      ]
    },

    footer: [
      #align(center)[Page #context counter(page).display() of #context counter(page).final().first()]
    ],
  )

  show raw.where(block: true): it => {
    block(
      width: 100% - 0.5em,
      radius: 0.3em,
      stroke: luma(50%),
      inset: 1em,
      fill: luma(98%),
    )[
      #show raw.line: l => context {
        box(
          width: measure([#it.lines.last().count]).width,
          align(right, text(fill: luma(50%))[#l.number]),
        )
        h(0.5em)
        l.body
      }
      #it
    ]
  }

  align(
    center,
    {
      text(size: 1.6em, weight: "bold")[#course -- #title \ ]

      text(size: 1.2em, weight: "semibold")[#author \ ]

      raw(email)
      linebreak()

      if collaborators != none and type(collaborators) == array and collaborators.len() > 0 [
        #text(size: 0.95em)[Collaborators: #collaborators.join(", ")]
        #linebreak()
      ]

      emph[#display-date(date)]
      if due-date != none [
        #linebreak()
        #text(size: 0.95em)[Due: #display-date(due-date)]
      ]

      box(line(length: 100%, stroke: 1pt))
    },
  )

  set heading(
    supplement: problem-label,
    numbering: (..nums) => {
      nums = nums.pos()
      if nums.len() == 1 {
        [#problem-label #nums.at(0):]
      } else if nums.len() > 2 {
        [Part (#numbering("a", nums.at(1))):]
      }
    },
  )

  body
}

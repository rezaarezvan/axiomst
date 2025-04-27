// axiomst: A clean, elegant template for academic problem sets and homework assignments
// Main library file

// Import any dependencies
#import "@preview/showybox:2.0.4": showybox
#import "@preview/cetz:0.2.0"

// Initialize counters for automatic numbering
#let problemCounter = counter("problem")
#let theoremCounter = counter("theorem")
#let definitionCounter = counter("definition")
#let lemmaCounter = counter("lemma")
#let corollaryCounter = counter("corollary")
#let exampleCounter = counter("example")
#let algorithmCounter = counter("algorithm")

// ==========================================
// Common Math Notation Shorthands
// ==========================================

#let notation = state("notation", none)

#let setup-math-notation() = {
  // Set up common math notation shorthands
  notation.update(
    (
      // Statistical notation
      expect: math.op("𝔼"),
      prob: math.op("ℙ"),
      var: math.op("Var"),
      cov: math.op("Cov"),
      normal: (mu, sigma) => $cal(N)(#mu, #sigma^2)$,

      // Linear algebra notation
      norm: (x, p: none) => {
        if p == none {
          $||#x||$
        } else {
          $||#x||_#p$
        }
      },

      // ML notation
      gradient: $nabla$,
      matrix: (name, size: none) => {
        if size == none {
          math.bold(math.upright(name))
        } else {
          $bold(upright(#name))^(#size)$
        }
      },
      vector: (name) => math.bold(math.upright(name)),
    )
  )
}

// Initialize the notation state
#setup-math-notation()

// Retrieve notation
#let E = context {
  let n = notation.get()
  if n == none { panic("Notation not initialized") }
  n.expect
}

#let P = context {
  let n = notation.get()
  if n == none { panic("Notation not initialized") }
  n.prob
}

#let Var = context {
  let n = notation.get()
  if n == none { panic("Notation not initialized") }
  n.var
}

#let Cov = context {
  let n = notation.get()
  if n == none { panic("Notation not initialized") }
  n.cov
}

#let Normal = context {
  let n = notation.get()
  if n == none { panic("Notation not initialized") }
  n.normal
}

#let norm = context {
  let n = notation.get()
  if n == none { panic("Notation not initialized") }
  n.norm
}

#let grad = context {
  let n = notation.get()
  if n == none { panic("Notation not initialized") }
  n.gradient
}

#let mat = context {
  let n = notation.get()
  if n == none { panic("Notation not initialized") }
  n.matrix
}

#let vec = context {
  let n = notation.get()
  if n == none { panic("Notation not initialized") }
  n.vector
}

// ==========================================
// Margin Notes System
// ==========================================

#let margin-note(
  body,
  side: "right",
  width: 4cm,
  offset: 0.5cm,
  padding: 0.5em,
  color: gray.darken(30%),
  size: 0.9em,
  style: "italic",
  border: none,
) = {
  // Determine layout based on side parameter
  if side == "right" {
    let note-block = box(
      width: width,
      inset: padding,
      fill: if border != none { none } else { color.lighten(95%) },
      stroke: if border != none { border } else { none },
      radius: 4pt,
      text(size: size, style: style, fill: color, body)
    )

    pad(
      right: width + offset,
      block(
        width: 100%,
        height: auto,
        [#place(right + top, dx: offset, note-block)]
      )
    )
  } else if side == "left" {
    let note-block = box(
      width: width,
      inset: padding,
      fill: if border != none { none } else { color.lighten(95%) },
      stroke: if border != none { border } else { none },
      radius: 4pt,
      text(size: size, style: style, fill: color, body)
    )

    pad(
      left: width + offset,
      block(
        width: 100%,
        height: auto,
        [#place(left + top, dx: -offset, note-block)]
      )
    )
  }
}

// ==========================================
// Multi-Column Support
// ==========================================

#let columns(
  count: 2,
  gutter: 1em,
  separator: none,  // Can be none, "line", or a custom function
  widths: none,     // Can specify custom widths as an array
  ..children,
) = {
  let content = children.pos()

  // Calculate column widths
  let col-widths = ()
  if widths == none {
    // Equal widths
    let column-width = calc.floor(100% / count - gutter * (count - 1) / count, 1pt)
    col-widths = (column-width,) * count
  } else {
    // Custom widths
    col-widths = widths
  }

  // Apply separator if needed
  if separator == "line" {
    grid(
      columns: col-widths,
      column-gutter: gutter,
      ..content.enumerate().map(((i, c)) => {
        if i < content.len() - 1 {
          (c, line(angle: 90deg, length: 100%, stroke: (thickness: 0.5pt, dash: "solid")))
        } else {
          c
        }
      }).flatten()
    )
  } else if separator != none and type(separator) == "function" {
    grid(
      columns: col-widths,
      column-gutter: gutter,
      ..content.enumerate().map(((i, c)) => {
        if i < content.len() - 1 {
          (c, separator())
        } else {
          c
        }
      }).flatten()
    )
  } else {
    // No separator
    grid(
      columns: col-widths,
      column-gutter: gutter,
      ..content
    )
  }
}

// ==========================================
// Theorem Environments
// ==========================================

#let theorem-base(
  counter,
  prefix,
  title: none,
  numbered: true,
  color: blue.darken(20%),
  fill: blue.lighten(95%),
  body
) = {
  let number = if numbered { counter.step(); context(counter.display()) }

  block(
    width: 100%,
    fill: fill,
    radius: 4pt,
    stroke: color.darken(10%),
    inset: 0.6em,
  )[
    #text(weight: "bold")[#prefix #if numbered {number}]
    #if title != none [#text(style: "italic")[#title].]
    #h(0.5em)
    #body
  ]
}

#let theorem(
  title: none,
  numbered: true,
  color: blue.darken(20%),
  ..body
) = {
  theorem-base(
    theoremCounter,
    "Theorem",
    title: title,
    numbered: numbered,
    color: color,
    fill: color.lighten(95%),
    ..body
  )
}

#let lemma(
  title: none,
  numbered: true,
  color: green.darken(20%),
  ..body
) = {
  theorem-base(
    lemmaCounter,
    "Lemma",
    title: title,
    numbered: numbered,
    color: color,
    fill: color.lighten(95%),
    ..body
  )
}

#let definition(
  title: none,
  numbered: true,
  color: purple.darken(20%),
  ..body
) = {
  theorem-base(
    definitionCounter,
    "Definition",
    title: title,
    numbered: numbered,
    color: color,
    fill: color.lighten(95%),
    ..body
  )
}

#let corollary(
  title: none,
  numbered: true,
  color: orange.darken(20%),
  ..body
) = {
  theorem-base(
    corollaryCounter,
    "Corollary",
    title: title,
    numbered: numbered,
    color: color,
    fill: color.lighten(95%),
    ..body
  )
}

#let example(
  title: none,
  numbered: true,
  color: aqua.darken(20%),
  ..body
) = {
  theorem-base(
    exampleCounter,
    "Example",
    title: title,
    numbered: numbered,
    color: color,
    fill: color.lighten(95%),
    ..body
  )
}

// Choose from different proof-ending symbols
#let proof(body, qed-symbol: "■") = {
  block(body)

  let symbol = if qed-symbol == "■" {
    text(fill: gray.darken(30%), size: 1.2em, weight: "bold")[■]
  } else if qed-symbol == "□" {
    text(fill: gray.darken(30%), size: 1.2em, weight: "bold")[□]
  } else if qed-symbol == "∎" {
    text(fill: gray.darken(30%), size: 1.2em)[∎]
  } else if qed-symbol == "Q.E.D." {
    text(fill: gray.darken(30%), style: "italic")[Q.E.D.]
  } else {
    text(fill: gray.darken(30%))[#qed-symbol]
  }

  align(right, symbol)
}

// ==========================================
// Algorithm Environment
// ==========================================

#let algorithm(
  title: none,
  numbered: true,
  line-numbers: true,
  color: red.darken(20%),
  ..body
) = {
  let number = if numbered {
    algorithmCounter.step()
    context algorithmCounter.display()
  }

  let content = body.pos().join()

  block(
    width: 100%,
    fill: color.lighten(95%),
    radius: 4pt,
    stroke: color.darken(10%),
    inset: 0.6em,
  )[
    #text(weight: "bold")[Algorithm #if numbered {number}]
    #if title != none [:#text(style: "italic")[#title]]

    #v(0.5em)

    #if line-numbers {
      // Add line numbers if enabled
      set enum(numbering: "1")
      enum(..content.split(regex("\n")).map(line => [#line]))
    } else {
      content
    }
  ]
}

// ==========================================
// Result Tables
// ==========================================

// Helper for highlighting the best value in a row
#let highlight-best(
  values,
  goal: "max",
  highlight-color: green.lighten(80%),
  precision: 2
) = {
  let best-idx = if goal == "max" {
    values.position(calc.max(..values))
  } else {
    values.position(calc.min(..values))
  }

  values.enumerate().map(((i, v)) => {
    if i == best-idx {
      box(fill: highlight-color, inset: 3pt, radius: 2pt,
          text(weight: "bold")[#fmt-num(v, precision)])
    } else {
      fmt-num(v, precision)
    }
  })
}

// Format a number with specific precision
#let fmt-num(value, precision: 2) = {
  if type(value) == "integer" {
    str(value)
  } else {
    let factor = calc.pow(10, precision)
    let rounded = calc.round(value * factor) / factor
    str(rounded)
  }
}

// Create a model comparison table
#let model-comparison-table(
  models,
  metrics,
  values,
  highlight: "none", // "none", "row", "col", "best"
  precision: 2
) = {
  table(
    columns: (auto, ) + (auto,) * metrics.len(),
    inset: 6pt,
    align: (left, ) + (center,) * metrics.len(),
    stroke: 0.5pt,
    fill: (_, col) => if col == 0 { luma(250) } else { white },
    [*Model*], ..metrics.map(m => [*#m*]),
    ..models.enumerate().map(((i, model)) => {
      let row-values = values.at(i)
      if highlight == "row" {
        (text(weight: "bold")[#model],
         ..highlight-best(row-values, goal: "max", precision: precision))
      } else {
        (text(weight: "bold")[#model],
         ..row-values.map(v => fmt-num(v, precision)))
      }
    }).flatten()
  )
}

// ==========================================
// Problem box function
// ==========================================

#let problem(
  title: "",
  color: blue.darken(20%),
  numbered: true,
  ..body
) = {
  if numbered {
    [== Problem #problemCounter.step() #context {problemCounter.display()}]
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

// ==========================================
// Main template function
// ==========================================

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
  margin-size: 2.5cm,  // Added configurability for margins
  body
) = {
  // Document metadata
  set document(title: title, author: author)

  // Page setup
  set page(
    paper: "us-letter",
    margin: (top: margin-size, bottom: margin-size, left: margin-size, right: margin-size),

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

  // Set up a proper reference display for theorems, definitions, etc.
  show ref: it => {
    let element = it.element
    let loc = it.location()

    if element == none {
      return it
    }

    if element.func() == heading and element.level == 2 {
      [Problem #it.number]
    } else if element.func() == theorem {
      [Theorem #it.number]
    } else if element.func() == lemma {
      [Lemma #it.number]
    } else if element.func() == definition {
      [Definition #it.number]
    } else if element.func() == corollary {
      [Corollary #it.number]
    } else if element.func() == example {
      [Example #it.number]
    } else if element.func() == algorithm {
      [Algorithm #it.number]
    } else {
      it
    }
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

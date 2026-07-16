// axiomst/common.typ - Shared components for homework and slides
#import "@preview/showybox:2.0.4": showybox

// Counters
#let problem-counter = counter("problem")
#let theorem-counter = counter("theorem")
#let definition-counter = counter("definition")
#let remark-counter = counter("remark")
#let proposition-counter = counter("proposition")
#let lemma-counter = counter("lemma")
#let corollary-counter = counter("corollary")
#let example-counter = counter("example")
#let algorithm-counter = counter("algorithm")

// Global state for homework output version
#let homework-version-state = state("homework-version", "solutions")

// Global state for homework labels
#let homework-labels-state = state(
  "homework-labels",
  (problem: [Problem], answer: [Answer:], solution: [Solution:]),
)

// Column layout utility
#let columns(
  count: 2,
  gutter: 1em,
  separator: none,
  widths: none,
  ..children,
) = {
  let content = children.pos()

  let col-widths = ()
  if widths == none {
    let available-width = 100% - gutter * (count - 1)
    let column-width = available-width / count
    col-widths = (column-width,) * count
  } else {
    col-widths = widths
  }

  if separator == "line" {
    grid(
      columns: col-widths,
      column-gutter: gutter,
      ..content
        .enumerate()
        .map(((i, c)) => {
          if i < content.len() - 1 {
            (c, line(angle: 90deg, length: 100%, stroke: (thickness: 0.5pt, dash: "solid")))
          } else {
            c
          }
        })
        .flatten()
    )
  } else if separator != none and type(separator) == "function" {
    grid(
      columns: col-widths,
      column-gutter: gutter,
      ..content
        .enumerate()
        .map(((i, c)) => {
          if i < content.len() - 1 {
            (c, separator())
          } else {
            c
          }
        })
        .flatten()
    )
  } else {
    grid(
      columns: col-widths,
      column-gutter: gutter,
      ..content
    )
  }
}

// Counter for #num(...) equations on slides
#let num-counter = counter("axiomst-num-equation")

// Explicitly numbered display equation. On slides the default is unnumbered
// (`set math.equation(numbering: none)`), so wrap with `#num(...)` to opt in
// to numbering. Overlay-aware: steps exactly once per logical reveal so the
// number stays stable across pause overlays.
#let num(body, format: "(1)") = context {
  let math-body = if type(body) == content and body.func() == math.equation {
    body.body
  } else {
    body
  }
  let handout = state("axiomst-handout", false).get()
  let subslide = state("axiomst-subslide", 1).get()
  let pause = counter("axiomst-pause").get().first()
  let visible = handout or pause < subslide
  let first-visible = handout or pause + 1 == subslide

  if first-visible { num-counter.step() }

  let rendered = grid(
    columns: (1fr, auto),
    column-gutter: 1em,
    align: (center + horizon, right + horizon),
    math.equation(block: true, numbering: none, math-body), context num-counter.display(format),
  )
  if visible { rendered } else { hide(rendered) }
}

// Base theorem-like box
#let theorem-base(
  ctr,
  prefix,
  title: none,
  numbered: true,
  color: blue.darken(20%),
  fill: blue.lighten(95%),
  body,
) = {
  context {
    let handout = state("axiomst-handout", false).get()
    let subslide = state("axiomst-subslide", 1).get()
    let pause = counter("axiomst-pause").get().first()
    let visible = handout or pause < subslide
    let first-visible = handout or pause + 1 == subslide

    if visible {
      let number = if numbered {
        if first-visible { ctr.step() }
        context (ctr.display())
      }

      block(
        width: 100%,
        fill: fill,
        radius: 4pt,
        stroke: color.darken(10%),
        inset: 0.6em,
      )[
        #text(weight: "bold")[#prefix #if numbered { number }]
        #if title != none [#text(style: "italic")[#title].]
        #v(0.5em)
        #body
      ]
    }
  }
}

// Theorem
#let theorem(
  title: none,
  numbered: true,
  color: blue.darken(20%),
  ..body,
) = {
  theorem-base(
    theorem-counter,
    "Theorem",
    title: title,
    numbered: numbered,
    color: color,
    fill: color.lighten(95%),
    ..body,
  )
}

// Lemma
#let lemma(
  title: none,
  numbered: true,
  color: green.darken(20%),
  ..body,
) = {
  theorem-base(
    lemma-counter,
    "Lemma",
    title: title,
    numbered: numbered,
    color: color,
    fill: color.lighten(95%),
    ..body,
  )
}

// Remark
#let remark(
  title: none,
  numbered: true,
  color: gray.darken(20%),
  ..body,
) = {
  theorem-base(
    remark-counter,
    "Remark",
    title: title,
    numbered: numbered,
    color: color,
    fill: color.lighten(95%),
    ..body,
  )
}

// Proposition
#let proposition(
  title: none,
  numbered: true,
  color: red.darken(20%),
  ..body,
) = {
  theorem-base(
    proposition-counter,
    "Proposition",
    title: title,
    numbered: numbered,
    color: color,
    fill: color.lighten(95%),
    ..body,
  )
}

// Definition
#let definition(
  title: none,
  numbered: true,
  color: purple.darken(20%),
  ..body,
) = {
  theorem-base(
    definition-counter,
    "Definition",
    title: title,
    numbered: numbered,
    color: color,
    fill: color.lighten(95%),
    ..body,
  )
}

// Corollary
#let corollary(
  title: none,
  numbered: true,
  color: orange.darken(20%),
  ..body,
) = {
  theorem-base(
    corollary-counter,
    "Corollary",
    title: title,
    numbered: numbered,
    color: color,
    fill: color.lighten(95%),
    ..body,
  )
}

// Example
#let example(
  title: none,
  numbered: true,
  color: aqua.darken(20%),
  ..body,
) = {
  theorem-base(
    example-counter,
    "Example",
    title: title,
    numbered: numbered,
    color: color,
    fill: color.lighten(95%),
    ..body,
  )
}

// Proof block
#let proof(body, title: [Proof.], qed-symbol: "fill") = {
  let symbol = if qed-symbol == "fill" {
    text(fill: gray.darken(30%), size: 1.2em, weight: "bold")[■]
  } else if qed-symbol == "hollow" {
    text(fill: gray.darken(30%), size: 1.2em, weight: "bold")[□]
  } else if qed-symbol == "filled-cube" {
    text(fill: gray.darken(30%), size: 1.2em)[∎]
  } else if qed-symbol == "Q.E.D." {
    text(fill: gray.darken(30%), style: "italic")[Q.E.D.]
  } else {
    text(fill: gray.darken(30%))[#qed-symbol]
  }

  block(
    width: 100%,
    breakable: true,
  )[
    #if title != none [
      #text(weight: "bold")[#title]
      #h(0.4em)
    ]
    #body
    #v(0.2em)
    #align(right, symbol)
  ]
}

// Problem box
#let problem(
  title: "",
  color: blue.darken(20%),
  numbered: true,
  label: auto,
  answer-label: auto,
  solution-label: auto,
  answer: none,
  solution: none,
  ..body,
) = {
  let resolve-label = (value, key) => if value == auto {
    homework-labels-state.get().at(key)
  } else {
    value
  }

  if numbered {
    problem-counter.step()
    place(hide(context {
      let problem-number = problem-counter.get().first()
      let resolved-label = resolve-label(label, "problem")
      counter(heading).update((0, problem-number - 1))
      heading(
        level: 2,
        supplement: resolved-label,
        numbering: (..nums) => {
          let nums = nums.pos()
          if nums.len() == 2 and nums.at(0) == 0 {
            [#resolved-label #nums.at(1):]
          }
        },
      )[#title]
    }))
  }

  let content = body.pos()
  let box-title = if numbered {
    context {
      let resolved-label = resolve-label(label, "problem")
      if title == "" {
        [#resolved-label #problem-counter.display()]
      } else {
        [#resolved-label #problem-counter.display(): #title]
      }
    }
  } else {
    title
  }

  showybox(
    frame: (
      border-color: color.darken(10%),
      title-color: color.lighten(85%),
      body-color: color.lighten(95%),
    ),
    title-style: (
      color: black,
      weight: "bold",
    ),
    breakable: true,
    title: box-title,
  )[
    #for item in content {
      item
    }
    #context {
      let version = homework-version-state.get()
      let selected = none
      let selected-label = none

      if version == "answers" {
        selected = if answer != none { answer } else { solution }
        selected-label = resolve-label(answer-label, "answer")
      } else if version == "solutions" {
        selected = solution
        selected-label = resolve-label(solution-label, "solution")
      }

      if selected != none [
        #v(0.8em)
        #line(length: 100%, stroke: color.lighten(60%))
        #v(0.5em)
        #text(weight: "bold")[#selected-label]
        #v(0.3em)
        #selected
      ]
    }
  ]
}

// Subquestions - accepts either a single body or multiple arguments
#let subquestions(..args) = {
  let items = args.pos()
  enum(
    numbering: n => text(weight: "bold")[Q#n:],
    tight: false,
    spacing: 1em,
    ..items,
  )
}

// Figure with caption
#let pfigure(image-path: "", caption: "", width: 80%) = {
  align(center)[
    #image(image-path, width: width)
    #if caption != "" [
      #v(0.3em)
      #text(size: 0.9em, style: "italic")[#caption]
    ]
  ]
}

// Table with caption
#let ptable(content, caption: "") = {
  align(center)[
    #content
    #if caption != "" [
      #v(0.3em)
      #text(size: 0.9em, style: "italic")[#caption]
    ]
  ]
}

// Instructions block
#let instructions(body) = {
  block(
    width: 100%,
    fill: yellow.lighten(90%),
    radius: 4pt,
    stroke: yellow.darken(20%),
    inset: 1em,
    breakable: true,
  )[
    #text(weight: "bold", size: 1.1em)[Assignment Instructions]
    #v(0.5em)
    #body
  ]
  v(1em)
}

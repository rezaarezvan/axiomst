#import "../src/lib.typ": *

#show: slides.with(title: "Counter Overlay Regression")

#slide(title: "Definition A")[
  - Before
  #pause
  #definition(title: "First")[
    $ a = b $
  ]
]

#slide(title: "Definition B")[
  - Before
  #pause
  #definition(title: "Second")[
    $ c = d $
  ]
]

#slide(title: "Unnumbered Equations")[
  - First layer
  #pause
  - These equations must not perturb theorem-like counters.
  $ e = f $
  $ g = h $
]

#slide(title: "More Pauses")[
  - One
  #pause
  - Two
  #pause
  - Three
]

#slide(title: "Definition C")[
  - Before
  $ i = j $
  #pause
  #definition(title: "Optimal")[
    $ k = l $
  ]
]

#slide(title: "Equation A")[
  #num($ m = n $)
  #pause
  - Keep equation number stable.
  #pause
  - Still stable.
]

#slide(title: "Equation B")[
  #pause
  #num($ o = p $)
  #pause
  - Keep revealed equation stable.
]

#slide(title: "Figure A")[
  #figure(rect(width: 10pt, height: 10pt), caption: [Alpha])
  #pause
  - Keep figure number stable.
  #pause
  - Still stable.
]

#slide(title: "Figure B")[
  #pause
  #figure(rect(width: 10pt, height: 10pt), caption: [Beta])
  #pause
  - Keep revealed figure stable.
]

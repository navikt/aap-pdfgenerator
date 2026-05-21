#import "/lib/innbygger/style.typ":  title-size

#let nav-header(page-title) = [
  #place(top + left)[
    #image("/resources/Navlogo.png", width: 36pt, alt: "NAV logo")
  ]

  // Title
  #if page-title != "" [
    #pad(left: 30mm, top: 3mm, bottom: 5mm)[
      #text(size: title-size, weight: 600)[#page-title]
    ]
  ]
]
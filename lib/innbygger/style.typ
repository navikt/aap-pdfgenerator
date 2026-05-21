// Shared typography and page setup for all templates.
// CSS px → PDF pt mapping: 12px→9pt, 14px→10.5pt, 15px→11pt, 18px→13.5pt, 20px→15pt

#let body-size = 10.5pt
#let small-size = 9pt
#let medium-size = 11pt
#let h1-size = 15pt
#let h2-size = 13.5pt
#let section-size = 16pt
#let title-size = 18pt
#let footer-size = 9pt

#let nav-blue = rgb("#0067c5")

// Standard page footer with page numbers
#let page-footer() = context [
  #set text(size: footer-size)
  #h(1fr)
  side #counter(page).display() av #counter(page).final().first()
]

// Apply standard page setup. Call with `show: page-setup()` or `show: page-setup(margin: (...))`.
#let page-setup(
  margin: (top: 1.5cm, bottom: 1cm, left: 48pt, right: 36pt),
  footer: page-footer(),
) = body => {
  set page(paper: "a4", margin: margin, footer: footer)
  set text(font: "Source Sans Pro", size: body-size)
  set par(leading: 0.5em)
  show link: set text(fill: nav-blue)
  show link: underline
  body
}

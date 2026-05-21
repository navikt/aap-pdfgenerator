// Recursive block renderer for the AAP data structure.
// Supports: TABELL, TABELLRAD, LISTE, FELT, FELTGRUPPE, GRUPPE, FRITEKST
#let render-blokk-impl(render, blokk) = {
  let t = blokk.at("type", default: "")
  let block-gap = 15pt
  let inner-gap = 5pt
  let compact-gap = 2pt
  let strong-weight = 600

  if t == "TABELL" {
    block(breakable: false, width: 100%, below: block-gap)[
      #if blokk.at("overskrift", default: "") != "" [
        #text(weight: strong-weight)[#blokk.overskrift]
      ]
      #if blokk.at("undertekst", default: "") != "" [
        #blokk.undertekst
      ]
      #for rad in blokk.at("tabellrader", default: ()) {
        grid(
          columns: (1fr, 1fr),
          gutter: 5pt,
          [#rad.at("venstretekst", default: "")],
          [#rad.at("høyretekst", default: "")]
        )
        for sub in rad.at("underblokker", default: ()) {
          render(render, sub)
        }
      }
    ]
  } else if t == "TABELLRAD" {
    grid(
      columns: (1fr, 1fr),
      gutter: 4pt,
      [#blokk.at("venstretekst", default: "")],
      [#blokk.at("høyretekst", default: "")]
    )
  } else if t == "LISTE" {
    block(below: block-gap)[
      #if blokk.at("tittel", default: "") != "" [
        #blokk.tittel
      ]
      #for punkt in blokk.at("punkter", default: ()) [
        #grid(
          columns: (20pt, 1fr),
          align: (horizon, left),
          image("/resources/vedlegg.png", width: 15pt, alt: "Vedlegg"),
          punkt
        )
      ]
    ]
  } else if t == "FELT" {
    block(breakable: false, below: block-gap)[
      #text(weight: strong-weight)[#blokk.at("felt", default: "")]
      #if blokk.at("verdi", default: "") != "" [
        #v(inner-gap, weak: true)
        #blokk.verdi
      ]
    ]
  } else if t == "FELTGRUPPE" {
    block(breakable: false, below: block-gap)[
      #if blokk.at("overskrift", default: "") != "" [
        #text(weight: strong-weight)[#blokk.overskrift]
        #v(inner-gap, weak: true)
      ]
      #block(
        stroke: (left: 4pt + luma(150)),
        inset: (left: 15pt, top: 4pt, bottom: 4pt),
        width: 100%,
      )[
        #for felt in blokk.at("felter", default: ()) {
          render(render, felt)
        }
      ]
    ]
  } else if t == "GRUPPE" {
    block(breakable: false, below: block-gap)[
      #if blokk.at("overskrift", default: "") != "" [
        #text(weight: strong-weight)[#blokk.overskrift]
        #v(inner-gap, weak: true)
      ]
      #for rad in blokk.at("tabellrader", default: ()) {
        render(render, rad)
      }
    ]
  } else if t == "FRITEKST" {
    let indent = blokk.at("indent", default: false)
    block(
      inset: (left: if indent { 20pt } else { 0pt }),
      below: compact-gap,
    )[#blokk.at("tekst", default: "")]
  }
}

#let render-blokk(blokk) = render-blokk-impl(render-blokk-impl, blokk)

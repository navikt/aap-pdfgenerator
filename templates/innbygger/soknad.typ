#let data = json("/data.json")
#let søker = data.søker
#let kvittering = data.kvittering
#let soknadsId = data.at("soknadsId", default: "")

#import "/lib/innbygger/utils.typ": iso-til-norsk-dato
#import "/lib/innbygger/blokker.typ": render-blokk
#import "/lib/innbygger/style.typ": page-setup, page-footer, body-size, small-size, medium-size, h1-size, h2-size, section-size, title-size, footer-size
#import "/lib/innbygger/header.typ": nav-header

#let person-size = section-size
#let sent-size = body-size

#show: page-setup(
  margin: (left: 36pt),
  footer: context [
    #set text(size: footer-size)
    #pad(x: 0.3cm)[
      #soknadsId
      #h(1fr)
      side #counter(page).display() av #counter(page).final().first()
    ]
  ],
)
#show heading.where(level: 2): set text(size: section-size, weight: 600)

#pad(left: 0.7cm, top: -0.8cm, bottom: 0.5cm)[
      #nav-header("Søknad om Arbeidsavklaringspenger(AAP)")
]

// Person info
#pad(x: 0.7cm, bottom: 5mm)[
  #set text(size: small-size)
  Navn: #søker.navn.fornavn #søker.navn.at("mellomnavn", default: "") #søker.navn.etternavn
  #if søker.at("fnr", default: "") != "" {
    let fnr = søker.fnr
    [\ Fødselsnummer: #if fnr.len() >= 6 [#fnr.slice(0, 6) #fnr.slice(6)] else [#fnr]]
  }
  #if kvittering.at("mottattdato", default: "") != "" [
    \ Søknad mottatt: #iso-til-norsk-dato(kvittering.mottattdato)
  ]
]

// Temaer
#pad(x: 0.7cm)[
  #for tema in kvittering.at("temaer", default: ()) {
    block(below: 25pt)[
      #heading(level: 2)[#tema.overskrift]
      #if tema.at("beskrivelse", default: "") != "" [
        #v(5pt, weak: true)
        #tema.beskrivelse
      ]
      #v(10pt, weak: true)
      #for blokk in tema.at("underblokker", default: ()) {
        render-blokk(blokk)
      }
    ]
  }
]
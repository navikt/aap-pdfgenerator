#let data = json("/data.json")

#import "/lib/innbygger/utils.typ": iso-til-norsk-dato
#import "/lib/innbygger/header.typ": nav-header
#import "/lib/innbygger/style.typ": page-setup, body-size, small-size, medium-size, h1-size, h2-size

//#show: page-setup(margin: (top: 1.5cm, bottom: 1cm, left: 36pt, right: 36pt))
#show: page-setup()

// NAV logo
#pad(top: 0.5cm)[
      #nav-header("")
]

// Person info
#pad(top: 10mm, bottom: 24pt)[
  #set text(size: small-size)
  Fødselsnummer: #{ let id = data.ident; id.slice(0, 6) + " " + id.slice(6) } \
  Meldekort-ID: #data.meldekortid \
  Mottatt: #iso-til-norsk-dato(data.sendtInnDato)
]

// Title
#text(size: h1-size, weight: 500)[Meldekort for #data.meldeperiode.uker]
#v(4pt, weak: true)
#text(size: medium-size)[#iso-til-norsk-dato(data.meldeperiode.fraOgMedDato) - #iso-til-norsk-dato(data.meldeperiode.tilOgMedDato)]

// Innsendingsvindu info
#v(16pt)
#text(size: medium-size)[
  Du kan sende dette meldekortet fra #iso-til-norsk-dato(data.innsendingsvindu.fraOgMedDato), og senest #iso-til-norsk-dato(data.innsendingsvindu.tilOgMedDato) for å unngå trekk i utbetalingen.
  #if data.at("harBrukerVedtakIKelvin", default: false) [
    Du vil få utbetalt AAP cirka 2 til 3 virkedager etter at du har levert meldekortet.
  ]
]

// Takk for at du er ærlig
#v(16pt)
#text(weight: "bold")[Takk for at du er ærlig] \
#text(size: medium-size)[Det er viktig at du gir oss riktige opplysninger.] \
#text(size: medium-size)[#link("https://www.nav.no/endringer")[Les mer om viktigheten av å gi riktige opplysninger]]

// Fyll ut meldekort
#v(16pt)
#text(size: h2-size, weight: 500)[Fyll ut meldekort]
#v(4pt, weak: true)
#text(size: medium-size)[Skriv inn timene du har arbeidet for perioden. Timer skrives med desimal til nærmeste halvtime. For eksempel blir 7 timer og 30 min = 7,5 timer.]

#v(16pt)
#text(size: medium-size)[Les mer om hva som skal fylles ut] \
#pad(left: 8pt)[
  #text(size: medium-size)[Alle aktiviteter som er betalt, eller som normalt ville ha vært betalt, regnes som arbeid og skal føres på meldekortet. For eksempel regnes gratisarbeid for andre som vanligvis er betalt, frilansarbeid og lønnede verv som arbeid. #link("https://www.nav.no/send-meldekort-aap#arbeid")[Les mer om hva som regnes som arbeid.]]
]

// Har du arbeidet i perioden?
#v(16pt)
#text(weight: "bold")[Har du arbeidet i perioden?] \
#if data.meldekort.harDuArbeidet [
  (x) Ja \
  #h(16pt) Nei
] else [
  #h(16pt) Ja \
  (x) Nei
]

// Antall timer arbeidet
#v(16pt)
#text(weight: "bold")[Antall timer arbeidet]

#for uke in data.meldekort.timerArbeidPerUkeIPerioden [
  #v(8pt)
  Uke #uke.ukenummer #iso-til-norsk-dato(uke.fraOgMedDato) - #iso-til-norsk-dato(uke.tilOgMedDato)
  #for dag in uke.dager [
    #pad(left: 8pt)[
      #iso-til-norsk-dato(dag.dag): #dag.timerArbeid timer
    ]
  ]
]

// Sammenlagt for perioden
#v(16pt)
#text(weight: "bold")[Sammenlagt for perioden] \
#data.sammenlagtArbeidIPerioden timer arbeidet

// Samtykke
#v(16pt)
#text(weight: "bold")[Samtykke] \
Jeg bekrefter at jeg har gitt riktige opplysninger
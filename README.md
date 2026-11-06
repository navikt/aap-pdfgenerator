# aap-pdfgenerator

`aap-pdfgenerator` er en lokal oppsettpakke rundt `pdfgenrs` (`ghcr.io/navikt/pdfgenrs`). Repoet inneholder templates, data, fonter og ressurser som mountes inn i containeren.

## Kjør appen lokalt

Krav: Docker.

```bash
./run_local_dev.sh
```

Appen eksponeres på `http://localhost:8089`.

## Bruk appen

### Templates + JSON til PDF

Pdfer fra templates med tiljørende json-fil i data folderen kan nås i nettleser ved lokal utvikling `GET http://localhost:8089/api/v1/genpdf/innbygger/soknad`, eller ved POST: `templates/innbygger/soknad.typ` og `data/innbygger/soknad.json`:

```bash
curl -sS -X POST \
  "http://localhost:8089/api/v1/genpdf/innbygger/soknad" \
  -H "Content-Type: application/json" \
  --data-binary @data/innbygger/soknad.json \
  -o soknad.pdf
```

### HTML til PDF

```bash
curl -sS -X POST \
  "http://localhost:8089/api/v1/genpdf/html/innbygger" \
  -H "Content-Type: text/html" \
  --data-binary '<html><body><h1>Hei</h1><p>Fra HTML</p></body></html>' \
  -o html.pdf
```

### Bilde til PDF

Støtter `image/png`, `image/jpeg`, `image/webp` og `image/svg+xml`. Vi tillater bare jpeg og png-bilder:

```bash
curl -sS -X POST \
  "http://localhost:8089/api/v1/genpdf/image/innbygger" \
  -H "Content-Type: image/png" \
  --data-binary @eksempel.png \
  -o bilde.pdf
```

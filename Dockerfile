FROM ghcr.io/navikt/pdfgenrs:1.0.5

COPY templates /app/templates
COPY lib /app/lib
COPY fonts /app/fonts
COPY resources /app/resources
COPY data /app/data

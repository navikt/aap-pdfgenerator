FROM ghcr.io/navikt/pdfgenrs:0.1.59

COPY templates /app/templates
COPY lib /app/lib
COPY fonts /app/fonts
COPY resources /app/resources
COPY data /app/data

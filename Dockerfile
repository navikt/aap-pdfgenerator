FROM ghcr.io/navikt/pdfgenrs:1.0.23

ENV RUST_LOG=trace

COPY templates /app/templates
COPY lib /app/lib
COPY fonts /app/fonts
COPY resources /app/resources
COPY data /app/data

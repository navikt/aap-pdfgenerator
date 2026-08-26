FROM ghcr.io/navikt/pdfgenrs:1.0.21

ENV RUST_LOG=trace

COPY templates /app/templates
COPY lib /app/lib
COPY fonts /app/fonts
COPY resources /app/resources
COPY data /app/data
# 50 mb request body limit for POST requests
ENV REQUEST_BODY_LIMIT_BYTES=52428800
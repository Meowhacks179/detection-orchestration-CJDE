#!/bin/bash
set -euo pipefail

SIGMA_DIR="sigma"
OUTPUT_DIR="converted/splunk"
OUTPUT_FILE="$OUTPUT_DIR/savedsearches.conf"
PIPELINE="sigma/mappings/splunk.yml"

mkdir -p "$OUTPUT_DIR"

sigma convert \
  -t splunk \
  -f savedsearches \
  -p "$PIPELINE" \
  -o "$OUTPUT_FILE" \
  "$SIGMA_DIR"

echo "Conversion complete. Output written to $OUTPUT_FILE"

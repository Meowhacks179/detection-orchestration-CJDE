#!/bin/bash
set -euo pipefail

SIGMA_DIR="sigma/rules"
OUTPUT_DIR="converted/splunk"
OUTPUT_FILE="$OUTPUT_DIR/savedsearches.conf"

mkdir -p "$OUTPUT_DIR"

sigma convert \
  -t splunk \
  -f savedsearches \
  -p splunk_windows \
  -o "$OUTPUT_FILE" \
  "$SIGMA_DIR"

echo "Conversion complete. Output written to $OUTPUT_FILE"


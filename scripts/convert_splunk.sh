#!/bin/bash
set -euo pipefail

SIGMA_DIR="sigma"
OUTPUT_DIR="converted/splunk"
OUTPUT_FILE="$OUTPUT_DIR/savedsearches.conf"

mkdir -p "$OUTPUT_DIR"

# Using the built-in splunk_windows pipeline since sigma/mappings/splunk.yml
# is in the old sigmac format and isn't compatible with pySigma yet.
# Swap -p splunk_windows for -p sigma/mappings/splunk.yml once that file
# is rewritten in the new pySigma pipeline schema.
sigma convert \
  -t splunk \
  -f savedsearches \
  -p splunk_windows \
  -o "$OUTPUT_FILE" \
  "$SIGMA_DIR"

echo "Conversion complete. Output written to $OUTPUT_FILE"

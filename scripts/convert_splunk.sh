#!/bin/bash

SIGMA_DIR="sigma"
OUTPUT_DIR="converted/splunk"
OUTPUT_FILE="$OUTPUT_DIR/savedsearches.conf"

mkdir -p "$OUTPUT_DIR"
echo "" > "$OUTPUT_FILE"

for rule in $(find "$SIGMA_DIR" -name "*.yml"); do
    echo "Converting: $rule"

    RULE_NAME=$(basename "$rule" .yml)

    # Use sigmac instead of sigma-cli
    SPL_QUERY=$(sigmac -t splunk "$rule")

    cat <<EOF >> "$OUTPUT_FILE"
[$RULE_NAME]
search = $SPL_QUERY
cron_schedule = */5 * * * *
alert_type = always
alert.severity = 5

EOF

done

echo "Conversion complete. Output written to $OUTPUT_FILE"

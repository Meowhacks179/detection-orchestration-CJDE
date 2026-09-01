#!/bin/bash

# Input and output folders
SIGMA_DIR="sigma"
OUTPUT_DIR="converted/splunk"
OUTPUT_FILE="$OUTPUT_DIR/savedsearches.conf"

# Ensure output folder exists
mkdir -p "$OUTPUT_DIR"

# Clear old output
echo "" > "$OUTPUT_FILE"

# Loop through all Sigma rules
for rule in $(find "$SIGMA_DIR" -name "*.yml"); do
    echo "Converting: $rule"

    # Extract rule name (used for Splunk stanza)
    RULE_NAME=$(basename "$rule" .yml)

    # Convert Sigma → Splunk SPL
    SPL_QUERY=$(sigma-cli convert -t splunk "$rule")

    # Append to savedsearches.conf
    cat <<EOF >> "$OUTPUT_FILE"
[$RULE_NAME]
search = $SPL_QUERY
cron_schedule = */5 * * * *
alert_type = always
alert.severity = 5

EOF

done

echo "Conversion complete. Output written to $OUTPUT_FILE"

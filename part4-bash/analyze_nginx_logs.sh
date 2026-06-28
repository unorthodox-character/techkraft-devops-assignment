#!/bin/bash

LOGFILE=${1:-/var/log/nginx/access.log}

if [ ! -f "$LOGFILE" ]; then
    echo "Error: Log file not found: $LOGFILE"
    exit 1
fi

echo "========================================="
echo "      NGINX LOG ANALYSIS REPORT"
echo "========================================="

TOTAL=$(grep -vc '^$' "$LOGFILE")
UNIQUE_IPS=$(awk '{print $1}' "$LOGFILE" | sort | uniq | wc -l)

ERROR4=$(awk '$9 ~ /^4/ {count++} END {print count+0}' "$LOGFILE")
ERROR5=$(awk '$9 ~ /^5/ {count++} END {print count+0}' "$LOGFILE")

PCT4=$(awk -v e="$ERROR4" -v t="$TOTAL" 'BEGIN {if(t>0) printf "%.2f",(e/t)*100; else print "0.00"}')
PCT5=$(awk -v e="$ERROR5" -v t="$TOTAL" 'BEGIN {if(t>0) printf "%.2f",(e/t)*100; else print "0.00"}')

echo
echo "Total Requests : $TOTAL"
echo "Unique IPs     : $UNIQUE_IPS"
echo "4xx Errors     : $ERROR4 ($PCT4%)"
echo "5xx Errors     : $ERROR5 ($PCT5%)"

echo
echo "========== Top 10 Client IPs =========="
awk '{print $1}' "$LOGFILE" \
| sort \
| uniq -c \
| sort -rn \
| head -10 \
| awk '{printf "%-20s %s requests\n",$2,$1}'

echo
echo "======= Top 10 Requested Endpoints ======="

awk '{
print $7
}' "$LOGFILE" \
| grep -v '^$' \
| sort \
| uniq -c \
| sort -rn \
| head -10 \
| awk '{printf "%-40s %s requests\n",$2,$1}'

echo

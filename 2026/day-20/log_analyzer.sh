#!/bin/bash

set -euo pipefail

if [ $# -lt 1 ]; then
        echo "Usage ./log_analyzer.sh /path/log_file.txt"
        exit 1
fi

log_file=$1

if [ ! -f $log_file ]; then
        echo "Log file does not exist"
        exit 1
fi

date_var=$(date +%Y-%m-%d)
log_report=log_report_$date_var.txt

echo "DATE OF ANALYSIS: $date_var">$log_report
echo "LOG FILE NAME: $log_file">>$log_report
echo "TOTAL LINES PROCESSSED: " $(grep -c "" $log_file)>>$log_report

echo "Total no of errors occurred: " $(grep -E "ERROR|Failed" "$log_file" | wc -l) >>$log_report
echo ""

echo "----------------CRITICAL ISSUES-----------------">>$log_report

grep CRITICAL "$log_file" -n>>$log_report
echo ""

echo "--------------Top 5 Error Messages-----------------">>$log_report

grep ERROR "$log_file" | awk '{print $4, $5, $6}' | sort | uniq -c | sort -nr | head -5>>$log_report
echo ""

if [ ! -d archive ]; then
        mkdir archive
fi

mv $log_report ./archive/$log_report

echo "Log report $log_report moved to ./archive/$log_report"
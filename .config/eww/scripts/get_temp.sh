#!/bin/bash
# Tries to find the first temperature sensor (usually CPU)
sensors | grep -m 1 "Package id 0" | awk '{print $4}' | tr -d '+°C' || \
sensors | grep -m 1 "Tctl" | awk '{print $2}' | tr -d '+°C' || \
echo "N/A"

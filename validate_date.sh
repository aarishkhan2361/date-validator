#!/bin/bash
# =============================================================================
# validate_date.sh — Validate dates in dd-mm-yyyy format
# Usage: ./validate_date.sh [date]
#        If no argument is given, the script prompts interactively.
# =============================================================================

# ---------- helpers ----------------------------------------------------------

usage() {
  echo "Usage: $0 [dd-mm-yyyy]"
  echo "  Validates whether the supplied date is a real calendar date."
  echo "  If no argument is given, you will be prompted to enter one."
}

is_leap_year() {
  local y=$1
  (( (y % 4 == 0 && y % 100 != 0) || (y % 400 == 0) ))
}

# ---------- input ------------------------------------------------------------

if [[ $1 == "-h" || $1 == "--help" ]]; then
  usage
  exit 0
fi

if [[ -n $1 ]]; then
  date_input="$1"
else
  echo "Enter date (dd-mm-yyyy):"
  read -r date_input
fi

# ---------- format check -----------------------------------------------------

if [[ ${#date_input} -ne 10 ]]; then
  echo "Invalid format: expected dd-mm-yyyy (got '${date_input}')"
  exit 1
fi

if [[ "${date_input:2:1}" != "-" || "${date_input:5:1}" != "-" ]]; then
  echo "Invalid format: separators must be '-' (got '${date_input}')"
  exit 1
fi

if [[ ! "$date_input" =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]; then
  echo "Invalid format: date parts must be numeric (got '${date_input}')"
  exit 1
fi

# ---------- parse ------------------------------------------------------------

day=$(( 10#${date_input:0:2} ))
month=$(( 10#${date_input:3:2} ))
year=$(( 10#${date_input:6:4} ))

# ---------- range checks -----------------------------------------------------

if (( month < 1 || month > 12 )); then
  echo "Invalid date: month ${month} is out of range (1–12)"
  exit 1
fi

if (( day < 1 )); then
  echo "Invalid date: day must be at least 1"
  exit 1
fi

if (( year < 1 )); then
  echo "Invalid date: year must be at least 1"
  exit 1
fi

# ---------- days-in-month check ----------------------------------------------

case $month in
  1|3|5|7|8|10|12) max_day=31 ;;
  4|6|9|11)        max_day=30 ;;
  2)
    if is_leap_year "$year"; then
      max_day=29
    else
      max_day=28
    fi
    ;;
esac

if (( day > max_day )); then
  echo "Invalid date: ${date_input} (month ${month} has at most ${max_day} days)"
  exit 1
fi

# ---------- success ----------------------------------------------------------

echo "Valid date: ${date_input}"
exit 0

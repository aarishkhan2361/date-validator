# Date Validator

A Bash script that validates calendar dates supplied in **dd-mm-yyyy** format.

## Features

- Accepts a date as a command-line argument **or** interactively via stdin
- Validates format (length, separators, numeric parts)
- Checks month range (1–12) and day range per month
- Handles leap years correctly (including the century rule)
- Meaningful exit codes: `0` = valid, `1` = invalid/error

## Usage

```bash
# Make executable (first time only)
chmod +x validate_date.sh

# Pass date as an argument
./validate_date.sh 29-02-2024   # → Valid date: 29-02-2024
./validate_date.sh 30-02-2024   # → Invalid date: …

# Interactive mode
./validate_date.sh
# Enter date (dd-mm-yyyy): 15-08-1947

# Help
./validate_date.sh --help
```

## Running Tests

```bash
chmod +x tests/run_tests.sh
bash tests/run_tests.sh
```

## Project Structure

```
date-validator/
├── validate_date.sh   # Main script
├── tests/
│   └── run_tests.sh   # Automated test suite
├── docs/
│   └── DESIGN.md      # Design notes
├── .gitignore
└── README.md
```

## Exit Codes

| Code | Meaning        |
|------|----------------|
| 0    | Valid date     |
| 1    | Invalid date or bad format |

## Examples

| Input        | Result  | Reason                    |
|--------------|---------|---------------------------|
| 29-02-2000   | Valid   | 2000 is a leap year       |
| 29-02-1900   | Invalid | 1900 is not a leap year   |
| 31-04-2023   | Invalid | April has only 30 days    |
| 15-13-2023   | Invalid | Month 13 does not exist   |
| 15/06/2023   | Invalid | Wrong separator           |

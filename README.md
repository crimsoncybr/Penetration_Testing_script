# Network Scanning and Vulnerability Assessment Script

## Overview
This script is designed for network scanning and vulnerability assessment on a Linux system.
It automates the process of scanning a specified network, identifying open ports, checking weak credentials,
and detecting vulnerabilities using `nmap` and `hydra`. The script provides options for the user to customize the scan 
parameters and view the scan results conveniently.

## Prerequisites
- This script must be run with root privileges.
- Ensure that the following tools are installed:
    - `nmap`
    - `hydra`
    - `zip`
- Provide the necessary password lists for weak credentials scanning.
- Ensure appropriate network access and permissions for scanning.

## Usage
- Run the script with root privileges (`sudo ./PT.sh`).
- Follow the on-screen instructions to:
    - Enter the network to scan.
    - Specify the output directory for saving scan results.
    - Choose the type of scan (basic or full).
    - Select a password list option (custom or default).
    - View scan logs and weak credentials findings.
    - Zip the scan results for easy sharing or storage.

## Functionality
### Network and Output Directory Selection
- Prompt the user to enter the network to scan and specify the output directory for saving scan results.

### Password List Selection (PSLT)
- Offer options for selecting a password list:
    - Custom password list: Allow the user to specify the path to a custom password list.
    - Default password list: Use a default password list (`password.lst`).

### Basic or Full Scan (BF)
- Provide options for selecting the type of scan:
    - Basic scan: Conduct a basic scan including TCP and UDP scans, weak credentials check, and view logs.
    - Full scan: Perform a comprehensive scan including vulnerability assessment, weak credentials check, and view logs.

### Scan Execution and Results
- Perform network scanning using `nmap` to identify open ports and vulnerabilities.
- Check for weak credentials using `hydra`.
- Display scan logs and weak credentials findings for user review.
- Zip the scan results for easy distribution or storage.

## Notes
- Running this script requires root privileges.
- Ensure that the required tools (`nmap`, `hydra`, `zip`) are installed on your system.
- Provide appropriate password lists for weak credentials scanning.
- Review and customize the script according to your specific requirements and environment.
- Use caution and ensure compliance with legal and ethical guidelines when conducting network scans and vulnerability assessments.


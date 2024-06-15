
```markdown
# Nmap Each IPs (NEIP)

## Overview
This Bash script is designed to automate network scanning using Nmap, a powerful network discovery and security auditing tool. It enables the execution of targeted scans across specified IP ranges within a network, utilizing different levels of stealth and thoroughness based on user input.

## Prerequisites
To use this script, you'll need:
- A Unix-like operating system (Linux, BSD, macOS with adjustments).
- Nmap installed on your system. You can install Nmap on Debian/Ubuntu-based systems using:
  ```bash
  sudo apt install nmap
  ```

## Usage
To run the script, use the following command syntax:
```bash
./nmap_scan.sh <IP base> <CIDR> [scan type]
```
### Parameters:
- **IP base**: The base IP address of your subnet (e.g., `192.168.1.0`).
- **CIDR**: The network mask indicating the size of the subnet (e.g., `24` for a standard `/24` subnet).
- **scan type** (optional): Specifies the type of scan to perform:
  - `1` for Hyper Sneaky Scan
  - `2` for Mostly Sneaky Scan
  - `3` for Standard Scan
  - `4` for Detectable Scan
  - `5` for More Detectable Scan without spoof MAC

If no scan type is specified, the script defaults to the most discreet option (Hyper Sneaky Scan).

### Examples
Run a Hyper Sneaky Scan on the subnet `192.168.1.0/24`:
```bash
./nmap_scan.sh 192.168.1.0 24 1
```
Run a Standard Scan on the subnet `10.0.0.0/16`:
```bash
./nmap_scan.sh 10.0.0.0 16 3
```


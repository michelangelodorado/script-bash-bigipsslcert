# script-bash-bigipsslcert

# F5 BIG-IP Certificate Retrieval Script

This Bash script allows you to retrieve certificate details from F5 BIG-IP devices and save the information in a CSV file. It also includes the Big-IP hostname in the output.

## Prerequisites

- Bash
- cURL
- jq

## Usage

1. **Clone the repository:**

   ```bash
   git clone https://github.com/your-username/your-repository.git
   cd your-repository
   ```
2. Create an inventory file (f5_inventory.txt) with the following format:
   ```bash
   <F5_IP> <F5_USER> <F5_PASS>
   <F5_IP> <F5_USER> <F5_PASS>
   # Add more F5 devices as needed
   ```
3. Make the script executable:
   ```bash
   chmod +x f5_certificate_script.sh
   ```
4. run the script
   ```bash
   ./getdevicecert.sh
   ```

## Output
The script generates a CSV file *(f5_certificates.csv)* with the following columns:

Big-IP Hostname
F5 Device
Certificate Name
Common Name
Expiration Date

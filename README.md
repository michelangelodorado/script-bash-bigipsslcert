# F5 BIG-IP Certificate Details using bash (REST API)

This Bash script allows you to retrieve certificate details from F5 BIG-IP devices and save the information in a CSV file.

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
2. Create an inventory file **(f5_inventory.txt)** with the following format:
   ```bash
   <F5_IP>
   <F5_IP>
   # Add more F5 devices as needed
   ```
3. Make the script executable:
   ```bash
   chmod +x f5_certificate_script.sh
   ```
4. Run the script and enter the credentials (assumptions is that credentials is the same for all BIG-IP devices in the inventory)
   ```bash
   ./getdevicecert.sh
   ```

## Output
The script generates a CSV file **(f5_certificates.csv)** with the following columns:

- Big-IP Hostname
- F5 Device
- Certificate Name
- Common Name
- Expiration Date

**Sample Table:**

|Big-IP Hostname|F5 Device                    |Certificate Name|Common Name                                  |Expiration Date         |
|---------------|-----------------------------|----------------|---------------------------------------------|------------------------|
|ip-10-1-1-5.us-west-2.compute.internal|10.1.1.5                     |/Common/ca-bundle.crt|Starfield Services Root Certificate Authority|Dec 31 23:59:59 2029 GMT|
|ip-10-1-1-5.us-west-2.compute.internal|10.1.1.5                     |/Common/default.crt|localhost.localdomain                        |Nov 24 14:18:00 2033 GMT|
|ip-10-1-1-5.us-west-2.compute.internal|10.1.1.5                     |/Common/f5-ca-bundle.crt|Entrust Root Certification Authority - G2    |Dec  7 17:55:54 2030 GMT|
|ip-10-1-1-5.us-west-2.compute.internal|10.1.1.5                     |/Common/f5-irule.crt|support.f5.com                               |Jul 18 21:00:13 2027 GMT|
|ip-10-1-1-5.us-west-2.compute.internal|10.1.1.5                     |/Common/f5test.com_self-signed_2016.crt|www.testcet.org                              |Nov 30 16:09:24 2023 GMT|
|ip-10-1-1-4.us-west-2.compute.internal|10.1.1.4                     |/Common/ca-bundle.crt|Starfield Services Root Certificate Authority|Dec 31 23:59:59 2029 GMT|
|ip-10-1-1-4.us-west-2.compute.internal|10.1.1.4                     |/Common/default.crt|localhost.localdomain                        |Nov 24 14:30:10 2033 GMT|
|ip-10-1-1-4.us-west-2.compute.internal|10.1.1.4                     |/Common/f5-ca-bundle.crt|Entrust Root Certification Authority - G2    |Dec  7 17:55:54 2030 GMT|
|ip-10-1-1-4.us-west-2.compute.internal|10.1.1.4                     |/Common/f5-irule.crt|support.f5.com                               |Jul 18 21:00:13 2027 GMT|
|ip-10-1-1-4.us-west-2.compute.internal|10.1.1.4                     |/Common/f5_api_com.crt|YLPYX-OEVJN-SJZVW-OQBHZ-RDXLXUM              |Aug 21 21:30:36 2024 GMT|

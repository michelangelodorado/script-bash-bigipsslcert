#!/bin/bash
INVENTORY_FILE="f5_inventory.txt"
OUTPUT_FILE="f5_certificates.csv"

if [ ! -f "$INVENTORY_FILE" ]; then
    echo "Inventory file '$INVENTORY_FILE' not found. Exiting."
    exit 1
fi

# Function to get certificate details for a given F5 device
get_certificate_details() {
    local F5_IP="$1"
    local F5_USER="$2"
    local F5_PASS="$3"

    # Construct the URL to retrieve certificate details
    CERT_URL="https://${F5_IP}/mgmt/tm/sys/crypto/cert"
    HOSTNAME_URL="https://${F5_IP}/mgmt/tm/sys/global-settings"

    # Make the API request to get certificate details using curl
    CERT_RESPONSE=$(curl -sku "${F5_USER}:${F5_PASS}" -X GET "${CERT_URL}" -H "Content-Type: application/json" -w "\n%{http_code}" --insecure)

    # Extract the HTTP status code from the response
    HTTP_STATUS_CERT=$(echo "${CERT_RESPONSE}" | tail -n 1)

    # Check if the request for certificate details was successful (HTTP status code 200)
    if [ "${HTTP_STATUS_CERT}" -eq 200 ]; then
        # Extract and process the certificate details
        CERTIFICATE_DETAILS=$(echo "${CERT_RESPONSE}" | sed '$d')  # Remove the last line containing the HTTP status code

        # Make the API request to get the Big-IP hostname using curl
        HOSTNAME_RESPONSE=$(curl -sku "${F5_USER}:${F5_PASS}" -X GET "${HOSTNAME_URL}" -H "Content-Type: application/json" --insecure)

        # Extract the Big-IP hostname
        BIGIP_HOSTNAME=$(echo "${HOSTNAME_RESPONSE}" | jq -r '.hostname')

        # Process the certificate details and append to the CSV file, including the Big-IP hostname
        echo "${CERTIFICATE_DETAILS}" | jq -r --arg BIGIP_HOSTNAME "${BIGIP_HOSTNAME}" --arg F5_IP "${F5_IP}" '.items[] | "\($BIGIP_HOSTNAME),\($F5_IP),\(.name),\(.commonName),\(.apiRawValues.expiration)"' >> "$OUTPUT_FILE"
    else
        echo "Error for ${F5_IP}: Certificate API - ${HTTP_STATUS_CERT} - ${CERT_RESPONSE}"
    fi
}

# Print CSV header to the file, prompting user if the file already exists
if [ -e "$OUTPUT_FILE" ]; then
    read -p "The output file '$OUTPUT_FILE' already exists. Do you want to overwrite it? (y/n): " overwrite
    if [ "$overwrite" != "y" ]; then
        echo "Exiting without overwriting the file."
        exit 0
    fi
fi

echo "Big-IP Hostname,F5 Device,Certificate Name,Common Name,Expiration Date" > "$OUTPUT_FILE"

# Iterate over each F5 device in the inventory file
while IFS=' ' read -r F5_IP F5_USER F5_PASS; do
    # Call the function to get certificate details for the current F5 device
    get_certificate_details "${F5_IP}" "${F5_USER}" "${F5_PASS}"
done < "$INVENTORY_FILE"

echo "Output saved to '$OUTPUT_FILE'"

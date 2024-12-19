   #!/bin/bash

   # API endpoint and query
   API_URL="https://search.censys.io/api/v2/aggregate"
   API_QUERY='{
     "query": "(parsed.extensions.extended_key_usage.code_signing=true) and labels=`ever-trusted`",
     "field": "parsed.extensions.crl_distribution_points",
     "num_buckets": 1000
   }'

   # API authentication (replace with your API ID and Secret)
   API_ID="Your-Censys-API-ID"
   API_SECRET="Your-Censys-API-Secret"

   # Make the API call and save the response
   RESPONSE=$(curl -s -X POST \
     -u "$API_ID:$API_SECRET" \
     -H "Content-Type: application/json" \
     -d "$API_QUERY" \
     "$API_URL")

   # Check if the API call was successful
   if [[ $? -ne 0 ]]; then
     echo "API call failed!"
     exit 1
   fi

   # Parse the response and extract CRL URLs and counts
   echo "$RESPONSE" | jq -r '.result.buckets[] | "\(.key) \(.count)"' > crl_urls_with_counts.txt
   echo "$RESPONSE" | jq -r '.result.buckets[].key' > crl_urls.txt

   echo "Extracted CRL URLs and counts to 'crl_urls_with_counts.txt'"
   echo "Extracted CRL URLs to 'crl_urls.txt'"
#!/bin/bash
set -e  # Exit immediately if a command fails

# 1. Check for required variables
if [[ -z "$OCI_USERNAME" || -z "$OCI_PASSWORD" || -z "$OCI_URI" ]]; then
    echo "❌ Error: Missing environment variables."
    echo "   Please set: OCI_USERNAME, OCI_PASSWORD, OCI_URI"
    exit 1
fi

# 2. Enable nullglob so the loop handles empty folders gracefully
shopt -s nullglob
files=(*.rpm)

if [ ${#files[@]} -eq 0 ]; then
    echo "⚠️  No .rpm files found in $(pwd)"
    exit 0
fi

# 3. Loop and Upload
echo "🚀 Found ${#files[@]} RPMs. Starting upload..."

for filename in "${files[@]}"; do
    echo -n "   Uploading $filename ... "
    
    curl --fail --silent --show-error \
         --user "$OCI_USERNAME:$OCI_PASSWORD" \
         --upload-file "$filename" \
         "https://$OCI_URI/api/packages/koa/rpm/rocky/el10/upload"
    
    echo "✅ OK"
done

echo "🎉 All uploads complete!"
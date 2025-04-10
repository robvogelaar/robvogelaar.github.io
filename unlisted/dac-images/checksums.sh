#!/bin/bash

# Calculate checksums and format output
for file in dac-image-*-v*-*.tar.gz; do
    # Extract component, version, and architecture
    component=$(echo "$file" | sed -E 's/dac-image-([a-z]+)-v([0-9]+\.[0-9]+)-([a-z0-9]+)\.tar\.gz/\1/')
    version=$(echo "$file" | sed -E 's/dac-image-([a-z]+)-v([0-9]+\.[0-9]+)-([a-z0-9]+)\.tar\.gz/\2/')
    arch=$(echo "$file" | sed -E 's/dac-image-([a-z]+)-v([0-9]+\.[0-9]+)-([a-z0-9]+)\.tar\.gz/\3/')
    
    # Convert to uppercase
    component=$(echo "$component" | tr '[:lower:]' '[:upper:]')
    arch=$(echo "$arch" | tr '[:lower:]' '[:upper:]')
    
    # Replace dots with underscores in version
    version=$(echo "$version" | tr '.' '_')
    
    # Calculate SHA256 sum
    sha256=$(sha256sum "$file" | cut -d' ' -f1)
    
    # Format and write to output file
    printf "%-35s = \"%s\"\n" "${component}_V${version}_${arch}_SHA256SUM" "$sha256"
done

echo "Checksums written to $OUTPUT"


#!/usr/bin/env zsh

# Check if pack.mcmeta exists
if [ ! -f pack.mcmeta ]; then
    echo "pack.mcmeta not found. Exiting..."
    exit 1
fi

# Check if pack.png exists
if [ ! -f pack.png ]; then
    echo "pack.png not found. Exiting..."
    exit 1
fi

# Check if assets/ exists
if [ ! -d assets/ ]; then
    echo "assets/ not found. Exiting..."
    exit 1
fi

# get text of version.txt
if [ ! -f version.txt ]; then
    echo "version.txt not found. Exiting..."
    exit 1
fi
version=$(cat version.txt)
output_path="release/More JourneyMap Waypoints v${version}.zip"

# Compress pack.meta, pack.png, and assets/ into ${output_path}
mkdir -p release
zip -r ${output_path} LICENSE pack.mcmeta pack.png assets/

# Verify the zip file was created
if [ ! -f ${output_path} ]; then
    echo "${output_path} was not created successfully. Exiting..."
    exit 1
fi

# Print success message
echo "${output_path} created successfully"

# Print the size of the zip file
echo "Size: $(du -sh ${output_path} | cut -f 1)"

# Print the MD5 hash of the zip file
echo "MD5: $(md5sum ${output_path} | cut -d ' ' -f 1)"

# Print the SHA1 hash of the zip file
echo "SHA1: $(sha1sum ${output_path} | cut -d ' ' -f 1)"

# Print the SHA256 hash of the zip file
echo "SHA256: $(sha256sum ${output_path} | cut -d ' ' -f 1)"

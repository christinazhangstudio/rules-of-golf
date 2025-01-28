#!/bin/bash

SOURCE_REPO="user/repo"
DEST_REPO="user/repo"
GITHUB_TOKEN="<GITHUB_TOKEN>"

# Fetch all releases from the source repo
releases=$(curl -H "Authorization: token $GITHUB_TOKEN" \
                -H "Accept: application/vnd.github+json" \
                https://api.github.com/repos/$SOURCE_REPO/releases?per_page=1000)

echo "Releases: $releases"

# Loop through each release
echo "$releases" | jq -c '.[]' | while read -r release; do
  tag_name=$(echo "$release" | jq -r '.tag_name')
  name=$(echo "$release" | jq -r '.name')
  body=$(echo "$release" | jq -r '.body')

  #echo $name

  # Create the release in the destination repo
  created_release=$(curl -X POST -H "Authorization: token $GITHUB_TOKEN" \
                          -H "Accept: application/vnd.github+json" \
                          -d "{
                                \"tag_name\": \"$tag_name\",
                                \"name\": \"$name\",
                                \"body\": \"$body\",
                                \"draft\": false,
                                \"prerelease\": false
                              }" \
                          https://api.github.com/repos/$DEST_REPO/releases)

  # Extract the upload URL for the release
  upload_url=$(echo "$created_release" | jq -r '.upload_url' | sed 's/{?name,label}//')

  # Download and re-upload assets
  echo "$release" | jq -c '.assets[]' | while read -r asset; do
    asset_url=$(echo "$asset" | jq -r '.browser_download_url')
    asset_name=$(echo "$asset" | jq -r '.name')

    # Download the asset
    curl -L -H "Authorization: token $GITHUB_TOKEN" -o "$asset_name" "$asset_url"

    # Upload the asset to the destination release
   curl -X POST -H "Authorization: token $GITHUB_TOKEN" \
         -H "Content-Type: application/octet-stream" \
         --data-binary @"$asset_name" \
         "$upload_url?name=$asset_name"
  done
done

#!/bin/bash

function errecho() {
        printf "%s\n" "$*" 1>&2
}

function copy_file_to_bucket() {

        echo "num of args given (expecting bucket, source file, destination file): $#"

        local response bucket_name source_file destination_file_name
        bucket_name=$1                  # bucket-name-env
        source_file=$2                  # ./XXX.png
        destination_file_name=$3        # bucket-name-env/prefix/XXX.png

        echo -e "posting \e[34m$2\e[0m to \e[32m'$bucket_name\e[0m as \e[33m$destination_file_name\e[0m..."

        response=$(aws s3api put-object \
                --endpoint-url="https://XXX.com" \
                --bucket "$bucket_name" \
                --body "$source_file" \
                --key "$destination_file_name")

        if [[ ${?} -ne 0 ]]; then
                errecho "ERROR: AWS reports put-object operation failed.\n$response"
                return 1
        fi

        echo "AWS put-object operation succeeded.\n$response"
        return 0
}

copy_file_to_bucket "$1" "$2" "$3"

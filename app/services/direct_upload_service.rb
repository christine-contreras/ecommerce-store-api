def call 
    blob = create_blob 

    response = signed_url(blob)

    response[:blob_signed_url] = blob.signed_url 
    response
end


def signed_url(blob)
    response_signature(
        blob.service_url_for_direct_upload(expires_in: 30.minutes),
        headers: blob.service_headers_for_direct_upload,
        signed_id: blob.signed_id
    )
end


# def create_blob
#     @blob = ActiveStorage::Blob.create_before_direct_upload!(
#       filename: blob_params[:filename],
#       byte_size: blob_params[:byte_size],
#       checksum: blob_params[:checksum],
#       content_type: blob_params[:content_type]
#     )
#   end
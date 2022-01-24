class Api::DirectUploadController < ApplicationController
    # skip_before_action :authorize

    def create 
        image = params[:image_name]
        bucket = S3_BUCKET
        object = bucket.object(image)

        if object.exists? 
            url = nil
        else #object already exists in bucket
            url = bucket.object(image).presigned_url(:put)
        end

        render json: { url: url}
    end

end
class Api::DirectUploadController < ApplicationController
    # skip_before_action :authorize

    def create 
        image = params[:image]
        bucket = S3_BUCKET
        object = bucket.object(image.original_filename)

        if object.exists? 
            url = nil
        else #object already exists in bucket
            url = bucket.object(image.original_filename).presigned_url(:put)
        end
        
        render json: { url: url}
    end


    private 

    def blob_params
        params.permit(:image)
    end

end
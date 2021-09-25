class RoutesController < ApplicationController
  def index
    file = params[:file]
    config = {
      key: "kamilroutess.txt",
      bucket: "routes"
    }
    $s3.put_object(
      key: config[:key],
      body: file.tempfile.read,
      bucket: config[:bucket],
      content_type: "text/plain"
    )
    object = $s3.get_object(bucket: config[:bucket], key: config[:key])
    object.body.read
    render json: "succesful".to_json
  end
end

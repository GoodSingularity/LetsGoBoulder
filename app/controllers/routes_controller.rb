require "securerandom"
class RoutesController < ApplicationController

  def index
    params[:filtering] = eval(params[:filtering])
    color ||= params[:filtering][:color] 
    route_setter ||= params[:filtering][:route_setter]
    routes = Route.all

    if(color != nil)
      routes = Route.all.where(color: color)
    end

    if(route_setter != nil)
        routes = routes.where(route_setter: route_setter)
    end
    render json: routes
  end

  def search
    search = eval(params[:filtering])[:search]
    if %w(black blue green orange yellow white).include? search.downcase
      search = return_color_id(search)
    end
    route = Route.search(search)
    render json: route
  end

  def add
    name = SecureRandom.uuid
    color = params[:color]
    route_setter = params[:route_setter]
    file = params[:file]
    config = {
      key: SecureRandom.uuid,
      bucket: "routes"
    }
    $s3.put_object(
      key: config[:key],
      body: file.tempfile.read,
      bucket: config[:bucket]
    )
    object = $s3.get_object(bucket: config[:bucket], key: config[:key]).body.read
    route = Route.create(name: name, color: color, route_setter: route_setter, files: [config[:key]])
    render json: {message: "Boulder has been added", object: route.to_json}
  end

  private

  def return_color_id(name)
    levels = Hash[
      "black": 0, 
      "blue": 1, 
      "green": 2, 
      "orange": 3, 
      "yellow": 4, 
      "white": 5
    ].with_indifferent_access

    levels[name]
  end

end

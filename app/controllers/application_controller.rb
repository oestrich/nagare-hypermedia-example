class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  class AdapterMissingError < StandardError
  end

  rescue_from AdapterMissingError do
    head 415
  end

  private

  def nagare_adapter
    case request.headers["Accept"]
    when "application/hal+json"
      Nagare::Adapters::Hal
    when "application/vnd.collection+json"
      Nagare::Adapters::CollectionJson
    else
      raise AdapterMissingError
    end
  end

  def nagare_context
    Nagare::Context.new({
      routes_bridge: RoutesBridge.new,
    })
  end
end

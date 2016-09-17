class RoutesBridge
  include Rails.application.routes.url_helpers
  delegate :default_url_options, :to => "ActionController::Base"
end

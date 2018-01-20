class ApplicationController < ActionController::API
  def snake_params
    @snake_params ||= params.transform_keys(&:underscore)
  end
end

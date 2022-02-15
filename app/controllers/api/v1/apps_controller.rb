class Api::V1::AppsController < ApiController
  attr_reader :apps
  before_action :authenticated_user?

  def index
    @apps = App.all
    p @apps
  end
end

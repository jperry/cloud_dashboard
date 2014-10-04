class InstancesController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized, :except => :index

  # GET /instances
  # GET /instances.json
  def index
    @instances = Instance.new.all
  end
end

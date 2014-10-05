class InstancesController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized, :except => :index

  # GET /instances
  # GET /instances.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: InstancesDatatable.new(view_context) }
    end
  end
end

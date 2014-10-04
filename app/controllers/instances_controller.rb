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

  class InstancesDatatable
    delegate :params, to: :@view

    def initialize(view)
      @view = view
    end

    def as_json(options = {})
      {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: all_instances.size,
        iTotalDisplayRecords: all_instances.size,
        aaData: data
      }
    end

    private

    def data
      instances.map do |instance|
        [
          instance[:name],
          instance[:id],
          instance[:type],
          instance[:state],
          instance[:availability_zone],
          instance[:public_ip],
          instance[:private_ip]
        ]
      end
    end

    def instances
      @instances ||= fetch_instances
    end

    def all_instances
      @all_instances ||= Instance.new.all
    end

    def fetch_instances
      instances = @all_instances.sort_by { |i| i[sort_column] }
      instances.reverse! if sort_direction == 'desc'
      instances = instances.paginate(page: page, per_page: per_page)
      instances
    end

    def page
      params[:iDisplayStart].to_i/per_page + 1
    end

    def per_page
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    end

    def sort_column
      columns = %i[name id type state availability_zone public_ip private_ip]
      columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:sSortDir_0] == "desc" ? "desc" : "asc"
    end
  end
end

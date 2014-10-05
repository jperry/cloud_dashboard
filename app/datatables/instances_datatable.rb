class InstancesDatatable
  delegate :params, to: :@view

  attr_reader :view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: all_instances.size,
      iTotalDisplayRecords: filtered_results.size,
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

  def filtered_results
    @filtered_results ||= begin
      if params[:sSearch].present?
        all_instances.find_all do |i|
          i.values.detect { |v| /#{params[:sSearch]}/.match(v) }
        end
      else
        all_instances
      end
    end
  end

  def fetch_instances
    instances = filtered_results
    instances = case sort_column
                when :public_ip, :private_ip
                  instances.sort_by { |i| i[sort_column].split(".").map(&:to_i) }
                else
                  instances.sort_by { |i| i[sort_column] }
                end
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

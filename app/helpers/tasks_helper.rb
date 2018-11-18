module TasksHelper
  def sortable(column)
    return search_options.merge(column => 'desc') if params[column].blank?
    sort_options = case params[column].to_s
                   when 'asc' then { column => 'desc' }
                   when 'desc' then { column => 'asc' }
                   else { column => 'desc' }
                   end
    search_options.merge(sort_options)
  end

  def search_options
    params.permit(:title, :search_state, :page)
  end
end

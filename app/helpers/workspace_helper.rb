module WorkspaceHelper

  def resolved_message_flow_count
    count = 0
    @selected_message_hash['message_flows'].each do |mf|
      count += 1 unless mf['date_resolved'].nil?
    end
    count
  end

end

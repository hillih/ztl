module Permission
  ALL = (
    %w(
      outfit_element_types:new
      outfit_element_types:edit
      outfit_element_types:destroy
      choreographies:edit_settings
    ) + (
      %w(users roles outfit_categories outfit_elements events choreographies).each_with_object([]) do |controller_name, a|
        %w(show new edit destroy).each do |action|
          a.push "#{controller_name}:#{action}"
        end
      end
    )
  ).freeze
end

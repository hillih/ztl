module Permission
  ALL = (
    %w(
      outfit_element_types:new
      outfit_element_types:edit
      outfit_element_types:destroy
    ) + (
      %w(users roles outfit_categories outfit_elements).each_with_object([]) do |controller_name, a|
        %w(show new edit destroy).each do |action|
          a.push "#{controller_name}:#{action}"
        end
      end
    )
  ).freeze
end

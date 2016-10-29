module Permission
  ALL = (
    %w(
    ) + (
      %w(users roles).each_with_object([]) do |controller_name, a|
        %w(show new edit destroy).each do |action|
          a.push "#{controller_name}:#{action}"
        end
      end
    )
  ).freeze
end

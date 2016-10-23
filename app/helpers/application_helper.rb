module ApplicationHelper
  def menu_item(li_class, path, name, icon)
    content_tag(:li, class: li_class) do
      link_to path do
        content_tag(:i, nil, class: "fa fa-#{icon}") +
          name
      end
    end
  end
end

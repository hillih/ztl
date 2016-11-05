module ApplicationHelper
  def menu_item(li_class, path, name, icon)
    content_tag(:li, class: li_class) do
      link_to path do
        content_tag(:i, nil, class: "fa fa-#{icon}") +
          name
      end
    end
  end

  def menu_item_is_active?(item)
    controller_name == item ? 'active' : nil
  end

  def dl_item(record, field)
    dl_term(record, field) << dl_value(record, field)
  end

  def dl_term(record, field)
    content_tag(:dt, record.class.human_attribute_name(field))
  end

  def dl_value(record, field)
    content_tag(:dd, value_parser(record, field))
  end

  def value_parser(record, field)
    value = record.send(field)
    case value
    when TrueClass
      t('boolean.true')
    when FalseClass
      t('boolean.false')
    else
      value
    end
  end
end

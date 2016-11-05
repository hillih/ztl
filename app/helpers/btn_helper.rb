module BtnHelper
  def btn_show(link, size = 'xs', additional_classes = nil)
    link_to link, class: "btn btn-default btn-#{size} #{additional_classes}" do
      content_tag(:i, nil, class: 'fa fa-eye') +
        t('actions.show')
    end
  end

  def btn_edit(link, size = 'xs', additional_classes = nil)
    link_to link, class: "btn btn-warning btn-#{size} #{additional_classes}" do
      content_tag(:i, nil, class: 'fa fa-pencil') +
        t('actions.edit')
    end
  end

  def btn_destroy(link, size = 'xs', additional_classes = nil)
    link_to link, class: "btn btn-danger btn-#{size} #{additional_classes}", method: :delete, data: { confirm: t('notices.are_you_sure') } do
      content_tag(:i, nil, class: 'fa fa-trash') +
        t('actions.destroy')
    end
  end

  def btn_add(link, size = 'xs', additional_classes = nil, label = nil)
    link_to link, class: "btn btn-success btn-#{size} #{additional_classes}" do
      content_tag(:i, nil, class: 'fa fa-plus') +
        (label.nil? ? t('actions.add') : label)
    end
  end

  def btn_cancel(link, size = 'xs', additional_classes = nil)
    link_to link, class: "btn btn-default btn-#{size} #{additional_classes}" do
      content_tag(:i, nil, class: 'fa fa-close') +
        t('actions.cancel')
    end
  end

  def btn_return(link, size = 'xs', additional_classes = nil)
    link_to link, class: "btn btn-dark btn-#{size} #{additional_classes}" do
      content_tag(:i, nil, class: 'fa fa-reply') +
        t('actions.return')
    end
  end
end

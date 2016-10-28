module Cropper
  extend ActiveSupport::Concern

  CROPPER_ATTRIBUTES = %i(
    crop_x
    crop_y
    crop_w
    crop_h
  ).freeze

  included do
    CROPPER_ATTRIBUTES.each do |attribute|
      attr_accessor attribute
    end
  end

  def crop_image!(version)
    avatar.recreate_versions!(version.to_sym)
  end

  def crop?
    crop_x && crop_y && crop_w && crop_h
  end
end

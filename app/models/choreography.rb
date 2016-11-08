class Choreography < ApplicationRecord
  belongs_to :event
  belongs_to :outfit_category
  has_many :choreography_settings, -> { ordered }, dependent: :destroy

  accepts_nested_attributes_for :choreography_settings

  after_create :build_settings, unless: :artificial

  private

  def build_settings
    OutfitElementType.ids.each do |oet_id|
      choreography_settings.create(outfit_element_type_id: oet_id)
    end
  end
end

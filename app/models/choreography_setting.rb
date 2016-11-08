class ChoreographySetting < ApplicationRecord
  belongs_to :choreography
  belongs_to :outfit_element_type
  belongs_to :outfit_category

  after_create :set_outfit_category

  scope :ordered, -> {
    joins(:outfit_element_type).merge(OutfitElementType.ordered)
  }

  validates :outfit_category, inclusion: { in: proc { |cs| cs.available_categories }, allow_nil: true }

  def available_categories
    a = []
    choreography.outfit_category.descendents.each do |k, v|
      a.push(find_category(k, v))
    end
    a += OutfitCategory.where(last_category: true, re_hire: true, outfit_element_type_id: outfit_element_type_id).to_a
    a.delete_if(&:blank?)
  end

  private

  def find_category(k, v)
    return k if k.outfit_element_type_id == outfit_element_type_id
    v.each do |v, k|
      find_category k, v
    end
    nil
  end

  def set_outfit_category
    update(outfit_category_id: available_categories.first.try(:id))
  end
end

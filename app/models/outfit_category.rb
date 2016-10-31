class OutfitCategory < ApplicationRecord
  acts_as_sane_tree dependent: :restrict_with_exception

  belongs_to :outfit_element_type
  has_many :outfit_elements, dependent: :restrict_with_exception

  before_save :upcase_symbol
  before_save :set_full_symbol
  before_save :cleanup_fields, unless: :last_category

  scope :first_level, -> { where(parent_id: nil) }
  scope :ordered, -> { order('LENGTH(full_symbol) ASC') }
  scope :last_category, -> { where(last_category: true) }

  validates :name, presence: true
  validates :symbol, presence: true, length: { is: 2 }
  validates :outfit_element_type, presence: true, if: :last_category

  def to_s
    name
  end

  def name_with_full_symbol
    "#{name} (#{full_symbol})"
  end

  private

  def upcase_symbol
    self.symbol = symbol.upcase
  end

  def set_full_symbol
    self.full_symbol = parent ? "#{parent.full_symbol}-#{symbol}" : symbol
  end

  def cleanup_fields
    self.re_hire = false
    self.outfit_element_type_id = nil
  end
end

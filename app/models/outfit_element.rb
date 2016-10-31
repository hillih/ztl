class OutfitElement < ApplicationRecord
  belongs_to :outfit_category

  before_save :upcase_symbol
  before_save :set_full_symbol

  validates :symbol, presence: true, length: { is: 2 }
  validates :awf_code, presence: true

  private

  def upcase_symbol
    self.symbol = symbol.upcase
  end

  def set_full_symbol
    self.full_symbol = "#{outfit_category.full_symbol}-#{symbol}"
  end
end

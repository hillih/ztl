class OutfitElementType < ApplicationRecord
  enum sex: {
    female: 0,
    male: 1
  }

  has_many :outfit_categories, dependent: :restrict_with_exception

  scope :ordered, -> { order(:sex, :position) }

  before_save :upcase_name_symbol

  validates :name, presence: true
  validates :symbol, presence: true, length: { is: 2 }
  validates :sex, presence: true
  validates :position, presence: true

  def to_s
    name
  end

  def i18n_sex
    I18n.t("users.#{sex}")
  end

  private

  def upcase_name_symbol
    self.name = name.capitalize
    self.symbol = symbol.upcase
  end

  def self.i18n_collection_sex
    sexes.keys.map { |type| [I18n.t("users.#{type}"), type] }
  end
end

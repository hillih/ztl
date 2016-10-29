class Role < ApplicationRecord
  has_many :users, dependent: :restrict_with_exception

  scope :available_for, -> (user) {
    where.not(symbol: 'sa') unless user.is_sa?
  }

  validates :name, presence: true
  validates :symbol, presence: true, length: { is: 2 }
  validates :permissions, presence: true

  def to_s
    name
  end

  def map_to_i18n
    h = {}
    permissions.group_by { |ability| ability.split(':').first }.each do |k, v|
      h[I18n.t("roles.section.#{k}")] = []
      v.each do |permission|
        h[I18n.t("roles.section.#{k}")].push(
          I18n.t("roles.action.#{permission.split(':').last}")
        )
      end
    end
    h
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable,
         :recoverable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader
  include Cropper

  enum sex: {
    female: 0,
    male: 1
  }

  before_save :upcase_name

  scope :ordered, -> { order(:last_name, :first_name) }

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :sex, presence: true

  def name
    "#{last_name} #{first_name}"
  end

  private

  def upcase_name
    self.first_name = first_name.capitalize
    self.last_name = last_name.upcase
  end

  def i18n_sex
    I18n.t("users.#{sex}")
  end

  def self.i18n_collection_sex
    sexes.keys.map { |type| [I18n.t("users.#{type}"), type] }
  end
end

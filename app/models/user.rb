class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable,
         :recoverable, :trackable, :validatable

  before_save :upcase_name

  scope :ordered, -> { order(:last_name, :first_name) }

  validates :last_name, presence: true
  validates :first_name, presence: true

  def name
    "#{last_name} #{first_name}"
  end

  private

  def upcase_name
    self.first_name = first_name.capitalize
    self.last_name = last_name.upcase
  end
end

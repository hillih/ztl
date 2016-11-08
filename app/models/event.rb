class Event < ApplicationRecord
  has_many :choreographies, dependent: :destroy

  after_create :create_artificial_choreography, unless: :division

  scope :ordered, -> { order(:start_at) }

  validates :name, presence: true
  with_options on: :create do
    validates :start_at, presence: true, date: { after_or_equal_to: proc { Time.zone.today } }
    validates :end_at, date: { after: :start_at, allow_blank: true }
  end

  private

  def create_artificial_choreography
    choreographies.create(artificial: true)
  end
end

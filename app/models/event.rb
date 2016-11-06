class Event < ApplicationRecord
  scope :ordered, -> { order(:start_at) }

  validates :name, presence: true
  with_options on: :create do
    validates :start_at, presence: true, date: { after_or_equal_to: proc { Date.current } }
    validates :end_at, date: { after: :start_at, allow_blank: true }
  end
end

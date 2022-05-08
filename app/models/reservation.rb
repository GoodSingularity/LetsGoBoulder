class Reservation < ApplicationRecord
  validates :user_id, presence: true
  validates :gym_id, presence: true
  validates :starts_at, presence: true
end

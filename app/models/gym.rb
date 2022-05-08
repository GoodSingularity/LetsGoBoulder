class Gym < ApplicationRecord
  validates :volume, presence: true, numericality: { only_integer: true }
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end

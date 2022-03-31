class Gym < ApplicationRecord
  validates :volume, presence: true
  validates :name, presence: true
end

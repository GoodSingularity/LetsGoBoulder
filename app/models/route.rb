class Route < ApplicationRecord
    validates :name, presence: true, uniqueness: { case_sensitive: false }
    validates :color, presence: true, numericality: { only_integer: true }
    validates :route_setter, presence: true
end

class Route < ApplicationRecord
  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :color, presence: true, numericality: {only_integer: true}
  validates :route_setter, presence: true
  include PgSearch::Model
  pg_search_scope :search, against: [:color, :name, :route_setter]

  scope :filter_by_route_setter, -> {
    order(arel_table['route_setter'].lower.desc)
  }

  scope :filter_by_color, -> {
    order(arel_table['route_setter'].lower.desc)
  }
end

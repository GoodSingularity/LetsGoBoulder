class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  include PgSearch::Model
  pg_search_scope :search, against: [:email, :name]
end

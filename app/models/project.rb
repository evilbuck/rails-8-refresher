class Project < ApplicationRecord
  has_many :todos

  validates :title, presence: true
end

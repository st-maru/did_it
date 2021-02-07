class Task < ApplicationRecord
  validates :name, presence: true

  has_many :completions
  belongs_to :user
end

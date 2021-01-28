class Category < ApplicationRecord
  validates :name, presence: true

  belongs_to :user
  belongs_to :task
  has_many :completions
end

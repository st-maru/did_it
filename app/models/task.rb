class Task < ApplicationRecord
  validates :name, presence: true

  has_many :completions, dependent: :destroy
  belongs_to :user
end

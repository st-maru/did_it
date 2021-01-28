class Completion < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :thanks, through: completion_thank_relations
end

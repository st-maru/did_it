class Completion < ApplicationRecord
  belongs_to :user
  belongs_to :task
  has_many :completion_thank_relations
  has_many :thanks, through: :completion_thank_relations
end

class Completion < ApplicationRecord
  belongs_to :user
  belongs_to :task
  has_many :completion_thank_relations, dependent: :destroy
  has_many :thanks, through: :completion_thank_relations, dependent: :destroy
  has_many :completion_tag_relations, dependent: :destroy
  has_many :tags, through: :completion_tag_relations, dependent: :destroy
end

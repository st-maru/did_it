class Tag < ApplicationRecord
  validates :name, uniqueness: true

  has_many :completion_tag_relations
  has_many :completions, through: :completion_tag_relations
end

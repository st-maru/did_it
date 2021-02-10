class Tag < ApplicationRecord
  validates :name, uniqueness: true

  has_many :completion_tag_relations, dependent: :destroy
  has_many :completions, through: :completion_tag_relations
end

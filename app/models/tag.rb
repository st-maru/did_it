class Tag < ApplicationRecord
  validates :name, uniqueness: { scope: :user }

  has_many :completion_tag_relations, dependent: :destroy
  has_many :completions, through: :completion_tag_relations
  belongs_to :user
end

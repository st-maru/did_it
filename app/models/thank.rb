class Thank < ApplicationRecord
  validates :human, uniqueness: { scope: :user }

  has_many :completion_thank_relations
  has_many :completions, through: :completion_thank_relations
  belongs_to :user
end

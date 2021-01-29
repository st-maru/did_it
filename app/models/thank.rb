class Thank < ApplicationRecord
  has_many :completion_thank_relations
  has_many :completions, through: :completion_thank_relations
end

class CompletionTagRelation < ApplicationRecord
  belongs_to :completion
  belongs_to :tag
end

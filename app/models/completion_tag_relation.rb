class CompletionTagRelation < ApplicationRecord
  belongs_to :completion
  belongs_to :tag, dependent: :destroy
end

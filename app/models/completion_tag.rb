class CompletionTag

  include ActiveModel::Model
  attr_accessor :summary, :memo, :working_day, :start_time, :ending_time, :user_id, :task_id, :name

  with_options presence: true do
    validates :summary
    validates :name
    validates :working_day
    validates :start_time
    validates :ending_time
  end

  def save
    completion = Completion.create(summary: summary, memo: memo, working_day: working_day, start_time: start_time, ending_time: ending_time, user_id: user_id, task_id: task_id)
    tag = Tag.where(name: name).first_or_initialize
    tag.save

    CompletionTagRelation.create(completion_id: completion.id, tag_id: tag.id)
  end

end
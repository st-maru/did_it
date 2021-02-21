class CompletionTagThank
  include ActiveModel::Model
  attr_accessor :summary, :memo, :working_day, :start_time, :ending_time, :user_id, :task_id, :name, :human, :thank_id

  with_options presence: true do
    validates :summary
    validates :name
    validates :human
    validates :working_day
    validates :start_time
    validates :ending_time
  end

  delegate :persisted?, to: :completion

  def initialize(attributes = nil, completion: Completion.new)
    @completion = completion
    attributes ||= default_attributes
    super(attributes)
  end

  def save
    return if invalid?

    ActiveRecord::Base.transaction do
      tags = split_name.map { |name| Tag.find_or_create_by!(name: name, user_id: user_id) }
      thanks = split_human.map { |human| Thank.find_or_create_by!(human: human, user_id: user_id) }
      completion.update!(summary: summary, memo: memo, working_day: working_day, start_time: start_time,
                         ending_time: ending_time, user_id: user_id, task_id: task_id, tags: tags, thanks: thanks)
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def to_model
    completion
  end

  private

  attr_reader :completion

  def default_attributes
    {
      summary: completion.summary,
      memo: completion.memo,
      working_day: completion.working_day,
      start_time: completion.start_time,
      ending_time: completion.ending_time,
      name: completion.tags.pluck(:name).join(','),
      human: completion.thanks.pluck(:human).join(',')
    }
  end

  def split_name
    name.split(',')
  end

  def split_human
    human.split(',')
  end
end

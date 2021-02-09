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

  def save(tag_list, thank_list)
    return if invalid?

    ActiveRecord::Base.transaction do
      completion.update!(summary: summary, memo: memo, working_day: working_day, start_time: start_time, ending_time: ending_time, user_id: user_id, task_id: task_id)
      @completion.tags.each do |tag|
        tag.destroy
      end

      @completion.thanks.each do |thank|
        thank.destroy
      end
      
      tag_list.each do |tag_name|
         tag = Tag.where(name: tag_name).first_or_initialize
         tag.save
      
         completion_tag = CompletionTagRelation.where(completion_id: @completion.id, tag_id: tag.id).first_or_initialize
         completion_tag.update!(completion_id: @completion.id, tag_id: tag.id)
      end

      thank_list.each do |thank_human|
        thank = Thank.where(human: thank_human, user_id: user_id).first_or_initialize
        thank.save
     
        completion_thank = CompletionThankRelation.where(completion_id: @completion.id, thank_id: thank.id).first_or_initialize
        completion_thank.update!(completion_id: @completion.id, thank_id: thank.id)
     end


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
  
end
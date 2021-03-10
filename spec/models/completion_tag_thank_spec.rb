require 'rails_helper'

RSpec.describe CompletionTagThank, type: :model do
  before do
    @completion_tag_thank = FactoryBot.build(:completion_tag_thank)
  end

  describe 'dekita!の保存' do
    context "dekita!が保存できる場合" do
      it "取り組んだこととタグと支えになった人とメモと日付と開始時刻と終了時刻があればdekita!は保存される" do
        expect(@completion_tag_thank).to be_valid
      end
      it "メモがなくてもdekita!は保存される" do
        @completion_tag_thank.memo = ''
        expect(@completion_tag_thank).to be_valid
      end
    end
    context "dekita!が保存できない場合" do
      it "取り組んだことがないとdekita!は保存できない" do
        @completion_tag_thank.summary = ''
        @completion_tag_thank.valid?
        expect(@completion_tag_thank.errors.full_messages).to include("Summaryを入力してください")
      end
      it "タグがないとdekita!は保存できない" do
        @completion_tag_thank.name = ''
        @completion_tag_thank.valid?
        expect(@completion_tag_thank.errors.full_messages).to include("Nameを入力してください")
      end
      it "支えになった人がないとdekita!は保存できない" do
        @completion_tag_thank.human = ''
        @completion_tag_thank.valid?
        expect(@completion_tag_thank.errors.full_messages).to include("Humanを入力してください")
      end
      it "日付がないとdekita!は保存できない" do
        @completion_tag_thank.working_day = ''
        @completion_tag_thank.valid?
        expect(@completion_tag_thank.errors.full_messages).to include("Working dayを入力してください")
      end
      it "開始時刻がないとdekita!は保存できない" do
        @completion_tag_thank.start_time = ''
        @completion_tag_thank.valid?
        expect(@completion_tag_thank.errors.full_messages).to include("Start timeを入力してください")
      end
      it "終了時刻がないとdekita!は保存できない" do
        @completion_tag_thank.ending_time = ''
        @completion_tag_thank.valid?
        expect(@completion_tag_thank.errors.full_messages).to include("Ending timeを入力してください")
      end
    end
  end
end

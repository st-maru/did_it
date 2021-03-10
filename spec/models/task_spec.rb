require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    @task = FactoryBot.build(:task)
  end

  describe 'タスクの保存' do
    context "タスクが保存できる場合" do
      it "タスク名と目標があればタスクは保存される" do
        expect(@task).to be_valid
      end
      it "タスク名のみあればタスクは保存される" do
        @task.goal = ''
        expect(@task).to be_valid
      end
    end
    context "タスクが保存できない場合" do
      it "タスク名がないとタスクは保存できない" do
        @task.name = ''
        @task.valid?
        expect(@task.errors.full_messages).to include("Nameを入力してください")
      end     
      it "ユーザーが紐付いていないとタスクは保存できない" do
        @task.user = nil
        @task.valid?
        expect(@task.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end

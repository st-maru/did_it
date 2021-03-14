require 'rails_helper'

RSpec.describe 'dekita!投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @task1 = FactoryBot.create(:task)
    @completion_summary = Faker::Lorem.sentence
    @completion_name = Faker::Lorem.sentence
    @completion_human = Faker::Lorem.sentence
    @completion_memo = Faker::Lorem.sentence
    @completion_working_day = Faker::Date.between(from: 2.days.ago, to: Date.today)
    @completion_start_time = Faker::Time.between(from: DateTime.now - 2, to: DateTime.now)
    @completion_ending_time = Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
  end
  context 'dekita!投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @task1.user.email
      fill_in 'パスワード', with: @task1.user.password
      find('input[name="commit"]').click
      #マイページに移動する
      visit tasks_path
      # タスク1ページに移動する
      click_on @task1.name
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('dekita!を追加する')
      # 新規投稿ページへ移動する
      click_on 'dekita!を追加する'
      # フォームに情報を入力する
      fill_in '取り組んだこと', with: @completion_summary
      fill_in 'タグ', with: @completion_name
      fill_in '支えになった人', with: @completion_human
      fill_in 'メモ', with: @completion_memo
      fill_in '日付', with: @completion_working_day
      fill_in '開始時刻', with: @completion_start_time
      fill_in '終了時刻', with: @completion_ending_time
      # 送信するとCompletionモデルのカウントが1上がることを確認する
      expect{ 
        find('input[value="作成する"]').click 
      }.to change { Completion.count }.by(1)
      # タスクページに遷移することを確認する
      expect(current_path).to eq(task_completions_path(@task1))
      # マイページには先ほど投稿した内容のタスクが存在することを確認する
      expect(page).to have_content(@completion_summary)
      expect(page).to have_content(@completion_name)
      expect(page).to have_content(@completion_human)
      expect(page).to have_content(@completion_memo)
      expect(page).to have_content(@completion_working_day)
      expect(page).to have_content(@completion_start_time.hour)
      expect(page).to have_content(@completion_start_time.min)
      expect(page).to have_content(@completion_ending_time.hour)
      expect(page).to have_content(@completion_ending_time.min)
    end
  end
  context 'dekita!投稿ができないとき'do
    it 'ログインしていないとdekita!作成ページに遷移できない' do
      # トップページにいる
      visit root_path
      # タスクページへ移動する
      visit task_completions_path(@task1)
      # ログイン画面へ移動させられる
      expect(current_path).to eq(new_user_session_path)
    end
  end
end


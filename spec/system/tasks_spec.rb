require 'rails_helper'

RSpec.describe 'タスク投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @task_name = Faker::Lorem.sentence
    @task_goal = Faker::Lorem.sentence
  end
  context 'タスク投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('タスク作成')
      # 投稿ページに移動する
      visit new_task_path
      # フォームに情報を入力する
      fill_in 'タスク名', with: @task_name
      fill_in '目標', with: @task_goal
      # 送信するとTaskモデルのカウントが1上がることを確認する
      expect{ 
        find('input[value="作成する"]').click 
      }.to change { Task.count }.by(1)
      # マイページに遷移することを確認する
      expect(current_path).to eq(tasks_path)
      # マイページには先ほど投稿した内容のタスクが存在することを確認する
      expect(page).to have_content(@task_name)
      expect(page).to have_content(@task_goal)
    end
  end
  context 'タスク投稿ができないとき'do
    it 'ログインしていないとタスク作成ページに遷移できない' do
    # トップページに遷移する
    visit root_path
    # 新規投稿ページへのリンクがない
    expect(page).to have_no_content('タスク作成')
    end
  end
end


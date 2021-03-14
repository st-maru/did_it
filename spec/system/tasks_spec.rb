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

RSpec.describe 'タスク編集', type: :system do
  before do
    @task1 = FactoryBot.create(:task)
    @task2 = FactoryBot.create(:task)
  end
  context 'タスク編集ができるとき' do
    it 'ログインしたユーザーは自分が作成したタスクの編集ができる' do
      # タスク1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @task1.user.email
      fill_in 'パスワード', with: @task1.user.password
      find('input[name="commit"]').click
      # タスクページに移動する
      click_on @task1.name
      # タスク1に「編集」ボタンがあることを確認する
      expect(page).to have_link href: edit_task_path(@task1)
      # 編集ページへ遷移する
      visit edit_task_path(@task1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#task_name').value
      ).to eq(@task1.name)
      expect(
        find('#task_goal').value
      ).to eq(@task1.goal)
      # 投稿内容を編集する
      fill_in 'タスク名', with: "#{@task1.name}+編集したタスク名"
      fill_in '目標', with: "#{@task1.goal}+編集した目標"
      # 編集してもTaskモデルのカウントは変わらないことを確認する
      expect{
        find('input[value="変更する"]').click
      }.to change { Task.count }.by(0)
      # タスクページに遷移したことを確認する
      expect(current_path).to eq(task_completions_path(@task1))
      # マイページに遷移する
      visit tasks_path
      # マイページには先ほど変更した内容のタスクが存在することを確認する
      expect(page).to have_content("#{@task1.name}+編集したタスク名")
      expect(page).to have_content("#{@task1.goal}+編集した目標")
    end
  end
  context 'タスク編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したタスクの編集画面には遷移できない' do
      # タスク1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @task1.user.email
      fill_in 'パスワード', with: @task1.user.password
      find('input[name="commit"]').click
      #タスク一覧ページに移動する
      visit lists_path
      # タスク2ページに移動する
      click_on @task2.name
      # タスク2に「編集」ボタンがないことを確認する
      expect(page).to have_no_link href: edit_task_path(@task2)
    end
    it 'ログインしていないとタスクの編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # マイページへ移動する
      visit tasks_path
      # ログイン画面へ移動させられる
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe 'タスク削除', type: :system do
  before do
    @task1 = FactoryBot.create(:task)
    @task2 = FactoryBot.create(:task)
  end
  context 'タスク削除ができるとき' do
    it 'ログインしたユーザーは自らが作成したタスクの削除ができる' do
      # ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @task1.user.email
      fill_in 'パスワード', with: @task1.user.password
      find('input[name="commit"]').click
      #マイページに移動する
      visit tasks_path
      # タスク1ページに移動する
      click_on @task1.name
      # ツイート1に「削除」ボタンがあることを確認する
      expect(page).to have_link href: task_path(@task1)
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        find_link(href: task_path(@task1)).click
      }.to change { Task.count }.by(-1)
      # マイページに遷移する
      visit tasks_path
      # マイページにはタスク1の内容が存在しないことを確認する
      expect(page).to have_no_content("#{@task1.name}")
      expect(page).to have_no_content("#{@task1.goal}")
    end
  end
  context 'タスク削除ができないとき' do
    it 'ログインしたユーザーは自分以外が作成したタスクの削除ができない' do
      # タスク1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @task1.user.email
      fill_in 'パスワード', with: @task1.user.password
      find('input[name="commit"]').click
      #タスク一覧ページに移動する
      visit lists_path
      # タスク2ページに移動する
      click_on @task2.name
      # タスク2に「削除」ボタンが無いことを確認する
      expect(page).to have_no_link href: edit_task_path(@task2)
    end
    it 'ログインしていないとタスクの削除ができない' do
      # トップページにいる
      visit root_path
      # マイページへ移動する
      visit tasks_path
      # ログイン画面へ移動させられる
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
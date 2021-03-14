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

RSpec.describe 'dekita!編集', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @task1 = FactoryBot.create(:task)
    @task2 = FactoryBot.create(:task)
    @completion_summary = Faker::Lorem.sentence
    @completion_name = Faker::Lorem.sentence
    @completion_human = Faker::Lorem.sentence
    @completion_memo = Faker::Lorem.sentence
    @completion_working_day = Faker::Date.between(from: 2.days.ago, to: Date.today)
    @completion_start_time = Faker::Time.between(from: DateTime.now - 2, to: DateTime.now)
    @completion_ending_time = Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
  end
  context 'dekita!編集ができるとき' do
    it 'ログインしたユーザーは自分が作成したdekita!の編集ができる' do
      # dekita!1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @task1.user.email
      fill_in 'パスワード', with: @task1.user.password
      find('input[name="commit"]').click
      # タスクページに移動する
      click_on @task1.name
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
      # dekita!1に「編集」ボタンがあることを確認する
      expect(page).to have_link href: edit_task_completion_path(@task1.id ,@task1.completions[0].id)
      # 編集ページへ遷移する
      visit edit_task_completion_path(@task1.id ,@task1.completions[0].id)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#completion_summary').value
      ).to eq(@task1.completions[0].summary)
      expect(
        find('#completion_name').value
      ).to eq(@task1.completions[0].tags[0].name)
      expect(
        find('#completion_human').value
      ).to eq(@task1.completions[0].thanks[0].human)
      expect(
        find('#completion_memo').value
      ).to eq(@task1.completions[0].memo)
      expect(
        find('#completion_working_day').value
      ).to eq(@task1.completions[0].working_day.to_s)
      expect(
        find('#completion_start_time').value.to_datetime.hour
      ).to eq(@task1.completions[0].start_time.hour)
      expect(
        find('#completion_start_time').value.to_datetime.min
      ).to eq(@task1.completions[0].start_time.min)
      expect(
        find('#completion_ending_time').value.to_datetime.hour
      ).to eq(@task1.completions[0].ending_time.hour)
      expect(
        find('#completion_ending_time').value.to_datetime.min
      ).to eq(@task1.completions[0].ending_time.min)
      # 投稿内容を編集する
      fill_in '取り組んだこと', with: "#{@task1.completions[0].summary}+編集した取り組んだこと"
      fill_in 'タグ', with: "#{@task1.completions[0].tags[0].name}+編集したタグ"
      fill_in '支えになった人', with: "#{@task1.completions[0].thanks[0].human}+編集した支えになった人"
      fill_in 'メモ', with: "#{@task1.completions[0].memo}+編集したメモ"
      fill_in '日付', with: @task1.completions[0].working_day + 1
      fill_in '開始時刻', with: @task1.completions[0].start_time + 1
      fill_in '終了時刻', with: @task1.completions[0].ending_time + 1
      # 編集してもTaskモデルのカウントは変わらないことを確認する
      expect{
        find('input[value="更新する"]').click
      }.to change { Completion.count }.by(0)
      # タスクページに遷移したことを確認する
      expect(current_path).to eq(task_completions_path(@task1))
      # マイページには先ほど変更した内容のタスクが存在することを確認する
      expect(page).to have_content("#{@task1.completions[0].summary}+編集した取り組んだこと")
      expect(page).to have_content("#{@task1.completions[0].tags[0].name}+編集したタグ")
      expect(page).to have_content("#{@task1.completions[0].thanks[0].human}+編集した支えになった人")
      expect(page).to have_content("#{@task1.completions[0].memo}+編集したメモ")
      expect(page).to have_content((@task1.completions[0].working_day + 1).to_s)
      expect(page).to have_content(@task1.completions[0].start_time.hour)
      expect(page).to have_content(@task1.completions[0].start_time.min)
      expect(page).to have_content(@task1.completions[0].ending_time.hour)
      expect(page).to have_content(@task1.completions[0].ending_time.min)
    end
  end
  context 'dekita!編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したdekita!の編集画面には遷移できない' do
      # dekita!1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @task1.user.email
      fill_in 'パスワード', with: @task1.user.password
      find('input[name="commit"]').click
      # タスクページに移動する
      click_on @task1.name
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
      # ログアウトする
      click_on 'ログアウト'
      # 別のユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @task2.user.email
      fill_in 'パスワード', with: @task2.user.password
      find('input[name="commit"]').click
      # タスク一覧ページに移動する
      click_on 'みんなのタスク'
      # タスクページに移動する
      click_on @task1.name
      # dekita!2に「編集」ボタンがないことを確認する
      expect(page).to have_no_link href: edit_task_completion_path(@task1.id ,@task1.completions[0].id)
    end
    it 'ログインしていないとdekita!の編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # タスクページへ移動する
      visit task_completions_path(@task1)
      # ログイン画面へ移動させられる
      expect(current_path).to eq(new_user_session_path)
    end
  end
end



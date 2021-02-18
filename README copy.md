# dekita!
目標達成の為に取り組んだことを記録するアプリケーションです。
目標ごとにタスクを作成し、タスク内に日々の取り組み(dekita!)を記録します。
dekita!投稿の際に支えになった人を意識することで、目標の為に自分を支えてくれている人の存在に気付くきっかけになります。
また他のユーザーが記録したタスクも閲覧することができ、同じ様な目標を達成した方の学習の仕方を参考にすることができます。

# URL
デプロイ後編集

# 開発環境
・Ruby 2.6.5
・Ruby on Rails 6.0.3.4
・

アプリケーション概要	このアプリケーションでできることを記述しましょう。
URL	デプロイ済みのURLを記述しましょう。デプロイが済んでいない場合は、デプロイ次第記述しましょう。
テスト用アカウント	ログイン機能等を実装した場合は、記述しましょう。またBasic認証等を設けている場合は、そのID/Passも記述しましょう。
利用方法	このアプリケーションの利用方法を説明しましょう。
目指した課題解決	このアプリケーションを通じて、どのような人の、どのような課題を解決したかったかを書きましょう。
洗い出した要件	スプレッドシートにまとめた要件定義を、マークダウンで記述しなおしましょう。
実装した機能についてのGIFと説明	実装した機能について、それぞれどのような特徴があるのか列挙しましょう。GIFを添えることで、イメージがしやすくなります。
実装予定の機能	洗い出した要件の中から、今後実装予定のものがあれば記述しましょう。
データベース設計	ER図等を添付しましょう。
ローカルでの動作方法	git cloneしてから、ローカルで動作をさせるまでに必要なコマンドを記述しましょう。この時、アプリケーション開発に使用した環境を併記することを忘れないでください（パッケージやRubyのバージョンなど）。

# README

# テーブル設計

## users テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| name     | string | null: false |
| email    | string | null: false |
| password | string | null: false |
| profile  | text   |             |

### Association

- has_many :tasks
- has_many :completions

## tasks テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| name         | string     | null: false                    |
| goal         | text       |                                |
| user         | references | null: false, foreign_key: true |

### Association

- has_many :completions
- belongs_to :user

## completions テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| summary      | string     | null: false                    |
| memo         | text       |                                |
| working_day  | date       | null: false                    |
| start_time   | time       | null: false                    |
| ending_time  | time       | null: false                    |
| user         | references | null: false, foreign_key: true |
| task         | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :task
- has_many :completion_thank_relations
- has_many :thanks, through: :completion_thank_relations
- has_many :completion_tag_relations
- has_many :tags, through: :completion_tag_relations

## completion_tag_relations テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| completion   | references | null: false, foreign_key: true |
| tag          | references | null: false, foreign_key: true |

### Association

- belongs_to :completion
- belongs_to :tag

## tags テーブル

| Column       | Type       | Options     |
| ------------ | ---------- | ----------- |
| name         | string     | null: false |

### Association
- has_many :completion_tag_relations
- has_many :completions, through: :completion_tag_relations

## completion_thank_relations テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| completion | references | null: false, foreign_key: true |
| thank      | references | null: false, foreign_key: true |

### Association

- belongs_to :completion
- belongs_to :thank

## thanks テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| human   | string     | null: false                    |
| user    | references | null: false, foreign_key: true |

### Association

- has_many :completion_thank_relations
- has_many :completions, through: :completion_thank_relations
- belongs_to :user
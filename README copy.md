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
・MySQL

# 機能一覧
・ユーザー管理機能(devise)
・投稿、編集、削除機能
・画像投稿機能(carrierwave, rmagick)
・タグ付け機能
・タグの使用頻度のグラフ表示機能(chartkick)
・お気に入り機能(Ajax)
・投稿一覧表示機能
・ページネーション機能(kaminari)

# 実装予定
・検索機能
・ユーザーフォロー機能
・AWS(EC2, S3)
・コメント機能
・テスト(RSpec)
・自動テスト、自動デプロイ

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

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| name         | string     | null: false                    |
| user         | references | null: false, foreign_key: true |

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
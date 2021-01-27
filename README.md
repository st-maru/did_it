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
- has_many :contents
- has_many :completions

## tasks テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| name         | string     | null: false                    |
| goal         | text       |                                |
| user         | references | null: false, foreign_key: true |

### Association

- has_many :contents
- belongs_to :user

## contents テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| name         | string     | null: false                    |
| item         | text       | null: false                    |
| user         | references | null: false, foreign_key: true |
| task         | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :task

## completions テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| summary      | string     | null: false                    |
| memo         | text       |                                |
| working_day  | date       | null: false                    |
| start_time   | time       | null: false                    |
| ending_time  | time       | null: false                    |
| user         | references | null: false, foreign_key: true |
| content      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :content
- has_many :thanks, through: completion_thank_relations

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

### Association

- has_many :completions, through: completion_thank_relations

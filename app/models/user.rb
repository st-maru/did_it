class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  mount_uploader :image, ImageUploader
  validates :name, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tasks, dependent: :destroy
  has_many :completions, dependent: :destroy
  has_many :thanks, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :favorites
  has_many :favorite_tasks, through: :favorites, source: :task

      def self.guest
        find_or_create_by!(email: 'guest@example.com') do |user|
         user.password = SecureRandom.urlsafe_base64
         user.name = 'ゲストユーザー'
      end
    end
end

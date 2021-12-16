class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  #usersテーブルにパスワードを保存するとき、パスワードを暗号化して保存
  #ユーザ登録フォーム用にpasswordとpassword_confirmationという変数をモデルに追加して、ユーザ登録時のパスワード確認のために使用する
  #passwordとpassword_confirmationには平文のパスワードが代入されるが、usersテーブルのカラムではない一時的な変数として扱われるので、保存されない
  #ログイン認証用のメソッドauthenticateを提供する

  #つまりpassword_digestカラムを用意し、モデルファイルにhas_secure_passwordを記述すれば、ログイン認証のための準備を良しなに用意してくれる

  has_many :microposts
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user

  has_many :favorites
  has_many :goodings, through: :favorites, source: :micropost

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end
  
  def good(other_micropost)
    #unless self.micropost_id == other_micropost.id
      self.favorites.find_or_create_by(micropost_id: other_micropost.id)
    #end
  end

  def ungood(other_micropost)
    favorite = self.favorites.find_by(micropost_id: other_micropost.id)
    favorite.destroy if favorite
  end

  def gooding?(other_micropost)
    self.goodings.include?(other_micropost)
  end
end

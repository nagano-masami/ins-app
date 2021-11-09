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
end

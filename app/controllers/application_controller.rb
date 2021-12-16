class ApplicationController < ActionController::Base

  include SessionsHelper

  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end

  def counts_user(user)
    @count_microposts = user.microposts.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    
    @count_goodings = user.goodings.count
    #@count_gooded = user.gooded.count
    #  ↑いらない？
  end

  def counts_micropost(micropost)
    #@count_gooded = micropost.gooded.count
  end
end
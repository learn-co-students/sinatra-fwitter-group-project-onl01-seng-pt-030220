class User < ActiveRecord::Base
  has_secure_password

  has_many :tweets

  def slug
     @user_name=self.username.parameterize
  end

  def self.find_by_slug(slug)
  #  first_word="%#{slug.capitalize.split("-")[0]}%"
  #  self.where("name LIKE ?",first_word).first
    username=slug.titleize
    User.find_by(username:username)
  end


end

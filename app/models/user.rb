class User < ActiveRecord::Base
  has_secure_password

  has_many :tweets

  def slug
     @user_name=self.username.parameterize
  end

  def self.find_by_slug(slug)
      first_word="%#{slug.capitalize.split("-")[0]}%"
      self.where("username LIKE ?",first_word).first

  #  usern=slug.titleize
  #  self.find_by(name:usern)
  end



end

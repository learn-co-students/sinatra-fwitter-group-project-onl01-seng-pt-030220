class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    #binding.pry
    username = self.username
    slug = username.downcase.strip.gsub(" ", "-").gsub(/[^\w-]/, '')
  end

  def self.find_by_slug(slug)
    self.all.detect do |t|
      t.slug == slug
    end
  end

end

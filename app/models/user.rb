class User < ActiveRecord::Base
  default_scope { where(admin: false) }
  # attr_accessible :name, :user

  has_many :articles, :dependent => :destroy
  has_many :authentications, :dependent => :destroy

  validates_presence_of :name
  validates_uniqueness_of :name
  # validates_uniqueness_of :uid, :scope => :provider
end
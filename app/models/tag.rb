class Tag < ActiveRecord::Base
  # attr_accessible :name
  has_many :articles_tags
  has_many :articles, through: :article_tags
end

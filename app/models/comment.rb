class Comment < ActiveRecord::Base
  # attr_accessible :content, :name

  belongs_to :article

  validates_presence_of :name, :article_id, :content
end
class Comment < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user
  belongs_to :article

  validates_presence_of :user_id, :article_id, :content
end
class ArticleImage < ActiveRecord::Base
  attr_accessible :article_id, :name, :image

  belongs_to :article
  mount_uploader :image, ImageUploader
end

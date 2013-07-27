class Image < ActiveRecord::Base
  # attr_accessible :image_url
  belongs_to :article
  
  mount_uploader :image_url, ImageUploader
end
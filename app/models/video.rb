class Video < ActiveRecord::Base
  attr_accessible :video_url

  belongs_to :article
end
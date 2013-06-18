class Article < ActiveRecord::Base
  attr_accessible :content, :title, :image

  has_many :comments
  belongs_to :user
  belongs_to :article

  validates_presence_of :title, :content, :user_id

  mount_uploader :image, ImageUploader
  
	def find_dimensions
    debugger
    temporary = attachment.queued_for_write[:original]
    filename = temporary.path unless temporary.nil?
    filename = attachment.path if filename.blank?
    geometry = Paperclip::Geometry.from_file(filename)
    self.attachment_width  = geometry.width
    self.attachment_height = geometry.height
  end
end

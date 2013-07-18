class ImageUploader < CarrierWave::Uploader::Base
  
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "uploads/articles/#{model.article.id}"
  end

  # new issue. it fails with this block. you can easily debug it
  # # for now it works without versions
  # version :thumb do
  #   # process :resize_to_fit => [200, 200]
  #   process :resize_to_fill => [180, 180]
  # end

  def cache_dir
    # should return path to cache dir
    Rails.root.join 'public/uploads/tmp'
  end

  # def cache_dir
  #   "#{Rails.root}/tmp/uploads"
  # end

  # def root
  #   "#{Rails.root}/tmp"
  # end
  
end
class Article < ActiveRecord::Base
  attr_accessor :tag_list

  has_many :articles_tags
  has_many :tags, :through => :articles_tags
  has_many :comments
  has_many :videos
  has_many :images

  belongs_to :user

  accepts_nested_attributes_for :videos, allow_destroy: true
  accepts_nested_attributes_for :images, allow_destroy: true
  
  validates_presence_of :title, :user_id
  validates :content, :length => { :maximum => 1000,
    :too_long => "%{count} characters is the maximum allowed" }

  def self.tagged_with(name)
    Tag.find_by_name!(name).articles_id
  end

  def self.tag_counts
    Tag.select('tags.*, count(taggings.tag_id) as count').
    joins(:taggings).group('taggings.tag_id')
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
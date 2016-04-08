class Image < ActiveRecord::Base
  belongs_to :project

  has_attached_file :image, styles: { original: "5000x5000>", thumb: "250x250#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end

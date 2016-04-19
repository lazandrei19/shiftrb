class Project < ActiveRecord::Base
  include PublicActivity::Common

  MY_SALT = 'shift_lazandrei19'

  after_create :generate_hashed_id
  validates_uniqueness_of :hashed_id

  belongs_to :user
  has_many :feedbacks, dependent: :destroy
  has_many :images, dependent: :destroy

  acts_as_votable

  has_attached_file :logo, styles: { medium: "300x300#", thumb: "100x100#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  accepts_nested_attributes_for :images, reject_if: proc { |attributes| attributes['image'].blank? }, allow_destroy: true

  def to_param
    self.hashed_id
  end

  private

  def generate_hashed_id
    self.update_attributes(:hashed_id => Digest::SHA1.hexdigest("--#{MY_SALT}--#{self.id}--")[0..15])
  end
end

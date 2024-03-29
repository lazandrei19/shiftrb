class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  include Resonatable

  MY_SALT = 'shift_lazandrei19'

  after_create :generate_hashed_id
  validates_uniqueness_of :hashed_id
  before_save :set_default

  searchable do
    text :name
  end

  acts_as_voter
  
  has_attached_file :avatar, styles: { medium: "150x150#", thumb: "75x75#", mini: "50x50#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :projects, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :workplaces, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :members, dependent: :destroy
  
  accepts_nested_attributes_for :workplaces, reject_if: proc { |attributes| attributes['company'].blank? }, allow_destroy: true

  def to_param
    self.hashed_id
  end

  validates_presence_of :name
  validates_presence_of :avatar
  validates_presence_of :workplaces
  validates_associated :workplaces
  validates_associated :replies
  validates_associated :projects
  validates_associated :feedbacks

  private

  def generate_hashed_id
    self.update_attributes(:hashed_id => Digest::SHA1.hexdigest("--#{MY_SALT}--#{self.id}--")[0..15])
  end

  def set_default
    self.appreciation = 0 unless self.appreciation
    self.unread = 0 unless self.unread
  end
end

class Feedback < ActiveRecord::Base
  include PublicActivity::Common

  after_create :generate_hashed_id
  validates_uniqueness_of :hashed_id

  belongs_to :project
  belongs_to :user

  has_many :replies, dependent: :destroy

  acts_as_votable

  MY_SALT = 'fhfhodfhohfhiodoiclkdhnsfhihewoifadmfj90qewyq9wq'

  def to_param
    self.hashed_id
  end

  private

  def generate_hashed_id
    self.update_attributes(:hashed_id => Digest::SHA1.hexdigest("--#{MY_SALT}--#{self.id}--")[0..15])
  end
end

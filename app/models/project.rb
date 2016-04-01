class Project < ActiveRecord::Base
  MY_SALT = 'shift_lazandrei19'

  after_create :generate_hashed_id
  validates_uniqueness_of :hashed_id

  def to_param
    self.hashed_id
  end

  private

  def generate_hashed_id
    self.update_attributes(:hashed_id => Digest::SHA1.hexdigest("--#{MY_SALT}--#{self.id}--")[0..15])
  end
end

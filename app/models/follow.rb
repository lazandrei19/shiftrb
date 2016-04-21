class Follow < ActiveRecord::Base
  include Resonatable

  validates_presence_of :user
  validates_presence_of :target_user

  validates_uniqueness_of :user, scope: :target_user
end

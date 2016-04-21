class Reply < ActiveRecord::Base
  belongs_to :user
  belongs_to :feedback

  validates_presence_of :content
  validates_presence_of :feedback
  validates_presence_of :user
end

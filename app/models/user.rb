class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  acts_as_taggable_on :skills, :experience
  has_many :projects, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable,  and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :user_job_listings
  has_many :job_listings, through: :user_job_listings
end

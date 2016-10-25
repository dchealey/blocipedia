class User < ActiveRecord::Base
  has_many :articles
  
  before_save { self.email = email.downcase }
  before_save { self.role ||= :standard }
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:standard, :admin, :premium]

end

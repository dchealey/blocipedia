class Article < ActiveRecord::Base
  validates :title, presence: true,
                    length: { minimum: 5 }

  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators
end

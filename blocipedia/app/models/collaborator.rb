class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :article

  @user_options = User.all.map { |u| [ u.email, u.id] }
end

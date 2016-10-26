class UsersController < ApplicationController
  
  def show
    if current_user.present?
      @user = params[:id] ? User.find(params[:id]) : current_user
    else
      redirect_to root_path
    end
  end

  def index
    @users = User.all
  end 
 
  def new
    @user = User.new
  end

  def downgrade
    @user = User.find(params[:id])
    @user.role = 'standard'

    if @user.save
      flash[:notice] = "You have canceled your premium account. Your private articles will be made public."
      redirect_to :back
    else
      flash[:error] = "Error. Please try again."
      redirect_to :back
    end
  
    @private_articles = @user.articles.where(private: true)

    @private_articles.each do |downgrade|
      downgrade.update_attributes(private: false)
    end
  end
end
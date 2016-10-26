class CollaboratorsController < ApplicationController
  before_action :set_article

  def new
    @collaborator = Collaborator.new
  end

  def create
    @collaborator = Collaborator.new(article_id: @article.id, user_id: params[:user_id])


    if @collaborator.save
      flash[:notice] = "Collaborator added."
      redirect_to @article
    else
      flash[:error] = "Error. Please try again."
      render :show
    end
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "Collaborator removed."
      redirect_to @article
    else
      flash[:error] = "Error. Please try again."
      render :show
    end
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end
end
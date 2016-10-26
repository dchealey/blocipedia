class ArticlePolicy < ApplicationPolicy
  attr_reader :user, :article

  def initialize(user, article)
    @user = user
    @article = article
  end

  def index?
    user.present?
  end

  def update?
    user.present?
  end

  def destroy?
    user.role == 'admin' || record.user == user
  end
  
  def new?
    user.present?
  end
  
  def create?
    user.present?
  end
  
  def show?
    user.present?
  end
  
  def edit?
    user.present?
  end
  
  class Scope < Scope
    def resolve
      articles = []
      if user.role == 'admin'
        articles = scope.all
      elsif user.role = 'premium'
        premium_articles = scope.all
        premium_articles.each do |article|
          if !article.private? || article.user == user || article.collaborators.include?(user)
            articles << article
          end
        end
      else
        standard_articles = scope.all
        articles = [ ]
        standard_articles.each do |article|
          if !article.private? || article.collaborators.include?(user)
            articles << article
          end
        end
      end
      articles
    end
  end
end
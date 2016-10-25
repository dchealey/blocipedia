class ApplicationPolicy
  attr_reader :user, :article
  
  def initialize(user, article)
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    @user = user
    @article = article
  end

  def index?
    false
  end
  
  def show?
    scope.where(:id => article.id).exists?
  end
  
  def create?
    false
  end
  
  def new?
    create?
  end

  def update?
    user.present?
  end

  def edit?
    update?
  end

  def destroy?
    false
  end
  
  def scope
    Pundit.policy_scope!(user, article.class)
  end
  
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
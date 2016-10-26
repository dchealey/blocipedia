class CollaborationPolicy < ApplicationPolicy
  def create?
    user.present? && (article.user == user) && user.role?(:premium)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end

end
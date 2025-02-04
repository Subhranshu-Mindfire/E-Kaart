class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def create?
    user.admin?  
  end

  def edit?
    user.admin? || user == record
  end

  def update?
    edit?
  end

  def show?
    user.admin? || user == record 
  end

  def destroy?
    user.admin?  
  end
end

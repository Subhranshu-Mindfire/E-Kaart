class RolePolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def new?
    index?
  end

  def show?
    index?
  end

  def edit?
    index?
  end

  def update?
    index?
  end

  def destroy?
    index?
  end
end

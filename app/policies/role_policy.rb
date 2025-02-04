class RolePolicy < ApplicationPolicy
  def new?
    user.is_admin?
  end

  def show?
    user.is_admin?
  end

  def edit?
    user.is_admin?
  end

  def destroy?
    user.is_admin?
  end
end

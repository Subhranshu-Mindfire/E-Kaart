class ProductPolicy < ApplicationPolicy
  def index?
    user.admin? || user.owner?
  end

  def new?
    index?
  end

  def create?
    index?
  end

  def show?
    index?
  end

  def edit?
    index?
  end

  def update?
    edit?
  end

  def destroy?
    index?
  end
end
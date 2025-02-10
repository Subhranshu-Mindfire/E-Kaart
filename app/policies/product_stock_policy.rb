class ProductStockPolicy < ApplicationPolicy
  def index?
    user.owner? || user.admin?
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
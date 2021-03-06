class CompanyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
       scope.all
    end
  end

  def overview?
    true
  end

  def index?
    true # anyone can view companies
  end

  def select?
    true # anyone can select a company
  end

  def create?
    true # anyone can create a company
  end

  def update?
    user.admin # only admins can edit/update companies
  end

  def destroy?
    user.admin # only admins can destroy companies
  end

  def new_company_message?
    user.admin # only admins can destroy companies
  end

  def upvote?
    true
  end

  def downvote?
    true
  end
end

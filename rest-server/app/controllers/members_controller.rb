class MembersController < ApplicationController
  def index
    @members = Member.order(id: :asc)
  end

  def create
    @member = Member.create(first_name: member_params['first-name'],
                            last_name:  member_params['last-name'],
                            email:      member_params['email'])
  end

  private

  def member_params
    @member_params ||= params.permit('first-name', 'last-name', 'email')
  end
end

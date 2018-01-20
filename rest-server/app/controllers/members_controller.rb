class MembersController < ApplicationController
  def index
    @members = Member.order(id: :asc)
  end

  def create
    @member = Member.create(member_params)
  end

  def show
    @member = Member.find(params[:id])
  end

  private

  def member_params
    @member_params ||=
      snake_params.permit('first_name', 'last_name', 'email')
  end
end

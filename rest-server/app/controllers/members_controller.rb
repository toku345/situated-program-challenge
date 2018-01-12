class MembersController < ApplicationController
  def index
    @members = Member.order(id: :asc)
  end
end

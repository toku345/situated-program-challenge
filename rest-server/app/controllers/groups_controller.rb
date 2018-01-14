class GroupsController < ApplicationController
  def index
    @groups = Group.order(id: :asc)
  end
end

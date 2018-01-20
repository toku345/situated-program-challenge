class GroupsController < ApplicationController
  def index
    @groups = Group.includes(:venues, :meetups).order(id: :asc)
  end

  def create
    @group = Group.create(group_params)

    # admin メンバー登録
    params['admin-member-ids'].map do |id|
      @group.groups_members.create(member_id: id, admin: true)
    end

    @admins = @group.admins
  end

  private

  def group_params
    @group_params ||=
      snake_params.permit('group_name').transform_keys { |k| k == 'group_name' ? 'name' : k }
  end
end

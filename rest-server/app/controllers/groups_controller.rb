class GroupsController < ApplicationController
  def index
    @groups = Group.includes(:venues, :meetups).order(id: :asc)
  end

  def create
    @group = Group.create(name: params['group-name'])

    # admin メンバー登録
    params['admin-member-ids'].map do |id|
      @group.groups_members.create(member_id: id, admin: true)
    end

    @admins = @group.members.where(groups_members: { admin: true })
  end
end

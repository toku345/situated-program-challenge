class MembersGroupsController < ApplicationController
  before_action :set_groups_member, only: [:update]

  def update
    @groups_member.admin = params[:admin] =~ /true/ ? true : false
    @groups_member.save! if @groups_member.changed?
  end

  private

  def set_groups_member
    groups_members =
      GroupsMember.where(group_id: params[:id], member_id: params[:member_id])
    @groups_member =
      if groups_members.empty?
        GroupsMember.new(group_id: params[:id], member_id: params[:member_id])
      else
        groups_members.first
      end
  end
end

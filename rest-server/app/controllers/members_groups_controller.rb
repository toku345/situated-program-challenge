class MembersGroupsController < ApplicationController
  def create
    groups_members =
      GroupsMember.where(group_id: params[:group_id], member_id: params[:member_id])
    @groups_member =
      if groups_members.empty?
        GroupsMember.create(groups_member_params)
      else
        # 指定されたメンバーは既にグループに登録済み
        # NOTE: APIドキュメントには指定無いため、レコード情報は更新しない(= admin更新しない)ことにする
        #       更新するためには PUT/PATCH でコールすべき?
        groups_members.first
      end
  end

  private

  def groups_member_params
    @groups_member_params ||=
      snake_params.permit('group_id', 'member_id', 'admin')
  end
end

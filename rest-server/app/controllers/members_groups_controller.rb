class MembersGroupsController < ApplicationController
  def create
    groups_members =
      GroupsMember.where(group_id: params[:id], member_id: params[:member_id])
    @groups_member =
      if groups_members.empty?
        GroupsMember.create(group_id: params[:id], member_id: params[:member_id],
                            admin: params[:admin])
      else
        # 指定されたメンバーは既にグループに登録済み
        # NOTE: APIドキュメントには指定無いため、レコード情報は更新しない(= admin更新しない)ことにする
        #       更新するためには PUT/PATCH でコールすべき?
        groups_members.first
      end
  end
end

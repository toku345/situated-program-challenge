class MembersMeetupsController < ApplicationController
  def create
    @meetups_member =
      MeetupsMember.find_or_create_by(meetup_id: params[:id], member_id: params[:member_id])
  end
end

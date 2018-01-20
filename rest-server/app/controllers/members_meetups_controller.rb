class MembersMeetupsController < ApplicationController
  def create
    @meetups_member =
      MeetupsMember.find_or_create_by(meetups_member_params)
  end

  private

  def meetups_member_params
    @meetups_member_params ||=
      snake_params.permit('meetup_id', 'member_id')
  end
end

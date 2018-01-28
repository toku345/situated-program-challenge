class MeetupsController < ApplicationController
  def index
    @meetups = Meetup.where(group_id: params[:group_id])
  end

  def create
    @meetup =
      Meetup.create(meetup_params)
  end

  def show
    @meetup = Meetup.find_by(group_id: params[:group_id], id: params[:id])
  end

  private

  def meetup_params
    @meetup_params ||=
      snake_params.permit('title', 'start_at', 'end_at', 'venue_id', 'online_venue_id', 'group_id')
  end
end

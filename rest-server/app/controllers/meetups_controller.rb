class MeetupsController < ApplicationController
  def index
    @meetups = Meetup.where(group_id: params[:group_id])
  end

  def create
    @meetup =
      Meetup.create(group_id: params[:group_id],
                    title: meetup_params['title'], venue_id: meetup_params['venue-id'],
                    start_at: meetup_params['start-at'], end_at: meetup_params['end-at'])
  end

  private

  def meetup_params
    @meetup_params ||= params.permit('title', 'start-at', 'end-at', 'venue-id')
  end
end

class OnlineVenuesController < ApplicationController
  def index
    @online_venues = OnlineVenue.where(group_id: params[:group_id])
  end

  def create
    @online_venue = OnlineVenue.create(online_venue_params)
  end

  private

  def online_venue_params
    @online_venue_params ||=
      snake_params.permit('venue_name', 'url', 'group_id')
                  .transform_keys { |k| k == 'venue_name' ? 'name' : k }
  end
end

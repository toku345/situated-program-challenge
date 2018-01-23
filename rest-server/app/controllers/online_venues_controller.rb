class OnlineVenuesController < ApplicationController
  def index
    @online_venues = OnlineVenue.where(group_id: params[:group_id])
  end
end

class VenuesController < ApplicationController
  def index
    @venues = Venue.where(group_id: params[:group_id])
  end
end

class MeetupsController < ApplicationController
  def index
    @meetups = Meetup.where(group_id: params[:group_id])
  end
end

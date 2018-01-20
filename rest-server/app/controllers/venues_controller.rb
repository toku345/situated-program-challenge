class VenuesController < ApplicationController
  def index
    @venues = Venue.where(group_id: params[:group_id])
  end

  def create
    @venue = Venue.create(venue_params)
  end

  private

  def venue_params
    # NoMethodError: undefined method `deep_transform_keys' for ActionController::Parameters
    # なのでネスト先にもkebab-case あるので、今回はここで明示的に transform_keys(&:underscore) を行う
    @venue_params ||=
      {}.merge(params.permit('venue-name', 'group_id')
        .merge(params.require('address')
                     .permit('postal-code', 'prefecture', 'city', 'address1', 'address2'))
        .transform_keys { |k| k == 'venue-name' ? 'name' : k })
        .transform_keys { |k| k =~ /address(\d)/ ? "street#{Regexp.last_match(1)}" : k }
        .transform_keys(&:underscore)
  end
end

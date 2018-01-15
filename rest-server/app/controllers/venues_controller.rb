class VenuesController < ApplicationController
  def index
    @venues = Venue.where(group_id: params[:group_id])
  end

  # rubocop:disable Metrics/AbcSize
  def create
    @venue =
      Venue.create(group_id: params[:group_id],
                   name:       venue_params['venue-name'], postal_code: venue_params['postal-code'],
                   prefecture: venue_params['prefecture'], city:        venue_params['city'],
                   street1:    venue_params['address1'],   street2:     venue_params['address2'])
  end
  # rubocop:enable Metrics/AbcSize

  private

  def venue_params
    @venue_params ||=
      {}.merge(params.permit('venue-name'))
        .merge(params.require(:address).permit('postal-code', 'prefecture', 'city',
                                               'address1', 'address2'))
  end
end

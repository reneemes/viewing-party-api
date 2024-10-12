class Api::V1::PartiesController < ApplicationController
  before_action :verify_api_key, only: :create

  def create
    # use the api key to validate the user and also find the user
    # use the invitees to create new instances on the user_parties table

    new_party = Party.create(party_params)
    if new_party.save
      render json: PartySerializer.new(new_party), status: :created
    else
      # do some error handling here
    end
  end

  private

  def party_params
    params.require(:party).permit(:name, :start_time, :end_time, :movie_id, :movie_title, :api_key, :invitees)
  end

  def verify_api_key
    if params[:api_key].blank?
      render json: { error: 'Invalid or missing API key' }, status: :unauthorized
    end
  end
end
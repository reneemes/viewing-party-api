class Api::V1::PartiesController < ApplicationController
  def create
    # find the user somehow
    # user = User.find(params[:user_id])

    new_party = Party.create(party_params)
    # render json: PartySerializer.new(new_party), status: :created
    render json: new_party, status: :created
  end

  private

  def party_params
    params.require(:party)
    .permit(:name, :start_time, :end_time, :movie_id, :movie_title, :api_key, :invitees)
  end
end
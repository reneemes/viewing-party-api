class Api::V1::PartiesController < ApplicationController
  before_action :verify_api_key#, only: :create

  def create
    # use the api key to validate the user and also find the user
    # use the invitees to create new instances on the user_parties table
    user = User.find_by(api_key: params[:api_key])
    if user.nil?
      return render json: { error: 'No user found' }, status: :not_found
    end

    new_party = Party.create(party_params)
    if new_party#.save
      render json: PartySerializer.new(new_party), status: :created
      handle_invitees(params[:invitees], new_party, user)
    else
      # do some error handling here
      return render json: { errors: new_party.errors.full_message }, status: :unprocessable_entity
    end
  end

  private

  def party_params
    params.require(:party).permit(:name, :start_time, :end_time, :movie_id, :movie_title, :api_key, :invitees)
  end

  def verify_api_key
    if params[:api_key].blank?
      return render json: { error: 'Invalid or missing API key' }, status: :unauthorized
    end
  end

  def handle_invitees(invitees, party, host)
    UserParty.create(user_id: host.id, party_id: party.id, is_host: true)
    invitees.each do |user_id|
      UserParty.create(user_id: user_id, party_id: party.id, is_host: false)
    end
  end

end

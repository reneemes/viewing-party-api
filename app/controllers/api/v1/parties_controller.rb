class Api::V1::PartiesController < ApplicationController
  before_action :verify_api_key

  def create
    user = User.find_by(api_key: params[:api_key])
    if user.nil?
      return render json: ErrorSerializer.error('No user found'), status: :not_found
    end
    
    movie_time = TmdbGateway.get_movie(params[:movie_id])[:runtime]
  #  require 'pry'; binding.pry
    new_party = Party.create(party_params.merge(movie_runtime: movie_time))
    # new_party = Party.create(party_params)

    # new_party.check_runtime(movie_time)
    
    if new_party.save
      handle_invitees(params[:invitees], new_party, user)
      render json: PartySerializer.new(new_party), status: :created
    else
      return render json: ErrorSerializer.error(new_party.errors), status: :unprocessable_entity
    end
  end

  private

  def party_params
    params.require(:party).permit(:name, :start_time, :end_time, :movie_id, :movie_title, :api_key, :invitees)
  end

  def verify_api_key
    if params[:api_key].blank?
      return render json: ErrorSerializer.error('Invalid or missing API key'), status: :unauthorized
    end
  end

  def handle_invitees(invitees, party, host)
    UserParty.create(user_id: host.id, party_id: party.id, is_host: true)
    invitees.each do |user_id|
      UserParty.create(user_id: user_id, party_id: party.id, is_host: false)
    end
  end

  # def valid_party_duration(runtime)
  #   require 'pry'; binding.pry
    
  #   (params[:end_time].delete("- :").to_i - params[:start_time].delete("- :").to_i) < runtime
  # end

end

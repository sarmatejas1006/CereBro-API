class CurrentUserController < ApiController
  before_action :authenticate_user

  def show
    render json: @current_user
  end

  def update
    current_user.update(UserParameters.new(params).permit_edit)
    render json: current_user
  end

  def tutor_requests
    @accepted = @current_user.tutor_questions.where(tutor_accepted: true)
    @pending = @current_user.tutor_questions.where(tutor_accepted: nil)
    render json: { accepted: @accepted ,pending: @pending }
  end

  def learner_requests
    @accepted = @current_user.learner_questions.where(tutor_accepted: true)
    @pending = @current_user.learner_questions.where(tutor_accepted: nil)
    render json: { accepted: @accepted ,pending: @pending }
  end

  def add_skills
    @current_user.add_skills(params[:skill])
    render json: @current_user
  end

  def skills
    render json: @current_user.skills
  end

  def add_preferred_location
    @current_user.preferred_locations.create!(name: params[:location][:name], x_coordinate: params[:location][:x_coordinate], y_coordinate: params[:location][:y_coordinate])
    render json: @current_user
  end
end

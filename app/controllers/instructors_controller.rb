class InstructorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    instructors = Instructor.all
    render json: instructors
  end

  def show
    instructor = find_instructor
    render json: instructor
  end

  def create
    instructor = Instructor.create!(instructor_params)
    render json: instructor, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def update
    instructor = find_instructor
    instructor.update(instructor_params)
    render json: instructor
  end

  def destroy
    instructor = find_instructor
    instructor.destroy
    head :no_content
  end

  private

  def find_instructor
    Instructor.find(params[:id])
  end

  def instructor_params
    params.permit(:id, :name)
  end

  def render_not_found_response
    render json: { error: "Instructor not found" }, status: :not_found
  end
end

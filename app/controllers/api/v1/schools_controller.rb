class Api::V1::SchoolsController < Api::ApiController

  # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
  api :GET, '/v1/schools', 'List schools'
  error code: 401
  def index

    @schools = School.filter(params)

  end

  api :GET, '/v1/schools/:id', 'School by id'
  def show
    @school = School.find(params[:id])
    render json: {success: true, school: @school}.to_json
  end

  api :DELETE, '/v1/schools', 'Delete school'
  def destroy
    @school = School.find(params[:id])
    @school.destroy
    if @school.errors.any?
      render json: {success: false, errors: @school.errors.messages}.to_json, status: 422
    else
      render template: 'api/v1/schools/show', status: 200
    end
  end

  api :POST, '/v1/schools', 'Create school'


  def create
  @school = School.create(school_params)

    if @school.errors.any?
      render json: {success: false, errors: @school.errors.messages}.to_json, status: 422
    else
      render template: 'api/v1/schools/show', status: 201
    end
  end

  api :PUT, '/v1/schools', 'Update School'

  def update
    @school = School.find(params[:id])
    @school.update_attributes(school_params)
    if @school.errors.any?
      render json: {success: false, errors: @school.errors.messages}.to_json, status: 422
    else
      render template: 'api/v1/schools/show', status: 200
    end
  end


  private
  def school_params
    params.require(:school).permit(
    :name,
    :address,
    :city,
    :zip_code,
    :latitude,
    :longitude,
    :status,
    :nb_student,
    :openings,
    :phone,
    :email
    )
  end
end

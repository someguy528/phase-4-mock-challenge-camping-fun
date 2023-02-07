class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :rescue_record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :rescue_invalid_record

    def index
        campers = Camper.all
        render json: campers
    end

    def show
        camper = Camper.find(params[:id])
        render json: camper, serializer: CamperWithActivitiesSerializer
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end

    private

    def camper_params
        params.permit(:name, :age)
    end

    def rescue_record_not_found
        render json: {error: "Camper not found"}, status: :not_found
    end

    def rescue_invalid_record(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

end

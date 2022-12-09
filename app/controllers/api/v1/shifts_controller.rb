class Api::V1::ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :destroy, :update]

  def index
    @shifts = Shift.all.order(id: :desc)
    render json: @shifts
  end

  def create
    @shift = Shift.new(shift_params)
    if @shift.save
      render json: @shift
    else
      render json: { error: @shift.errors.full_messages }, status: 422
    end
  end

  def show
    if @shift
      render json: @shift
    else
      no_shift_found
    end
  end

  def update
    if @shift.update(shift_params)
      render json: @shift
    else
      no_shift_found
    end
  end

  def destroy
    if @shift&.destroy
      render json: { message: 'Shift deleted' }
    else
      no_shift_found
    end
  end

  private

  def shift_params
    params.require(:shift).permit(:shift_name, :work_date, :worker_id)
  end

  def set_shift
    @shift = Shift.find_by(id: params[:id])
  end

  def no_shift_found
    render json: {error: 'Shift not found'}, status: 422
  end
end

class Api::V1::ShiftsController < ApplicationController
  def index
    @shifts = Shift.all
    render json: @shifts
  end

  def create
    @shift = Shift.new(shift_params)
    if @shift.save
      render json: @shift
    else
      render json: { error: @shift.errors }, status: 400
    end
  end

  def show
    if @shift
      render json: @shift
    else
      no_shift_found
    end
  end

  def destroy
    if @shift&.destroy
      render json: { message: 'Shift record deleted successfully' }
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
    render json: {error: 'Shift doesn\'t exist. Perhaps a typo?'}, status: 400
  end
end

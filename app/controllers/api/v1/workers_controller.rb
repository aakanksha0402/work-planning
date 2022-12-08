class Api::V1::WorkersController < ApplicationController
  before_action :set_worker, only: [:show, :destroy]

  def index
    @workers = Worker.all
    render json: @workers
  end

  def create
    @worker = Worker.new(worker_params)
    if @worker.save
      render json: @worker
    else
      render json: { error: @worker.errors }, status: 400
    end
  end

  def show
    if @worker
      render json: @worker
    else
      no_worker_found
    end
  end

  def destroy
    if @worker&.destroy
      render json: { message: 'Worker record deleted successfully' }
    else
      no_worker_found
    end
  end

  private

  def worker_params
    params.require(:worker).permit(:name)
  end

  def set_worker
    @worker = Worker.find_by(id: params[:id])
  end

  def no_worker_found
    render json: {error: 'Worker doesn\'t exist. Perhaps a typo?'}, status: 400
  end
end

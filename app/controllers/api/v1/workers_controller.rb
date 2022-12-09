class Api::V1::WorkersController < ApplicationController
  before_action :set_worker, only: [:show, :destroy, :update]

  def index
    @workers = Worker.all.order(id: :desc)
    render json: @workers
  end

  def create
    @worker = Worker.new(worker_params)
    if @worker.save
      render json: @worker
    else
      render json: { error: @worker.errors.full_messages }, status: 400
    end
  end

  def show
    if @worker
      render json: @worker
    else
      no_worker_found
    end
  end

  def update
    if @worker.update(worker_params)
      render json: @worker
    else
      render json: { error: @worker.errors.full_messages }, status: 400
    end
  end

  def destroy
    if @worker&.destroy
      render json: { message: 'Worker deleted' }
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
    render json: {error: 'Worker not found'}, status: 404
  end
end

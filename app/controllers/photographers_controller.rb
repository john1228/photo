class PhotographersController < ApplicationController
  before_action :photographer, only: [:appointment, :show]

  def index
    render json: {
               code: 1,
               data: {
                   photographers: Photographer.category(params[:category]).page(params[:page]).collect { |photographer| photographer.detail }
               }
           }

  end

  def show
    render json: {
               code: 1,
               data: {
                   photograper: {
                       works: @photographer.works.category.page(params[:page]||1).collect { |works| works.detail }
                   }
               }
           }
  end

  def appointment
    render json: {
               code: 1,
               data: {
                   appointment: @photographer.appointments
               }
           }
  end

  private
  def photographer
    @photographer = Photographer.find_by(id: params[:id])
    render json: {code: 0, message: '摄影师不存在'} if @photographer.nil?
  end
end

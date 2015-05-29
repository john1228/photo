class WorksController < ApplicationController

  def index
    render json: {
               code: 1,
               data: {
                   works: Works.category.page(params[:page]).map { |work| work.detail }
               }
           }
  end

  def show
    render json: {
               code: 1,

           }
  end

  def category
    render json: {
               code: 1,
               data: {
                   ages: Works::AGE,
                   types: Works::TYPE
               }
           }
  end


  def search
    conditions = {}
    conditions = conditions.merge(photograper_id: Photographer.where('name like ?', "%#{params[:keyword]}%").pluck(:id)) unless params[:keyword].blank?
    conditions = conditions.merge(age: params[:age]) unless params[:age].blank?
    conditions = conditions.merge(works_type: params[:type]) unless params[:type].blank?
    render json: {
               code: 1,
               data: {
                   works: Works.where(conditions).page(params[:page]||1).collect { |works| works.detail }
               }
           }
  end

  private
  def photographer
    Photographer.find_by(id: params[:photographer])
  end
end

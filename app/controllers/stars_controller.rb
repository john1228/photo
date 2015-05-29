class StarsController < ApplicationController
  def index
    render json: {
               code: 1,
               data: {
                   children: ChildStar.page(params[:page]||1).collect { |child_star| child_star.detail }
               }
           }
  end

  def create
    child_star = ChildStar.new(child_star_params)
    if child_star.save
      (0..3).map do |index|
        child_star.child_photos.create(photo: params[index.to_s.to_sym])
      end
      render json: {code: 1}
    else
      render json: {code: 0, message: '宝贝报名失败'}
    end
  end

  def category
    render json: {
               code: 1,
               data: {
                   categories: ChildStar::CATEGORY
               }
           }
  end

  def search
    results = ChildStar.where('1=1')
    unless params[:keyword].blank?
      results = ChildStar.where('name like ? or nickname like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end
    unless params[:category].blank?
      results = results.where(get_query_string(params[:category]))
    end
    render json: {
               code: 1,
               data: {
                   child: results.page(params[:page]||1).collect { |child_star| child_star.detail }
               }
           }
  end

  private
  def child_star_params
    params.permit(:name, :nickname, :country, :gender, :nation, :height, :weight, :birthday, :city, :price)
  end

  def get_query_string(category)
    case category
      when ChildStar::CATEGORY[0]
        "(birthday between '#{Date.today.prev_year}' and '#{Date.today}') and gender = 0"
      when ChildStar::CATEGORY[1]
        "(birthday between '#{Date.today.prev_year(3)}' and '#{Date.today.prev_year(1)}') and gender = 0"
      when ChildStar::CATEGORY[2]
        "(birthday between '#{Date.today.prev_year(6)}' and '#{Date.today.prev_year(3)}') and gender = 0"
      when ChildStar::CATEGORY[3]
        "birthday < '#{Date.today.prev_year(6)}' and gender = 0 "
      when ChildStar::CATEGORY[4]
        "(birthday between '#{Date.today.prev_year}' and '#{Date.today}') and gender = 1"
      when ChildStar::CATEGORY[5]
        "(birthday between '#{Date.today.prev_year(3)}' and '#{Date.today.prev_year(1)}') and gender = 1"
      when ChildStar::CATEGORY[6]
        "(birthday between '#{Date.today.prev_year(6)}' and '#{Date.today.prev_year(3)}') and gender = 1"
      when ChildStar::CATEGORY[7]
        "birthday < '#{Date.today.prev_year(6)}' and gender = 1"
      else
        ''
    end
  end
end

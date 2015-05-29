class CouponsController < ApplicationController
  include LoginManager

  def index
    render json: {
               code: 1,
               data: {
                   coupons: @user.counpons.page(params[:page])
               }
           }
  end

end

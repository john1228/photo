class OrdersController < ApplicationController
  before_action :verify_auth_token

  def index
    case params[:list]
      when 'process'
        hour = Time.now.hour
        if hour>=9 && hour<< 12
          appoint_time = 0
        elsif hour>13 && hour <18
          appoint_time = 1
        else
          appoint_time = 2
        end
        render json: {
                   code: 1,
                   data: {
                       orders: @user.orders.pay.where(
                           appoint_date: Date.today,
                           appoint_time: appoint_time
                       ).map { |order| order.detail }
                   }
               }
      when 'comment'
        render json: {
                   code: 1,
                   data: {orders: @user.orders.done.order(id: :desc).page(params[:page]||1).collect { |order| order.detail }}
               }
      else
        render json: {
                   code: 1,
                   data: {orders: @user.orders.where.not(status: Order.statuses['deleted']).order(id: :desc).page(params[:page]||1).collect { |order| order.detail }}
               }
    end


  end


  def create
    works = Works.find_by(id: params[:id])
    if works.blank?
      render json: {code: 0, message: '添加订单失败'}
    else
      order = @user.orders.unpaid.new(
          photographer_id: works.photographer.id,
          works_id: works.id,
          appoint_date: params[:date], appoint_time: params[:time], appoint_address: params[:address],
          contact: params[:contact], phone: params[:phone], baby_name: params[:name], baby_gender: params[:gender],
          baby_birthday: params[:birthday], coupons: params[:coupons],
          price: works.discount
      )
      if order.save
        render json: {code: 1, data: {order: order.detail}}
      else
        render json: {code: 0, message: '添加订单失败'}
      end
    end
  end


  def show
    order = @user.orders.find_by(order_no: params[:no])
    render json: {
               code: 1,
               data: order.detail
           }
  end

  def delete
    order = @user.orders.find_by(order_no: params[:no])
    if order.deleted!
      render json: {code: 1}
    else
      render json: {code: 0, message: '该订单无法删除'}
    end
  end

  private
  def verify_auth_token
    @user = Rails.cache.fetch(request.headers[:token])
    render json: {code: -1, message: '您还没有登录'} if @user.nil?
  end
end

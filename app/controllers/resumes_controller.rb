class ResumesController < ApplicationController
  def create
    resume = Resume.new(resume_params)
    if resume.save
      render json: {code: 1}
    else
      render json: {code: 0, message: '递交简历失败'}
    end
  end

  private
  def resume_params
    params.permit(:name, :phone, :city, :exp, :salary, :opened, :target)
  end
end

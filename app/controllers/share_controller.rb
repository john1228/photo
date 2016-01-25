class ShareController < ApplicationController
  layout 'share'

  def child
    @child = ChildStar.find_by(id: params[:id])
  end
end

class DeployController < ApplicationController
  def index
    render json: {
               code: 1,
               banner: {
                   home: Banner.home.map{|banner|
                     {

                     }
                   },
                   child: {

                   }
               }
           }
  end
end

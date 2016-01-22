class DeployController < ApplicationController
  def index
    render json: {
               code: 1,
               banner: {
                   home: Banner.home.where('start_date <= ? and end_date >= ?', Date.today, Date.today).map { |banner|
                     {
                         image: banner.image.url,
                         url: banner.url,
                     }
                   },
                   child: Banner.child.where('start_date <= ? and end_date >= ?', Date.today, Date.today).map { |banner|
                     {
                         image: banner.image.url,
                         url: banner.url,
                     }
                   }
               }
           }
  end
end

class Admin::TapeSubscriptionsController < Admin::BaseController
  mongosteen

  def new
    url          = params['url']
    subscription = TapeDiscoveryService.new(url).fetch_subscription

    if not subscription
      render nothing: true

    else
      render json: subscription

    end
  end

end

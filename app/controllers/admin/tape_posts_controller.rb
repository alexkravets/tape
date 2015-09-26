class Admin::TapePostsController < Admin::BaseController
  mongosteen

  def new
    TapeSubscriptionsService.new.fetch()
    render nothing: true
  end

end

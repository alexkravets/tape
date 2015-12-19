module ActionDispatch::Routing
  class Mapper
    def mount_tape_subscriptions_crud
      resources :tape_subscriptions, controller: 'tape_subscriptions'
    end

    def mount_tape_posts_crud
      resources :tape_posts, controller: 'tape_posts'
    end
  end
end

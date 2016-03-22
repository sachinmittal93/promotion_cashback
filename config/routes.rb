Rails.application.routes.draw do
  mount Spree::Core::Engine, at: '/'
  Spree::Core::Engine.routes.draw do
    namespace :admin do
      resources :orders, except: [:show] do
        resources :promotion_cashbacks do
          member do
            put 'change_state'
          end
        end
      end
    end
  end
end

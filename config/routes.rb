Rails.application.routes.draw do
  root to: 'homes#top'

  # 会員関連のルーティング(deviseの不要なルーティングはskipで飛ばしている)
  devise_for :groups, skip: [:passwords], controllers: {
    sessions: 'groups/sessions',
    registrations: 'groups/registrations'
  }
  devise_for :residents, skip: [:passwords], controllers: {
    sessions: 'residents/sessions',
    registrations: 'residents/registrations'
  }
  # 会員から他の会員の詳細ページなどは見れなくてもいいのでresourceで実装
  resource :resident, only: %i[edit show update]
  patch 'resident/withdrawal' => 'residents#withdrawal', as: 'resident_withdrawal'

  resource :group, only: %i[edit show update]
  patch 'group/withdrawal' => 'groups#withdrawal', as: 'group_withdrawal'
  get 'groups/index' => 'groups#index', as: 'groups'

  # 投稿機能のためのルーティング
  resources :cats do
    resources :comments, only: %i[create destroy]
  end

  # 対応機能のためのルーティング
  resources :handles, only: [:edit, :update]
  patch 'handles/:id/status' => 'handles#status', as: 'handle_status'
  patch 'handles/:id/failed' => 'handles#failed', as: 'handle_failed'

  # 通知機能ためのルーティング
  resources :notices, only: [:index, :update]

  # 検索のためのルーティング
  get '/searchs/cats' => 'searchs#cats', as: 'search_cats'
  post '/searchs/groups' => 'searchs#groups', as: 'search_groups'
  post '/searchs/group_cats' => 'searchs#group_cats', as: 'search_group_cats'
end

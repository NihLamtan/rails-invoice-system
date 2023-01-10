Rails.application.routes.draw do

  resources :reports
  devise_for :super_admins

authenticated :user do
  # super admin routes starts here
  namespace :super_admin do

    resources :clients
    resources :companies do
      member do
          get 'paypal'
          get 'clients'
          get 'paypal_refund'
          get 'users'

      end
    end
    resources :users
    resources :company_sales_targets 
    resources :user_sales_targets
    resources :third_party_integrations
    

    resources :invoices do
      member do
        patch 'send_invoice'
        post 'pay'
      end
    end

    
    patch 'trash', to: "invoices#trash_invoice"
    get 'dashboard', to: "dashboard#index"
    get 'company-total-sales', to: "dashboard#company_sale"
    root to: "dashboard#index"
    get 'setting', to: "dashboard#setting"
    patch 'add-company', to: "user_add_multiple_company"

  end
  # super admin routes end here
end

  resources :items
  root to: "dashboard#index"
  resources :payments
  resources :invoices do
    member do
      post 'send_invoice'
      post 'pay'
      patch 'trash', to: "invoices#trash_invoice"

  end


    collection do
      get 'export'
      get :approved
      get :pending
      get :rejected
    end


    resources :refund, only: [:create]

  end
  get 'invoice/:payment_link', to: "checkout#index"
  get 'invoice_view/:payment_link', to: "checkout#invoice"


  post 'invoice', to: "checkout#create"

  # resources :checkout, only: [:create, :index]

  devise_for :users, :path_prefix => 'my'
  resources :companies
  resources :clients
  resources :excel, only: [:index]
  resources :invoicesexcel, only: [:index]
  resources :dashboard, only: [:index]

  resources :users, only: [:new, :create, :index, :edit, :update, :destroy]

  resources :reports

  resources :users
  resources :company_sales_targets
  resources :user_sales_targets



  get 'load_payment', to: "checkout#load_payment"
  get 'thankyou', to: "checkout#thankyou"


  get 'refunded', to: "status#refunded_payment"
  get 'success_payment', to: "status#success_payment"
  get 'refunded', to: "status#refunded_payment"
  get "stripe/connect", to: "connect_stripe_account#connect"
  get "download", to: "report#download"

  patch "company_change", to: "dashboard#cookies_update_id"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

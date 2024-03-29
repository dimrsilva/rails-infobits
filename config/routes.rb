Infobits::Application.routes.draw do
  devise_for :users, :class_name => "Admin::User"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  scope :path_names => {:new => "novo", :create => "criar", :edit => "editar"} do
    namespace :admin do
        resources :users, :except => :show
    end

    namespace :contacts, :path => 'contatos', :as => 'contact' do
        resources :people, :path => 'pessoas'
        resources :companies, :path => 'empresas'
        resources :groups, :path => 'grupos'
    end

    scope :module => "contacts" do
      resources :contacts, :path => 'contatos', :as => 'contact_contacts'
    end

    namespace :projects, :path => 'projetos' do
      resources :statuses
      resources :task_statuses
    end

    scope :module => "projects" do
      resources :projects, :path => 'projetos', :as => 'projects_projects' do
        member do
          get :burndown
        end
        resources :tasks, :path => 'tarefas', :as => 'projects_tasks', :except => [:show, :index] do
          collection do
            post :batch_update
          end
        end
      end
    end
  end

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'projects::projects#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  match 'templates(/:action(/:id))(.:format)', :controller => :templates
end

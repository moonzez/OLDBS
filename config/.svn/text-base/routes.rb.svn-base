ActionController::Routing::Routes.draw do |map|
 
  map.simple_captcha '/simple_captcha/:action', :controller => 'simple_captcha'
  
  map.resources :archives, :collection => {:neweng => :get }
 
  map.resources :htseminars, :collection => { :newfr => :get, :newit => :get, :opened => :get, :approved => :get, 
    :denial => :get, :storno => :get, :newintern => :get, :neweng => :get, :download_form => :get, :hts_pdf => :get, :future => :get, 
    :timechoice =>:get, :bill => :get, :search => :get, :show_bill => :get, :set_paid_external => :get }

  map.resources :referents, :collection => {:events => :get, :eventpast => :get, :eventstimechoice => :get,
    :topay => :get, :inaktivref => :get, :zahlen_otour => :get, :nicht_zahlen_otour => :get, :referents_invoices => :get,
    :stornoevents => :get, :topaytime => :get, :pay_event => :get, :no_pay_event => :get }

  map.resources :detours, :collection=> { :newit => :get, :newfr => :get, :neweng => :get ,:newintern => :get, :download_form_de => :get ,
    :download_form_eng => :get ,  :tour_pdf => :get,  :approved => :get, :opened => :get, :denial => :get, :storno => :get,
    :future => :get, :timechoice =>:get, :bill => :get, :bill_eng => :get, :add_referents => :get, :search => :get, :show_bill => :get,
    :themennew => :get, :themennewint => :get, :add_topic => :get, :add_new_topic => :get, :delete_topic => :get,
    :set_paid_external => :get }
  
  map.resources :workshops, :collection => {:download_form => :get, :workshop_pdf => :get, :newintern => :get,
    :approved => :get, :opened => :get, :denial => :get, :storno => :get, :future => :get, :timechoice =>:get, :bill => :get,
    :search => :get, :show_bill => :get, :set_paid_external => :get  }

  map.resources :ts_requests, :collection => {:download_form => :get, :ts_pdf => :get, :newintern => :get,
    :approved => :get, :opened => :get, :denial => :get, :storno => :get, :future => :get, :timechoice =>:get, :bill => :get,
    :search => :get, :show_bill => :get, :add_topic => :get, :add_new_topic => :get, :set_paid_external => :get }
  
  map.resources :users, :collection => {:index => :get, :referees => :get, :newref => :get }

  map.resource :session

  map.resources :dbusers,:collection => { :download_quide => :get, :stat => :get, :readerkalendheute => :get, :readerkalendzeitraum => :get, :kalendaktuell => :get, :kalenddatum => :get, :kalendzeitraum => :get, :kalendindex => :get  }

  map.resources :administrators, :collection => { :clean => :get, :download_quide => :get, :test => :get }
  
 map.resources :opentours, :collection => { :sight => :get, :selectotour => :get, :new => :get, :sendrefmail => :get, :referent_otour => :get }
 map.resources :referees, :collection => { :sightot => :get, :opentours => :get, :opent => :get, :detours => :get, :ts_requests => :get, :hts_requests => :get, :workshops => :get  }


map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil

map.signup '/signup',  :controller => 'users', :action => 'new'

map.login '/login', :controller => 'sessions', :action => 'new'

map.logout '/logout', :controller => 'sessions', :action => 'destroy'

 


  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.match '*path', :controller => 'errors', :action => 'index'
end

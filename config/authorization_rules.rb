authorization do
  role :admin do
    has_permission_on [:users], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  end
  
  role :user do
    has_permission_on [:users], :to => [:show, :edit, :update] do
       if_attribute :id => is { user.id }
     end
  end
  
  role :guest do
    has_permission_on [:users], :to => [:new, :create]
  end
end
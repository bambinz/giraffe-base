authorization do
  role :admin do
    has_permission_on [:users], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on [:notifications], :to => [:index, :show, :edit, :update, :mark_as_seen, :mark_as_read, :mark_all_as_read]
  end

  role :user do
    has_permission_on [:users], :to => [:show, :edit, :update] do
      if_attribute :id => is { user.id }
    end
    has_permission_on [:notifications], :to => [:index, :show, :edit, :update, :mark_as_seen, :mark_as_read, :mark_all_as_read]
  end

  role :guest do
    has_permission_on [:users], :to => [:new, :create]
  end
end
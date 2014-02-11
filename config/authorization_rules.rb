authorization do
  role :admin do
    has_permission_on [:users], to: [:index, :show, :new, :create, :edit, :update, :destroy, :search_users_window, :search_users]
    has_permission_on [:notifications], to: [:index, :show, :edit, :update, :mark_as_seen, :mark_as_read, :mark_all_as_read]
    has_permission_on [:key_requests], to: [:list_friend_requests, :send_friend_request, :accept_friend_request, :ignore_friend_request, :remove_friend_request]
    has_permission_on [:user_friends], to: [:remove_friend]
  end

  role :user do
    has_permission_on [:users], to: [:edit, :update] do
      if_attribute id: is { user.id }
    end
    has_permission_on [:users], to: [:list_friends, :show_friend, :search_users_window, :search_users, :show]
    has_permission_on [:notifications], to: [:index, :show, :edit, :update, :mark_as_seen, :mark_as_read, :mark_all_as_read]
    has_permission_on [:key_requests], to: [:list_friend_requests, :send_friend_request, :accept_friend_request, :ignore_friend_request, :remove_friend_request]
    has_permission_on [:user_friends], to: [:remove_friend]
  end

  role :guest do
    has_permission_on [:users], to: [:new, :create]
  end
end
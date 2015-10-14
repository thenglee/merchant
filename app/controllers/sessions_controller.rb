class SessionsController < ApplicationController
  def create
  	@user = User.find_or_create_by_auth(request.env["omniauth.auth"])
  	session[:user_id] = @user.id

    pending_order = get_pending_order

    if session[:order_id]
      # An order currently exists in session
      if pending_order
        # User has a previous pending order

      else
        # User has no previous pending order, assign the order currently in the session to user

      end
    else
      # No order currently in session
      if pending_order
        # User has a previous pending order
        @order = pending_order
      else
        # User has no previous pending order, create a new pending order
        @order = @user.orders.create(status: "unsubmitted")
      end
      session[:order_id] = @order.id
    end

  	# load_order
  	# @order.update_attributes(user: @user)
  	redirect_to products_path, notice: "Logged in as #{@user.name}"
  end

  def destroy
    session[:user_id] = nil
    session[:order_id] = nil
    redirect_to root_path, notice: "Goodbye!"
  end


  private
    def get_pending_order
      last_order = @user.orders.last

      if last_order
        if last_order.status == "unsubmitted"
          return last_order
        end
      end
    end

end

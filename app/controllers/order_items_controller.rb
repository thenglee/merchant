class OrderItemsController < ApplicationController
  before_action :load_order, only: [:create]
  before_action :set_order_item, only: [:edit, :destroy]
  # this functions only checks whether the quatity is, only: [:create, :update]

  def index
    @order_items = OrderItem.all
  end

  # GET /order_items/1/edit
  def edit
  end

  # POST /order_items
  # POST /order_items.json
  def create
    @order_item = @order.order_items.find_or_initialize_by(product_id: params[:product_id])
    if @order_item.get_from_product_stock(params[:product_id], 1)
      respond_to do |format|
        format.html { redirect_to @order, notice: 'Successfully added product to cart.' }
        format.json { render :show, status: :created, location: @order_item }
      end
    else
      respond_to do |format|
        format.html { redirect_to @order, notice: 'Unable to add product to cart.' }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_items/1
  # PATCH/PUT /order_items/1.json
  def update
    @order_item = OrderItem.find(params[:id])

    # check = check_remaining_quantity
    # if check[:status] == "OK"
    # else
    # end

    new_quantity = params[:order_item][:quantity].to_i
    current_quantity = @order_item.quantity
    product = @order_item.product

    # Update the product's stock
    # product.stock -= new_quantity - current_quantity 

    if new_quantity == 0
      # Update the product's stock
      product.stock += current_quantity
      product.save

      # Delete the order item
      @order_item.destroy
      redirect_to order_path(id: session[:order_id]), notice: 'Item was removed from cart.'
    elsif new_quantity > (product.stock + current_quantity)
      flash[:notice] = 'Sorry. There is not enough stock available. Please specify another quantity.'
      render :edit
    else
      # Update the product's stock
      product.stock -= new_quantity - current_quantity 

      # Update the order item quantity
      @order_item.quantity = new_quantity

      product.save
      @order_item.save
      redirect_to order_path(id: session[:order_id]), notice: 'Successfully updated the order item.' 

      ## Product should not save if [product.stock - (new quantity - current quantity)] < 0
      ## Validation by Product model
        ## cannot use -> if @order_item.save && product.save
        ## can use -> if product.save && @order_item.save
        ## can use -> if product.save  
    end
  end

  # DELETE /order_items/1
  # DELETE /order_items/1.json
  def destroy
    product = @order_item.product
    product.stock += @order_item.quantity
    product.save

    @order_item.destroy

    respond_to do |format|
      format.html { redirect_to order_path(id: session[:order_id]), notice: 'Order item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_item_params
      params.require(:order_item).permit(:product_id, :order_id, :quantity)
    end

    def check_remaining_quantity
      # this functions only checks whether the quatity is
      #desired_quantity = params[:order_item][:quantity].to_i
      #available_quantity = ???
      if desired_quantity > available_quantity
        # option 1: make desired quantity = available quantity?
        # option 2: fail the transaction and show error to user
          # flash[:errors] = "Insufficient quantity"
        return {status: "FAILURE", message: "Insufficient quantity"}
      else
        return {status: "OK"}
      end      
    end
end

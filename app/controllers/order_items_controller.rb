class OrderItemsController < ApplicationController
  before_action :load_order, only: [:create]
  before_action :set_order_item, only: [:edit, :update, :destroy]
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
    new_quantity = params[:order_item][:quantity].to_i
    current_quantity = @order_item.quantity

    if new_quantity == 0
      if @order_item.return_order_item_to_product
        respond_to do |format|
          format.html { redirect_to @order_item.order, notice: 'Order item was successfully removed.' }
          format.json { head :no_content }
        end
      else
        respond_to do |format|
          format.html do
            flash[:notice] = 'There was an error in removing the item.'
            render :edit
          end
          format.json { head :no_content }
        end
      end
    else
      if @order_item.get_from_product_stock(@order_item.product_id, new_quantity - current_quantity)
        respond_to do |format|
          format.html { redirect_to @order_item.order, notice: 'Successfully updated item quantity.' }
          format.json { render :show, status: :created, location: @order_item }
        end
      else
        respond_to do |format|
          format.html do
            flash[:notice] = 'Unable to update item quantity.'
            render :edit
          end
          format.json { render json: @order_item.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /order_items/1
  # DELETE /order_items/1.json
  def destroy
    if @order_item.return_order_item_to_product
      respond_to do |format|
        format.html { redirect_to order_path(id: session[:order_id]), notice: 'Order item was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to order_path(id: session[:order_id]), notice: 'There was an error in removing the item.' }
        format.json { head :no_content }
      end
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
end

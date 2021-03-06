class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :confirm]
  before_action :check_order_status, only: [:show, :edit]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    #if params[:order] && @order.update(order_params.merge(status: "submitted"))
    if @order.update(order_params.merge(status: "submitted"))
      session[:order_id] = nil
      respond_to do |format|
        format.html { redirect_to confirm_order_path(@order), notice: 'Thank you. Your order has been confirmed.' }
        format.json { render :show, status: :ok, location: @order }
      end
    else
      respond_to do |format|
        # puts "\n==========\n#{@order.errors.inspect}\n==========\n"
        format.html { render :show, notice: @order.errors }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.clear_order
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Your cart is now empty.' }
      format.json { head :no_content }
    end
  end

  # GET /orders/1/confirm
  def confirm
  end

  # GET /orders/empty
  def empty
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:user_id, :status, :address_id)
    end

    def check_order_status
      if @order.status == "submitted"
        redirect_to confirm_order_path(@order)
      end
    end
end

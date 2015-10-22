require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe "GET #all_products" do
    it "responds successfully" do
      get :all_products

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :all_products

      expect(response).to render_template("all_products")
    end

    it "returns all the products" do
      p1 = Product.create(title: "Product 1", price: 10, description: "product 1 text", image_url: "img1.png", stock: 10)
      p2 = Product.create(title: "Product 2", price: 20, description: "product 2 text", image_url: "img2.png", stock: 20)

      get :all_products

      expect(assigns(:products)).to include(p1)
      expect(assigns(:products)).to include(p2)
    end

    it "returns all the products in decreasing stock quantities" do
      p1 = Product.create(title: "Product 1", price: 10, description: "product 1 text", image_url: "img1.png", stock: 10)
      p2 = Product.create(title: "Product 2", price: 20, description: "product 2 text", image_url: "img2.png", stock: 20)

      get :all_products

      expect(assigns(:products)).to eq([p2, p1])
    end
  end

  describe "POST #create" do
    describe "failure" do
      it "should not create a new product with missing mandatory attributes" do
        expect {
          post :create, product: { title: "Product" }
        }.to_not change(Product, :count)
      end

      it "should re-render the new template" do
        post :create, product: { title: "Product" }
        expect(response).to render_template("new")
      end

      it "should contain the errors" do
        post :create, product: { title: "Product" }
        expect(assigns(:product).errors.empty?).to be false
      end
    end

    describe "success" do
      it "should create a new product" do
        expect {
          post :create, product: { title: "Product", price: 10, description: "product text", image_url: "img1.png", stock: 10 }
        }.to change(Product, :count).by(1)
      end

      it "should redirect to the new product" do
        post :create, product: { title: "Product", price: 10, description: "product text", image_url: "img1.png", stock: 10 }
        expect(response).to redirect_to Product.last
      end
    end
  end
end

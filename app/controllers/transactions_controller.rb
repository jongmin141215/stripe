class TransactionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @product = Product.find_by!(permalink: params[:permalink])
  end

  def create
    @product = Product.find_by!(permalink: params[:permalink])
    begin
      charge = Stripe::Charge.create(
        amount: @product.price,
        currency: 'usd',
        description: params[:stripeEmail],
        source: params[:stripeToken]
      )
      @sale = @product.sales.create(
        email: params[:stripeEmail],
        stripe_id: charge.id
      )
      redirect_to pickup_path(guid: @sale.guid)
    rescue Stripe::CardError => e
      @error = e
      render :new
    end
  end
end

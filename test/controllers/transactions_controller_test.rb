require 'test_helper'

class TransactionsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should post create" do
    product = Product.create(permalink: 'test_product',
                             price: 100)
    email = 'test@test.com'
    token = 'tok_test'

    post :create, email: email, stripeToken: token, permalink: product.permalink

    assert_not_nil assigns(:sale)
    assert_not_nil assigns(:sale).stripe_id
    assert_equal product.id, assigns(:sale).product_id
    assert_equal email, assigns(:sale).email
  end
end

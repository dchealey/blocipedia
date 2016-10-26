class ChargesController < ApplicationController
  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
 
  Stripe::Charge.create(
    customer: customer.id, # Note -- this is NOT the user_id in your app
    amount: 00_01,
    description: "Upgrade to Premium",
    currency: 'usd'
  )
 
  @user.update_attributes(role: 'premium')
 
  flash[:notice] = "Thank you,! You have upgraded your account to premium."
  redirect_to user_path(current_user)
 
  # Stripe will send back CardErrors, with friendly messages
  # when something goes wrong.
  # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Premium Membership",
      amount: 00_00
    }
  end

  private

  def upgrade_user_role
    @user.role = 'premium'
  end

end
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates :first_name, :last_name, :email, :password, presence: true
  has_one :profile
         
  belongs_to :plan
  attr_accessor :stripe_card_token
         
  # def full_name
  #   return "#{first_name} #{last_name}".strip if (first_name || last_name)
  #   "Anonymous"
  # end
  
  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(
        :source => stripe_card_token,
        :email => email,
        :plan => plan_id
      )
      
      self.stripe_customer_token = customer.id
      save!
    end
  end
  
end

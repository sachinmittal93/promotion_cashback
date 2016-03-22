Spree::Order.class_eval do
  has_many :promotion_cashbacks, class_name: 'Spree::PromotionCashback', dependent: :destroy
end

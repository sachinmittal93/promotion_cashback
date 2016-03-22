module Spree
  class Promotion
    module Actions
      class StoreCreditAdjustment < Spree::PromotionAction

        include Spree::CalculatedAdjustments

        has_many :promotion_cashbacks, class_name: 'Spree::PromotionCashback', as: :promotion_action, dependent: :destroy

        before_validation -> { self.calculator ||= Calculator::FlatPercentItemTotal.new }

        def perform(payload = {})
          order = payload[:order]
          !!order.promotion_cashbacks.create(promotion_action: self)
        end
      end
    end
  end
end

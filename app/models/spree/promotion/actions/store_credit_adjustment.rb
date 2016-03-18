module Spree
  class Promotion
    module Actions
      class StoreCreditAdjustment < Spree::PromotionAction
        include Spree::CalculatedAdjustments

        before_validation -> { self.calculator ||= Calculator::FlatPercentItemTotal.new }

        def perform(payload = {})
          order = payload[:order]
          Spree::StoreCredit.new(
            user: order.user,
            created_by: order.user,
            category_id: 1,
            currency: order.currency,
            amount: calculator.compute(order).to_f
          ).save
        end
      end
    end
  end
end

module Spree
  module Admin
    class PromotionCashbacksController < ResourceController

      belongs_to 'spree/order', find_by: :number
      before_action :load_promotion_cashback, only: :change_state

      def index
        @promotion_cashbacks = @order.promotion_cashbacks.order(created_at: :asc)
      end

      def change_state
        params[:accept] ? @promotion_cashback.complete : @promotion_cashback.cancel
      end

      private

        def load_promotion_cashback
          @promotion_cashback = parent.promotion_cashbacks.find(params[:id])
        end

    end
  end
end

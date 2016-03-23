module Spree
  class PromotionCashback < Spree::Base
    belongs_to :order, class_name: 'Spree::Order'
    belongs_to :promotion_action, polymorphic: true

    has_many :state_changes, as: :stateful

    scope :pending, -> { with_state('pending') }
    scope :completed, -> { with_state('completed') }
    scope :canceled, -> { with_state('canceled') }

    state_machine initial: :pending do

      event :complete do
        transition from: :pending, to: :completed
      end

      event :cancel do
        transition from: :pending, to: :canceled
      end

      before_transition to: :completed, do: :add_promotion_cashback

      after_transition do |promotion_cashback, transition|
        promotion_cashback.state_changes.create!(
          previous_state: transition.from,
          next_state:     transition.to,
          name:           'promotion_cashback',
        )
      end

    end

    def add_promotion_cashback
      Spree::StoreCredit.create(
            user: order.user,
            created_by: order.user,
            category_id: 1,
            currency: order.currency,
            amount: promotion_action.compute_amount(order)
          )
    end
  end
end

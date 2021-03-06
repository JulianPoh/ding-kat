class User < ApplicationRecord
    belongs_to :subscription, optional: true
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable
           # :confirmable, :lockable


    validate :end_date_is_after_start_date
    validates :postal_code, allow_nil: true, numericality: true

    private

    def end_date_is_after_start_date
        if subscription_end && subscription_start
            if subscription_end < subscription_start
                errors.add(:subscription_end, "END DATE HAS TO BE AFTER START DATE")
            end 
        end
    end
end
  
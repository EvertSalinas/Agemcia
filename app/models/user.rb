class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

   after_create :auto_confirm_development_user

   private

   def auto_confirm_development_user
     self.confirm if Rails.env.development?
   end
end

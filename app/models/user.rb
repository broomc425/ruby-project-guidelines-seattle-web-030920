class User < ActiveRecord::Base
    has_many :user_players
    has_many :players, through: :user_players
end
class Player < ActiveRecord::Base
    has_many :user_players
    has_many :users, through: :user_players
end

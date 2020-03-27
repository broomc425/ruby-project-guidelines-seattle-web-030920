class NBAPlayersApp

    def run
        welcome
        log_in_and_sign_up
        player_search
        menu_prompt
        user_menu_input
        player_watchlist
        exit_program
    end

    def welcome
        puts "Welcome to the NBA Players APP"
        puts "
        _   _ ____    _    
       | \\ | | __ )  / \\   
       |  \\| |  _ \\ / _ \\  
       | |\\  | |_) / ___ \\
       |_| \\_|____/_/   \\_\\
       
       "
    end

    def log_in_and_sign_up
        puts "Please enter your username"
        username = gets.strip
        @user = User.find_or_create_by(username: username)
        puts "-----------------------------------------"
    end

    def player_search
        puts "Enter your favorite player"
        player_search = gets.strip.split(" ").join("_")
        puts "-----------------------------------------"
        res = RestClient.get("https://www.balldontlie.io/api/v1/players?search=#{player_search}")
        player_hash = JSON.parse(res.body)
        player_hash["data"].map do |player|
            puts "#{player["first_name"]} #{player["last_name"]}"
        end
        if player_hash["data"].length > 1
            puts "-----------------------------------------"

            puts "Refine your search. Enter full player name"
            puts "-----------------------------------------"

            player_search = gets.strip.split(" ").join("_")
            res = RestClient.get("https://www.balldontlie.io/api/v1/players?search=#{player_search}")
            player_hash = JSON.parse(res.body)
            player_hash["data"].map do |player|
                puts "#{player["first_name"]} #{player["last_name"]}"
            end
        end
        puts "-----------------------------------------"
        puts "Enter season 1981-2019"
        puts "-----------------------------------------"
        input = gets.strip
        puts "-----------------------------------------"
        player_stats(input, player_hash["data"][0]["id"])
    end

    def player_stats(season, player_id)
        res = RestClient.get("https://www.balldontlie.io/api/v1/season_averages?season=#{season}&&player_ids[]=#{player_id}")
        stat_hash = JSON.parse(res.body)
        stat_hash["data"][0].map do |statistic, value|
            puts "#{statistic}: #{value}"
        end
        puts "-----------------------------------------"
    puts "          o
    /|   o         o
    \\|=--            o
       WW
                        \\
                    /   \\O
                    O_/   T
                    T    /|
                    |\\  | |
    _______________|_|_______________"
        puts "-----------------------------------------"
        puts "                ________
        o      |   __   |
          \\_ O |  |__|  |
       ____/ \\ |___WW___|
       __/   /     ||
                   ||
                   ||
    _______________||________________"
    menu_prompt(player_id)
    end
    puts "-----------------------------------------"

    def menu_prompt(player_id)
        puts "-----------------------------------------"
        puts ""
        puts "Enter # 1-4 to make selection:"
        puts""
        puts "1. Save Player to Watchlist"
        puts""
        puts "2. View Player Watchlist"
        puts""
        puts "3. Search for another Player"
        puts""
        puts "4. Exit APP"
        puts "-----------------------------------------"

        user_menu_input(player_id)
    end

    def user_menu_input(player_id)
        # puts ""
        input = gets.strip
        if input == "1"
            puts "-----------------------------------------"
            @player = Player.create(name: @name, player_id: player_id)
            @user_player = UserPlayer.create(user_id: @user.id, player_id: player_id)
            # @player.id
            puts "-----------------------------------------"
            menu_prompt(player_id)
        elsif input == "2"
            player_watchlist()
            user_menu_input(player_id)
        elsif input == "3"
            player_search()
            user_menu_input(player_id)
        elsif input == "4" || input == "exit"
            exit_program()
        else
            puts ""
            menu_prompt(player_id)
        end
    end

    def player_watchlist()
        Player.all.select do |players|
            puts "NBA"
        end
        puts "-----------------------------------------"

        puts "Press Enter for main menu"
    end

    def exit_program
        puts "-----------------------------------------"
        puts "Enjoy the Playoffs"
        puts "

        -|
      -' |
    -'   | __().
==========|'\\/   `.O__
                   \\ `,
                  _-^.
                  `.  `---,
                    :



______________________________________
///\\\///\\\///\\\///\\\///\\\///\\\///\\\///\\\///\\\\/

--------------------------------------
"
        exit
    end
end
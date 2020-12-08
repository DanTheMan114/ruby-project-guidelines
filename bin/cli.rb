require 'io/console'
require 'tty-prompt'
require 'pry'
require 'colorize'
require 'lolize'
require "tty-table"

class CLI


    attr_reader :prompt, :font
    attr_accessor :customer, :cart, :pid, :current_user

    def main_menu
        system 'clear'
        `say Welcome to The Cart`
        play_music('/Users/dantheman/Flatiron/code/ruby-project-guidelines-1/bin/bensound-thejazzpiano.mp3')
        #`say Welcome to The Cart`
        @font = TTY::Font.new
        @pastel = Pastel.new
        opener
        puts @pastel.cyan(@font.write("                                   Shopping        Cart !!"))
        puts "                             
    dMo                                     
        yMN`                                    
        :MM+                                    
         mMNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNh
         +MMs+++++++++++++++++++++++++++++++sMM+
         `MMy                               yMM`
          yMN`                             `NMy 
          :MM+                             /MM: 
           mMm-----------------------------dMm  
           +MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMo  
           `NMy``````````````````````````````   
            yMN`                                
            -MMdhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh+ 
             +yyyMMMMMMMdyyyyyyyyMMMMMMMdyyyys/ 
               `mMm+:/hMM:     `mMm+:/hMM/      
               /MM:   `NMy     :MM/    NMh      
               `mMm+:/hMN:     `dMNo:/hMM:      
                `+dNMNms.        +hNMMms. 
                \n".lines.map { |line| line.center(100) }.join("").cyan
        opener
        prompt = TTY::Prompt.new
        choices = ['🔹Login'.green ,'🔹Signup'.yellow, '🔹Exit'.red] # '🔹Update Name Info', '🔹Delete Account'
        choice = prompt.select("\n                                                      🔹Welcome to Shopping Cart, please make a selection🔹\n", choices) # do not use multi_select it leaves an octogon symble 

        if choice == '🔹Login'.green
            attempts = 0
            login(attempts)
        elsif choice == '🔹Signup'.yellow
            signup
        elsif choice == '🔹Exit'.red
            exit
        end
        #pid = fork{ system 'killall', '/Users/dantheman/Flatiron/code/ruby-project-guidelines-1/bin/bensound-thejazzpiano.mp3' }
        # pid = fork{ exec ‘killall’, “afplay” }
        #Process.kill "TERM", @pid 
        #switch_song
    end


    def switch_song
        Process.kill "TERM", @pid
        #@pid = fork{ exec ‘killall’, “afplay” }
    end 

    # def play_song2
    #    @pid = spawn('afplay','/Users/dantheman/Flatiron/code/ruby-project-guidelines-1/bin/Mario-coin-sound.mp3')
    # end


    def play_music(link)
        @pid = spawn('afplay',link)
        
    end



    def signup
        system 'clear'
        `say Please fill out the form below`
        puts "Enter user name"
        user_name = gets.chomp
        puts "Enter password"
        user_password = STDIN.noecho(&:gets).chomp
        if !Customer.exists?(name: user_name)
            Customer.create(name: user_name , password: user_password)
            @current_user = Customer.where(name: user_name, password: user_password)
            puts "Thank you for joining us for a fantastic shopping experience"
            sleep(1)
            shopping
        else
            puts "Oops! This user name is already taken!"
            `say Oops`
            prompt = TTY::Prompt.new
            choices = ['🔹Sign-Up With Different User Name'.green , '🔹Login'.yellow,'🔹Exit'.red] 
            choice = prompt.select("\n ? \n",choices)
            if choice == '🔹Login'.yellow
                attempts = 0
                login(attempts)
            elsif choice == '🔹Sign-Up With Different User Name'.green
                signup
            elsif choice == '🔹Exit'.red
                exit
            end
        end
        # accept user_name & password -> update the table with new user if user name is unique else retry
        # go to shopping method - TBD
    end


    def login(attempts=0)
        attempts = 0
        system 'clear'
        puts"
                                                  
                                                  
                   .-/+oooo+/-.                   
              `:sdNMMNmddddmNMMNds:`              
            :yNMms/-`        `-/smMNy:            
          /mMmo.                  .omMm/          
        -dMm/        -oyhhyo-        /mMd-        
       /NMy`       .dMMMMMMMMd.       `yMN/       
      /MM+        `NMMMMMMMMMMN`        +MM/      
     .NMs         -MMMMMMMMMMMM-         sMN.     
     sMN`          dMMMMMMMMMMd          `NMs     
     mMy           `oNMMMMMMNo`           yMm     
     MMo              -+oo+-              oMM     
     mMy             `.----.`             yMm     
     sMN`       -ohmMMMMMMMMMMmho-       `NMs     
     .NMs     :dMMMMMMMMMMMMMMMMMMd:     sMN.     
      /MMo   .MMMMMMMMMMMMMMMMMMMMMM.   oMM/      
       /NMy` :MMMMMMMMMMMMMMMMMMMMMM: `yMN/       
        .dMN+:MMMMMMMMMMMMMMMMMMMMMM:+NMd.        
          /mMNMMMMMMMMMMMMMMMMMMMMMMNMm/          
            :yNMMMMMMMMMMMMMMMMMMMMNy:            
              `:sdNMMMMMMMMMMMMNds:`              
                   .-/+oooo+/-.          \n    ".lines.map { |line| line.center(100) }.join("").magenta.bold
        if attempts < 3
            puts "Enter user name"
            user_name = gets.chomp
            puts "Enter password"
            user_password = STDIN.noecho(&:gets).chomp
            if Customer.exists?(name: user_name, password: user_password)
                @current_user = Customer.where(name: user_name, password: user_password)
                shopping
                return
            else
                puts "Invalid User Name or Password"
                attempts += 1
    
                prompt = TTY::Prompt.new
                choices = ['🔹Re-Login'.green ,'🔹Forgot User Name/Password'.yellow, '🔹Exit'.red] 
                choice = prompt.select("\n ? \n",choices)
                if choice == '🔹Re-Login'.green
                    login(attempts)
                elsif choice == '🔹Forgot User Name/Password'.yellow
                    puts "Sign-Up!"
                    signup
                elsif choice == '🔹Exit'.red
                    exit
                end
            end
        else
            puts "Maximum number of login attempts exceeded. Try again later!"
        end
    end

        # After 3 attempts - prints max login attempts over -> Advanced -> Do a timestamp-based entry
        # Forgot password
        # gets user_name & password -> check if password matches user_name in table else 1. Error Msg 2. Exit 3. Re-login 4. Reset Password -> Signup
        # shopping


    def shopping
        #puts 'yay'
        system 'clear'
        prompt = TTY::Prompt.new
        choices = [ '🔹View Profile'.blue, '🔹View Cart'.green, '🔹Get To Shopping'.yellow,'🔹Checkout'.white, '🔹Exit'.red]
        system 'clear'
        choice = prompt.select("\n                                                                           🔹Welcome Back!!🔹 \n", choices)
        if choice == '🔹View Profile'.blue
            profile
        elsif choice == '🔹View Cart'.green
            view_cart
        elsif choice == '🔹Get To Shopping'.yellow
            go_to_shopping
        elsif choice == '🔹Checkout'.white
            checkout
        elsif choice == '🔹Exit'.red
            exit
        end
    end


    def profile
        system 'clear'
        puts "
                                                  
                                                  
                   .-/+oooo+/-.                   
              `:sdNMMNmddddmNMMNds:`              
            :yNMms/-`        `-/smMNy:            
          /mMmo.                  .omMm/          
        -dMm/        -oyhhyo-        /mMd-        
       /NMy`       .dMMMMMMMMd.       `yMN/       
      /MM+        `NMMMMMMMMMMN`        +MM/      
     .NMs         -MMMMMMMMMMMM-         sMN.     
     sMN`          dMMMMMMMMMMd          `NMs     
     mMy           `oNMMMMMMNo`           yMm     
     MMo              -+oo+-              oMM     
     mMy             `.----.`             yMm     
     sMN`       -ohmMMMMMMMMMMmho-       `NMs     
     .NMs     :dMMMMMMMMMMMMMMMMMMd:     sMN.     
      /MMo   .MMMMMMMMMMMMMMMMMMMMMM.   oMM/      
       /NMy` :MMMMMMMMMMMMMMMMMMMMMM: `yMN/       
        .dMN+:MMMMMMMMMMMMMMMMMMMMMM:+NMd.        
          /mMNMMMMMMMMMMMMMMMMMMMMMMNMm/          
            :yNMMMMMMMMMMMMMMMMMMMMNy:            
              `:sdNMMMMMMMMMMMMNds:`              
                   .-/+oooo+/-.           \n  ".lines.map { |line| line.center(100) }.join("").magenta.bold
        prompt = TTY::Prompt.new
        choices = ['🔹Reset User Name'.magenta ,'🔹Reset Password'.cyan, '🔹Delete Account'.red,'🔹Exit'.yellow] 
        choice = prompt.select("\n ‼️Profile Screen‼️ \n",choices)
        if choice == '🔹Reset User Name'.magenta
            puts "Enter new user name"
            user_name = gets.chomp
            Customer.update_attribute(name, user_name)
        elsif choice == '🔹Reset Password'.cyan
            puts "Enter new password"
            user_password = STDIN.noecho(&:gets).chomp
            Customer.update_attribute(password, user_password)
        elsif choice == '🔹Delete Account'.red
            puts "Enter your user name"
            user_name = gets.chomp
            puts "Enter your password"
            user_password = STDIN.noecho(&:gets).chomp
            Customer.exists?(name: user_name, password: user_password)
                User.destroy_all(name: user_name)
                puts "Account Deleted. We hope to see you again soon!"
                exit
        elsif choice == '🔹Exit'.yellow
            exit
        end
    end


    def go_to_shopping(cart = [])
        #binding.pry
        system 'clear'
        colorizer = Lolize::Colorizer.new
        colorizer.write "
            `oddddo`                     
        `oddssssddo`                   
       -mym`    `mym-                  
      :dhd.      .dhd:                 
     :dhd.        .dhd:                
    `odhs          shdo`               
    /mhd            dhm/               
   :hdh-            -hhh:              
...........omdd..............ddmo...........   
mhhhhhhyssssssssssssssssssssssssssssyhhhhhhm   
msoooooo/::::::::::::::::::::::::::/oooooosm   
msoooooo+::::::::::::::::::::::::::+oooooosm   
+hsoooosss+++:::::::::::::::o/:::::+ooooosh+   
myooooyyo+ohoo/ooo/ooo/ooo/o/+oo++sysoooym    
myoooossysoyoy+hsh/dsd/hsh+y+yososhhyoooym    
ohsooos+///////////d//:h+////////+shyoosho    
dyoooo+:::::::::://::://::::::::/+ssooyd     
dyoooo/::::::+ysy::::::::::::::::/ooooyd     
-hyoo+:::::::+hso/+sy/:ysy+:::::::+ooyh-     
dyoo+:::::::+ysy/ysys/ysh+:::::::+ooyd      
yyso+:::::::::::::::::osy+:::::::+osyy      
hyo+::::::::::::::::::::::::::::+oyh       
hyo+::::::::::::::::::::::::::::+oyh       
:yy+////++++++++++++++++++++////+yy:       
ymddddyooooooooooooooooooooyddddmy       \n ".lines.map { |line| line.center(100) }.join("")
        prompt = TTY::Prompt.new
        choices = Food.all.map{|food| food.category}.uniq+['🔹View Cart'.yellow,'🔹Checkout'.magenta,'🔹Exit'.red]
        choice = prompt.select("\n                                                                    Select an Aisle! \n", choices)
        if choice == '🔹View Cart'.yellow
            view_cart(cart.flatten)
        elsif choice == '🔹Checkout'.magenta
            checkout(cart)
        elsif choice == '🔹Exit'.red
            if cart.length == 0
                exit
            else
                puts "Re-directing to shopping"
                sleep(2)
                go_to_shopping

            end
        
        else
            hexcode = Food.where(category: choice).map{|food| food.hexcode}
            sub_foods = Food.where(category: choice).map{|food| food.name}
            sub_choices = []
            iter = 0
            while iter < sub_foods.length do
                sub_choices << sub_foods[iter] + ":" + ([hexcode[iter]].map { |e| e.to_i(16) }.pack 'U*')
                iter += 1
            end
            foods = prompt.multi_select("Use Space Bar |____| to select/unselect #{choice}, and hit Enter when done.\n \n", sub_choices)
            foods.select{|f| cart<< f.strip.split(":")[0]}
            #cart << foods
            puts "\n\n #{foods.join(",")} has/have been added to your cart"
            # switch_song
            # play_music('/Users/dantheman/Flatiron/code/ruby-project-guidelines-1/bin/Mario-coin-sound.mp3')
            sleep(1)
            go_to_shopping(cart.flatten)
        end
    end


    def view_cart(cart=[])
        system 'clear'
        if cart.length == 0
            puts "Your cart is empty. Go back to shopping.\n Re-directing back to shopping"
            sleep(1)
            go_to_shopping(cart)
        else
            puts "Your cart has #{cart} inside.\n Re-directing back to shopping"
            sleep(5)
            go_to_shopping(cart)
        end
    end

    def checkout(cart=[])
        system 'clear'
        prompt = TTY::Prompt.new
        choices = ['🔹Remove & Add'.magenta, '🔹View Receipt'.yellow, '🔹Exit'.red]
        choice = prompt.select("\n Select an option \n", choices)
        if choice == '🔹Remove & Add'.magenta
            remove_and_add(cart)
        elsif choice == '🔹View Receipt'.yellow
            #binding.pry
            view_receipt(cart)
        elsif choice == '🔹Exit'.red
            if cart.length == 0
                exit
            else
                puts "Re-directing to shopping"
                sleep(2)
                go_to_shopping

            end

        end
        #binding.pry

    end


    def view_receipt(cart=[])
        switch_song
        play_music('/Users/dantheman/Flatiron/code/ruby-project-guidelines-1/bin/Mario-coin-sound.mp3')
        food_ids = []
        cart.uniq.each do |food_item|
            food_ids << Food.find_by(name: food_item).id
        end
        categories = []
        cart.uniq.each do |food_item|
            categories << Food.find_by(name: food_item).category
        end
        prices = []
        cart.uniq.each do |food_item|
            prices << Food.find_by(name: food_item).price
        end
        quantities = cart.uniq.each.map{|ele| cart.count(ele)}
        total = []
        iter = 0
        while iter < cart.uniq.length do
            total << prices[iter]*quantities[iter]
            iter += 1
        end 
        table_array = []
        index = 0
        while index < cart.length do
            table_array << [cart.uniq[index],categories[index],prices[index],quantities[index],'$'+total[index].to_s()]
            Order.create(customer_id: @current_user[0].id,food_id: food_ids[index],quantity: quantities[index],total: total[index])
            index += 1
        end
        table = TTY::Table.new(%w[Item Category Price/Item Quantity Total],
            table_array)
        colorizer = Lolize::Colorizer.new
        colorizer.write " \n\n Thank you for shopping with us.\n Your grand total is = $#{total.sum}\n\n "
        colorizer.write table.render(:ascii, alignments: %i[center]) do |renderer|
        renderer.border.separator = :each_row
        #colorizer.write " \n\n Thank you for shopping with us.\n Your grand total is = $#{total.sum}\n\n "
        sleep(5)
        #switch_song
        #play_music('/Users/dantheman/Flatiron/code/ruby-project-guidelines-1/bin/Mario-coin-sound.mp3')
        #sleep(2)
        #binding.pry
        end
        #binding.pry
    end


    


    def remove_and_add(cart=[])
        system 'clear'
        prompt = TTY::Prompt.new
        choices = ['🔹Remove'.yellow, '🔹Add'.green, '🔹Exit'.red]
        choice = prompt.select("\n \n", choices)
        if choice == '🔹Remove'.yellow
            #binding.pry
            remove(cart)
        elsif choice == '🔹Add'.green
            go_to_shopping(cart)
        elsif choice == '🔹Exit'.red
            exit
        end

    end

    def remove(cart=[])
        #trash = []
        system 'clear'
        puts "YOU ARE NOW REMOVING ITEMS FROM A CART"
        prompt = TTY::Prompt.new
        choices = (cart)
        choice = prompt.multi_select("\n \n", choices)
        choice.select{|car| cart.delete(car)}
        #trash << choice
        #cart -= trash
        puts "has been removed #{cart}"
        sleep(5)
        checkout(cart)
        #binding.pry
        #if choice == cart.index(0..10)
            # trash << choice
            # cart -= trash
        #     checkout
        # else 
        #     puts 'yay'
        #     checkout
        #end
    end

    # def take_out()

    # end



    def exit
        puts "**********"
        puts "Good Bye!"
        puts "**********"
        switch_song
        play_music('/Users/dantheman/Flatiron/code/ruby-project-guidelines-1/bin/Mario-coin-sound.mp3')
    end

    def opener 
        puts "\n 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 \n "
    end

end

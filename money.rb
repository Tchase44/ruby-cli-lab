
puts " ______                                       __   _______ __ "
puts "|   __ \  .-----.----.-----.-----.-----.---.-.|  | |    ___|__|.-----.---.-.-----.----.-----."
puts "|    __/ |  -__|   _|__ --|  _  |     |  _  ||  | |    ___|  ||     |  _  |     |  __|  -__|"
puts "|___|    |_____|__| |_____|_____|__|__|___._||__| |___|   |__||__|__|___._|__|__|____|_____|"
  
require "pry"
class Menu
	def initialize(app)
		@app = app
	end
  def display
    while 1
    	puts ""
    	puts "Welcome to Personal Finance"
    	puts ""
    	puts "1 to see Balance and Deposit"
    	puts "2 to enter Transaction"
		puts "3 to see Transaction History"
		puts "4 See Transactions by category"
		puts "5 Edit Transaction History"
		puts "10 Exit"
      input = gets.chomp!
      if ["1","2","3","4","5","10"].include? input
        self.select input
        break
      else
        puts "Invalid option."
      end
    end
  end
  def select number
    puts "You selected #{number}"
    # my_finances = Tracker.new
    case number
    when "1"
    	puts ""
    	puts "You currently have $#{@app.balance}"
    	puts "Would you like to make a deposit?"
    	puts "type 'yes' or 'no' "
    	depo = gets.chomp!
    	if depo == "yes"
    		puts ""
    		puts "how much would you like to deposit?"
    		moneys = gets.chomp.to_i
    		@app.add_money(moneys)
    		puts ""
    		puts "You now have $#{@app.balance}"
    		puts "Press Enter to go back to main menu"
    		gets
    		display
    	else
    		display
    	end
    when "2"
    	@app.add_transaction
    	display
    when "3"
    	@app.history.each do |x|
    		puts x
    	end
    	display
    when "4"
    	puts "Type a category(food, home improvement, travel...)"
    	@app.sorter
    	display
    when "5"
    	puts ""
    	puts "Where(payee) was your transaction you wish to delete?"
    	locale = gets.chomp.capitalize!
    	@app.delete(locale)
    when "10"
    	return
    end
  end
end

class Tracker
	attr_accessor :history
	attr_reader :balance
	def initialize()
		@balance = 100
		@history = [
			{:payee=>"Subway", :amount=>5, :date=>"01/01/17", :category=>"Food"},
			{:payee=>"Fuel pizza", :amount=>12, :date=>"01/02/17", :category=>"Food"},
			{:payee=>"Bwi", :amount=>500, :date=>"12/12/12", :category=>"Travel"}
		]
	end
	def add_transaction
		puts "Where did you make a purchase ?"
		in_payee = gets.chomp.capitalize!
		puts "How much did you spend ?"
		in_amount = gets.chomp.to_i
		puts "What was the date ?( DD/MM/YY )"
		in_date = gets.chomp!
		puts "What category does it fit? (Home Improvement,Food,Travel...)"
		in_category = gets.chomp.capitalize!
		@history.push({
			payee: in_payee,amount: in_amount,date: in_date,category: in_category
			})
		@balance -= in_amount
	end

	def sorter
		cat_name = gets.chomp.capitalize!
		temp_list  = @history.select {|x| x[:category] == cat_name}
		puts temp_list
		puts ""
		get_total(temp_list)
		puts ""
	end

	def get_total hash_list
		total = 0
		hash_list.each do |item|
			total += item[:amount]
		end
		puts "$#{total} total in this category"
	end

	def add_money dollars
		@balance += dollars
		positive_transaction dollars
	end
	def positive_transaction dollars
		time_of = Time.now.strftime("%d/%m/%Y")
		@history.push({payee: "Self",amount: dollars,date: time_of,category: "Deposit"})
	end

	def delete thing_to_edit
		item = @history.find { |x| x[:payee] = thing_to_edit }
		modify_menu
		option = gets.chomp!
		puts "Type updated info"
		new_thing = gets.chomp!
		case option
		when "1"
			item[:payee] = new_thing.capitalize
		when "2"
			item[:amount] = new_thing.to_i
		when "3"
			item[:date] = new_thing
		when "4"
			item[:category] = new_thing.capitalize
		when "5"
			@history.delete_if { |x| x[:payee]== thing_to_edit }
		else
			puts "Invalid option."
			display
		end
		puts ""
		puts "modify/delete complete"
		display
	end

	def modify_menu
		puts "1 to edit Where"
		puts "2 to edit Amount"
		puts "3 to edit date"
		puts "4 to edit category"
		puts "5 to delete"
	end

end
my_finances = Tracker.new
menu = Menu.new(my_finances)

menu.display

binding.pry












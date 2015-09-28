require 'pry'
require 'csv'


class Shipments
  attr_accessor :destination, :crates, :profits, :shipped

  def initialize
    @destination= []
    @crates=[]
    @profits=[]
    @shipped= []
    @trips= []
    @money = 0
    @earth=0
    @uranus=0
    @mars=0
    @leela=0

        CSV.foreach("shipping.csv", headers: true) do |row|
      @profits << row["Profit per crate"].to_i
      @destination << row["Destination"].to_s
      @crates << row["Number of crates"].to_i
      @shipped<< row["What got shipped"].to_s
      if row["Destination"]=="Earth"||row["Destination"]=="Uranus"||row["Destination"]=="Mars"
        @earth+=row["Number of crates"].to_i*row["Profit per crate"].to_i
        @uranus+=row["Number of crates"].to_i*row["Profit per crate"].to_i
        @mars+=row["Number of crates"].to_i*row["Profit per crate"].to_i
    else
        @leela+=row["Number of crates"].to_i*row["Profit per crate"].to_i
      end
    end
  end
  def show
    puts "Planet = #{@destination}"
    puts "Item shipped = #{@shipped}"
    puts "Quantity = #{@crates}"
    puts "Profit = #{@profits}"
  end

  def profit
    money_per_ship=@profits.zip(@crates).map {|x,y| x*y}
    money_per_ship.each do |i|
      @money += i
    end
    puts "The total weekly profits were $#{@money}"
  end

  def bonuses

    puts "Fry's bonus is $#{@earth/10} "
    puts "Bender's bonus is $#{@uranus/10}"
    puts "Amy's bonus is $#{@mars/10}"
    puts "Leela's bonus is $#{@leela/10}"
  end

  def trips_piloted
    ftrip = @destination.count "Earth"
    puts "Fry did #{ftrip} trips"
    btrip = @destination.count "Uranus"
    puts "Bender did #{btrip} trips"
    atrip= @destination.count "Mars"
    puts "Amy did #{atrip} trips"
    ltrip= @destination.count- (ftrip+btrip+atrip)
    puts "Leela did #{ltrip} trips"
  end


end



s= Shipments.new
s.bonuses
s.trips_piloted
s.profit

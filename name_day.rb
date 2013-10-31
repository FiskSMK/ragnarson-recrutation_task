require 'nokogiri'
require 'open-uri'

class String
  def is_integer?
    self.to_i.to_s == self
  end
end

class NameDay
	@month
	@day
	@doc 
	
	def initialize
		checkAll
		getDoc
	end
	
	def checkMonth
		months = ["january","february","march","april","may","june","july",
				  "august","september","october","november","december"]
		if months.include? @month
			true
		else
			fail "Podano nieprawidlowy miesiac!"
			false
		end
	end
	
	def checkDay
		if @day <= 0
			fail "Podano ujemny dzien!"
		end
		maxdays = case @month
		when "january","march","may","july","august","october","december"
			31
		when "april","june","september","november" then 30
		when "february" then 28
		else
			fail "Nieprawidlowy miesiac!"
		end
		if @day > maxdays 
				fail "#{@month} nie ma tylu dni"
			end
		true
	end
	
	def checkARGV
		unless ARGV.count == 2
			fail "Program wymaga 2 argumentow!\nnp. name_day.rb March 1\n"
			return false
		end
		if !ARGV[0].is_integer? and ARGV[1].is_integer?
			@month = ARGV[0].downcase
			@day = ARGV[1].to_i
		elsif ARGV[0].is_integer? and !ARGV[1].is_integer?
			@day = ARGV[0].to_i
			@month = ARGV[1].downcase
		else
			fail "Niepoprawne typy argumentow"
			return false
		end
		true
	end
	
	def checkAll
		checkARGV
		checkMonth
		checkDay
	end
	
	def getDoc
		url = "http://www.namedaycalendar.com/"+@month+'/'+@day.to_s
		@doc = Nokogiri::HTML(open(url))
	end
	
	def printND
		divs = @doc.xpath("//div[contains(@class,'country')]")
		divs.each do |div|
			puts (div.to_s[/<b>.*<\/b>/])[3..-5]
			div.to_s.scan(/<div>.*<\/div>/).each do |name|
				puts name[5..-7]
			end
			puts
		end
	end
end

nd = NameDay.new
nd.printND

class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    #My Code
    @character_count_with_spaces = @text.length

    @character_count_without_spaces =  @text.gsub(/[\s\n]/, "").length

    temp = @text.gsub(/[\n.,?!]/, "")
    words = temp.split(" ")
    @word_count = words.size

    text =  @text.gsub(/[.,?!\n]/,"").downcase
    words = text.split(" ")
    num = 0
    words.each{|w|
      if w == @special_word.downcase
        num += 1
      end
    }
    @occurrences = num

    render("word_count.html.erb")
  end




  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # My code
    months = @years*12
    rate = @apr/1200
    @monthly_payment = @principal * (rate + (rate / ((1+rate) ** months - 1) ) )

    render("loan_payment.html.erb")
  end




  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    #My code
    @seconds = (@starting - @ending)
    @minutes = @seconds/60
    @hours = @seconds/3600
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52

    render("time_between.html.erb")
  end




  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # My code
    len = @numbers.length
    sorted = @numbers.sort

    @sorted_numbers = sorted
    @count = len
    @minimum = @numbers.min
    @maximum = @numbers.max
    @range = @numbers.max - @numbers.min

    half = len/2
    if len % 2 == 0
      med = (sorted[half]+sorted[half-1])/2
    else
      med = sorted[half]
    end
    @median = med
    sum = 0


    @numbers.each{|i|
      sum += i
    }
    @sum = sum
    @mean = sum/len

    var = 0
    @numbers.each{|x|
      var = var + (x-@mean)**2
    }

    @variance = var/len
    @standard_deviation = Math.sqrt(@variance)

    #Check
    frequencies = Hash.new(0)
    @numbers.each{|x|
      frequencies[x] += 1
    }
    frequencies = frequencies.sort_by{|x,y|
      y
    }
    frequencies.reverse!
    mde = frequencies[0]
    @mode = mde

    render("descriptive_statistics.html.erb")
  end

end

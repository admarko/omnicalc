class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    #My Code
    @character_count_with_spaces = @text.length

    @character_count_without_spaces =  @text.length - @text.count(" ")

    @word_count = @text.count(" ") + 1

    @occurrences = @text.count(@special_word)

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
    @seconds = @ending.sec - @starting.sec
    @minutes = @ending.min - @starting.min
    @hours = @ending.hour - @starting.hour
    @days = @ending.yday - @starting.yday
    @weeks = @days/7
    @years = @ending.year  - @starting.year

    render("time_between.html.erb")
  end




  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # My code
    len = @numbers.length
    sorted = @numbers.sort
    half = len/2

    @sorted_numbers = sorted
    @count = len
    @minimum = @numbers.min
    @maximum = @numbers.max
    @range = @numbers.max - @numbers.min
    @median = "Replace this string with your answer."
    sum = 0
    @numbers.each{|i|
      sum += i
    }
    @sum = sum
    @mean = sum/len

    @variance = "Replace this string with your answer."
    @standard_deviation = "Replace this string with your answer."
    @mode = "Replace this string with your answer."

    render("descriptive_statistics.html.erb")
  end

end

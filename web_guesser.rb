require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = 1 + rand(99)
guesses_left = 10
correct = false

get '/' do
	message = check_guess(params["guess"])
  	bg_color = css_color message

	if guesses_left == 1 && !correct
  	 	message = "Sorry, You lose this round!"
  	 	bg_color = css_color message
	 	guesses_left = 10
	 	SECRET_NUMBER = 1 + rand(99)
	elsif correct
		SECRET_NUMBER = 1 + rand(99)
		guesses_left = 10
		correct = false
	 	
	else
  		guesses_left -= 1
  	end

	erb :index, :locals => {:bg_color => bg_color, :message => message}
	
end

def check_guess(guess)
	if guess.nil?
		return "Pick a number 1-100"
	else
		if guess.to_i > SECRET_NUMBER + 5 
	  		return "Whoa! Way Too High"
	    elsif guess.to_i < SECRET_NUMBER - 5 
	  		return "Yikes! Way Too Low"
	 	elsif guess.to_i > SECRET_NUMBER 
	  		return "That a bit too High" 
	  	elsif guess.to_i < SECRET_NUMBER 
	  		return "Too Low"
	    elsif  guess.to_i == SECRET_NUMBER 
	    	correct = true
	  		return "CONGRATS! You have guessed correctly!"
	  	end 
	end
end

def css_color(message)
	case message
		when "Pick a number 1-100" then "#FFFFFF"
		when "Whoa! Way Too High" then "#FF9473" 
		when "Yikes! Way Too Low"  then "#FF9473"
		when "That a bit too High" then "#FF9473"
		when "Too Low" then "#FF9473"
		when "Sorry, You lose this round!" then "red"
		when "CONGRATS! You have guessed correctly!" then "#62D99C"
	end
end
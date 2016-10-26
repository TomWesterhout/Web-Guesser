require 'sinatra'
require 'sinatra/reloader'

get '/' do
	guess = params['guess'].to_i
	@cheat = cheat_mode(params['cheat'])
	@message = check_guess(guess)
	$remaining_guesses -= 1
	proces_tracker(guess)
	erb :index, :locals => {:random_number => $random_number,
							:remaining_guesses => $remaining_guesses,
							:guess => params['guess'],
							:announcement => @announcement,
							:message => @message,
							:cheat => @cheat}
end

$random_number = rand(0..100)
$remaining_guesses = 5

def proces_tracker(guess)
	if guess == $random_number
		reset
		@announcement = "You got it right! A new game has been started."
	elsif $remaining_guesses == 0
		reset
		@announcement = "No more guesses left. A new game has been started."
		@message = ""
	else
		@announcement = ""
	end
end

def reset
	$remaining_guesses = 5
	$random_number = rand(0..100)
end

def cheat_mode(input)
	if input
		"Cheat: #{$random_number}"
	else
		""
	end
end

def check_guess(guess)
	if guess == "".to_i
		""
	elsif guess > $random_number
		if guess > $random_number + 5
			"Way too high!"
		else
			"Too high!"
		end
	elsif guess < $random_number
		if guess < $random_number - 5
			"Way too low!"
		else
			"Too low!"
		end
	elsif guess == $random_number
		"The secret number is #{$random_number}"
	end
end

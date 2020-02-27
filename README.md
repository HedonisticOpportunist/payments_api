In order to run the tests, you need set up your configuration in RubyMine with the 
following runner_options: --color -r features. 

Also ensure that you choose the right locations
for the feature file as well as the working directory. 

You will also need to set up an .env file (right where your Gemfile is located)
where you need to enter the following information:

export AUTH_SERVICE = https://devapi.currencycloud.com/v2/authenticate/api

export USER_NAME = [your username]

export API_KEY = [your api key]

export CLOSE_SESSION = https://devapi.currencycloud.com/v2/authenticate/close_session

export GET_QUOTE = https://devapi.currencycloud.com/v2/rates/detailed

The approach to writing this framework was a mixture of things I had previously done at work,
and a lot of trial/error (debugging). I tried to keep the step file as simple as possible, so that it would
be more readable. The most challenging aspect of this task was ensuring that the calls
were working properly and the right response was being returned. 

I would have preferred to write more tests, but since there was a short amount of time, I chose to implement what was specified in the test 
task description. Naturally, there is a lot more refactoring to be done and the data 
comparision could have been handled in a much smoother way, but that can always be done
in the future :)
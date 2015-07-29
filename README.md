# credit_card_loader
The purpose of this application is to take a credit credit card
run the luhn 10 algorithm on the card to check for validity
then either create the card account, add charges or subtract debt.

instructions:
-Have ruby 2.2.1 installed.  I suggest using RVM.
-You will need to install the gem ruby-luhn
  - gem install luhn-ruby, if you are not using RVM use sudo gem install luhn-ruby
  - bundle install
-You will call in the terminal ruby uploader.rb "foo.bar" where foo is the file name and bar is the extension.
-I use the text file test.txt
-A summary will be written to the file data.txt in the application.  The summary includes the account holders name and their balance.
 Methods to my madness
I chose to do this project in Ruby because the problem lends itself well to hashes.
Ruby handles hashes very well and it essentially our bread and butter data structure.  
Ruby also has a very robust open source library.  There are many gems that add functionality
easily to your code.  For example, as opposed to recreating the luhn 10 algorithm directly
into my code I use the luhn-ruby gem.  The gem is tested within the gem file to ensure it works.
I am a firm believer of not reinventing the wheel.  Using the luhn gem allows me to bypass
the complexity of creating an algorithm and testing it myself.  This dramatically decreases
development time.  

I laid out my code in multiple methods to keep each piece fairly isolated.  This allowed for the
the code to be easily troubleshooted and for maintainability. My main data structure was a hash with an array as the value.
This allowed for easy indexing of accounts with exact information that was necessary.  Within the array there exist a balance
and a limit to that balance.  Because of the natural of arrays I can continue to add information to the key, which is the name of each user. If this were to go to product I would prefer a more explicit key that could identify a user without possible duplicates.  

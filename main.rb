# This is the main entrypoint into the program
# It requires the other files/gems that it needs

require 'pry'
require 'hirb'
require './invalid_candidates'
require './filters'
require './exceptions'

## Your test code can go here
#binding.pry


def print_instructions
  puts "Type 'find 1' to display candidate with id 1."
  puts "Type 'all' to see all candidates."
  puts "Type 'qualified' to print only qualified candidates."
  puts "Type 'quit' to exit."
  puts "Type 'help' to see these instructions again."
end

def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end

def red(text)
  colorize(text, 31)
end

def green(text)
  colorize(text, 32)
end

def all_candidates
  results = []
  @candidates.each do |c|
    results << green(c) if qualified?(c)
    results << red(c) unless qualified?(c)
  end
  puts results
end

def repl
  puts "Welcome to your HR database. How can I help?"
  print_instructions
  keep_going = true
  first_time = true
  while keep_going
    puts "Anything else? Type 'help' to see instructions." if first_time == false
    first_time = false
    response = gets.chomp.downcase
    if response.match(/^find\s\d+/)
      puts "Searching..."
      id = response.match(/\d+/)
      find(id[0].to_i,@candidates)
    elsif response == "quit"
      keep_going = false
    elsif response == "help"
      print_instructions
    elsif response == "qualified"
      pp ordered_by_qualifications(qualified_candidates(@candidates))
    elsif response == "all"
      all_candidates
    else
      puts "Sorry, we didn't understand your command."
    end
  end  
end

#pp ordered_by_qualifications(qualified_candidates)

repl



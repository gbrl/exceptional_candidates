# In this file we define the methods to help filter out candidates
# This way, we keep these methods separated from other potential parts of the program


def find(id, candidates)
  results = candidates.detect { |x| x[:id] == id }
end

def experienced?(candidate)
  unless candidate.has_key?(:years_of_experience)
    raise InvalidCandidateError, 'Candidate must have a :years_of_experience key'
  end
  candidate[:years_of_experience] >= 2
end

def uses_github?(candidate)
  unless candidate[:github_points].is_a? Integer
    raise InvalidCandidateError, 'Candidate Github points must be an Integer.'
  end
  candidate[:github_points] >= 100
end

def knows_ruby_or_python?(candidate)
  unless candidate[:languages].is_a? Array
    raise InvalidCandidateError, 'Languages are not in an array.'
   end
  ["Ruby","Python"].any? { |lang| candidate[:languages].include? lang }
end

def applied_recently?(candidate)
  candidate[:date_applied] >= 15.days.ago.to_date
end

def adult?(candidate)
  if candidate[:age] < 0
    raise InvalidCandidateError, 'Candidate must have a positie age!'
  end
  candidate[:age] >= 18
end

def qualified?(candidate)
  return true if experienced?(candidate) && uses_github?(candidate) && knows_ruby_or_python?(candidate) && applied_recently?(candidate) && adult?(candidate)
end

def qualified_candidates(candidates)
  candidates.select do |person| 
    experienced?(person) && uses_github?(person) && knows_ruby_or_python?(person) && applied_recently?(person) && adult?(person)
  end
end

def ordered_by_qualifications(candidates)
  sorted = candidates.sort_by { |c| [ c[:years_of_experience], c[:github_points] ] }
  sorted.reverse!
end

# More methods will go below

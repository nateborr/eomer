require 'sinatra'
require 'redis'

get '/name' do
  Redis.current.set 'greet', Time.now.to_s

  m = 4
  n = 8
  first_initial_only = middle_initial_only = false

  # Return just a first initial 1 out of m times.
  if (1..m).to_a.sample == m
    first_initial_only = true
  end

  # If returning a first initial, return a middle initial 1 out of n times.
  # Otherwise return a middle initial (n - 1) out of n times.
  if ((first_initial_only ? 1 : n - 1 )..n).to_a.sample == n
    middle_initial_only = true
  end

  first_name = first_initial_only ? 'E.' : (Redis.current.srandmember(:e) ||  'Erling')
  middle_name = middle_initial_only ? 'O.' : (Redis.current.srandmember(:o) || 'O.')
  last_name = Redis.current.srandmember(:m) || 'Mork'

  %{#{first_name} #{middle_name} #{last_name}}
end
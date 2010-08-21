module ApplicationHelper
  
  # just wrap and produce js like data structure
  def burndown burndown_aware
    data = burndown_aware.burndown.sort.to_a.map{ |x| 
      # split string so we can get seconds from the epoch (as flot wants us to do)
      [ make_time( x[0] ) * 1000, x[1] ]
    }
    data.inspect
  end

  def make_time(time_in_string)
    time = time_in_string.split("-")
    Time.utc(time[0], time[1], time[2], 0, 0, 0, 0).to_i
  end
  
end

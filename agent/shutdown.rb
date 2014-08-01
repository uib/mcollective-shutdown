module MCollective
 module Agent
  class Shutdown<RPC::Agent
    
    { 'reboot' => '-r', 'poweroff' => '-P' }.each do |act,flags|
    action act do
      validate :time, String
      validate :message, String

      time = request[:time]
      message = request[:message]

      reply[:status] = run("shutdown #{flags} '#{time}' '#{message}' &")
      
      if reply[:status] == 0
        reply[:status] = case time
        when 'now'
	  "#{act.capitalize} in progress with message: #{message}"
        when /^\+([0-9]+)$/
	  "#{act.capitalize} scheduled in #{$1} minutes with message: #{message}"
        else
	  "#{act.capitalize} scheduled at #{time} with message: #{message}"
	end
      else
        reply[:status] = "Reboot not scheduled."
      end
    end
    end

    action "cancel" do

      reply[:status] = run("shutdown -c")
      
      if reply[:status] == 0
        reply[:status] = "Shutdown canceled."
      else
        reply[:status] = "Shutdown could not be canceled."
      end

    end
    
  end
 end
end

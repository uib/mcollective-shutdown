module MCollective
 module Agent
  class Shutdown<RPC::Agent
    
    action "reboot" do
      validate :time, String
      validate :message, String

      time = Integer(request[:time])
      message = request[:message]

      reply[:status] = run("echo shutdown -r '#{time}' '#{message}' | at now + 1 minutes")
      
      if reply[:status] == 0
        reply[:status] = "Reboot scheduled in #{time} (+ 1 minute) with message: #{message}"
      else
        reply[:status] = "Reboot not scheduled."
      end

    end

    action "poweroff" do
      validate :time, String
      validate :message, String

      time = Integer(request[:time])
      message = request[:message]

      reply[:status] = run("echo shutdown -P '#{time}' '#{message}' | at now + 1 minutes")
      
      if reply[:status] == 0
        reply[:status] = "Shutdown scheduled in #{time} (+ 1 minute) with message: #{message}"
      else
        reply[:status] = "Shutdown not scheduled."
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

metadata    :name        => "shutdown",
            :description => "Bring the system down",
            :author      => "Anders Vaage",
            :license     => "GPL",
            :version     => "0.1",
            :url         => "https://github.com/uib/mcollective-plugins",
            :timeout     => 60

["shutdown", "reboot"].each do |act|
    action act, :description => "Schedules a #{act.capitalize}" do
    display :always

    input :time,
          :prompt => "Time",
          :description => "Time before shutdown",
          :validation => '^[0-9]+$',
          :type => :string,
          :maxlength => 3,
          :optional => true


    input :message,
          :prompt      => "Message",
          :description => "Message before shutdown",
          :type        => :string,
          :validation  => '\A[a-zA-Z0-9_-]+\z',
          :optional    => false,
          :maxlength   => 50

    output :status,
           :description => "Confirms",
           :display_as  => "Message"

end

action "cancel", :description => "Cancel shutdown" do
    display :always
    
    output :status,
           :description => "Confirms",
           :display_as  => "Message"    
end      

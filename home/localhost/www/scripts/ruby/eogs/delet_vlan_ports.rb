require 'rubygems'
require 'net/ssh'

@hostname1 = "10.52.0.50"
@hostname2 = "10.52.0.51"
@username = ARGV[2].to_s
@password = ARGV[3].to_s
@cmd = "configure vlan vl" + ARGV[0].to_s + " delete ports " + ARGV[1].to_s + " tagged"
@save = "save"
 begin #на eogs1
   p""
   p "<<eogs1"
    ssh = Net::SSH.start(@hostname1, @username, :password => @password)
    res = ssh.exec!(@cmd)

    puts @cmd
    puts res

    res = ssh.exec!(@save)
    puts res

    ssh.close
    puts "OK"
  rescue
    puts "Unable to connect to #{@hostname1} using #{@username}/#{@password}"

  end
    p "========================================================="

  begin #на eogs2
    p""
     p "<<eogs2"

     ssh = Net::SSH.start(@hostname2, @username, :password => @password)
     res = ssh.exec!(@cmd)

     puts @cmd
     puts res

     res = ssh.exec!(@save)
     puts res

     ssh.close
     puts "OK"
   rescue
     puts "Unable to connect to #{@hostname1} using #{@username}/#{@password}"

   end
      p "========================================================="

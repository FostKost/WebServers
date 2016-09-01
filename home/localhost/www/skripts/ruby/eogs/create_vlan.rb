require 'rubygems'
require 'net/ssh'

@hostname1 = "10.52.0.50"
@hostname2 = "10.52.0.51"
@username = "fast"
@password = "H347MHcerf"
@cmd = "create vlan vl" + ARGV[0].to_s
@cmd2= "configure vlan vl"+ ARGV[0].to_s+" tag "+ ARGV[0].to_s
@save="save"

 begin #на eogs1
   p""
   p "<<eogs1"
    ssh = Net::SSH.start(@hostname1, @username, :password => @password)
    res = ssh.exec!(@cmd)
    res2 = ssh.exec!(@cmd2)

    puts @cmd
    puts res
    puts @cmd2
    puts res2

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
     res2 = ssh.exec!(@cmd2)

     puts @cmd
     puts res
     puts @cmd2
     puts res2

     res = ssh.exec!(@save)
     puts res

     ssh.close
     puts "OK"

   rescue
     puts "Unable to connect to #{@hostname1} using #{@username}/#{@password}"

   end
      p "========================================================="

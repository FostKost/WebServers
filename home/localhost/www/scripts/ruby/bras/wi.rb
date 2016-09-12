require 'rubygems'
require 'net/ssh'
#require 'net/ssh/session'
#require 'logger'

@hostname1 = "10.52.0.45"
@username = ARGV[1].to_s
@password = ARGV[2].to_s
@cmd_shc = "sh context"
@wifi_orb="context wifi-orb"






begin
 begin #на eogs1
   p"\n"
   p "<<bras1"
    ssh = Net::SSH.start(@hostname1, @username, :password => @password, :timeout => 60)

    res = ssh.exec!(@wifi_orb + ';'+@cmd_shc)
    puts @cmd_shc
    puts res

    #res = ssh.exec!(@wifi_orb)
    #puts @wifi_orb
    #puts res


    #res = ssh.exec!(@cmd_shc + ';'+@cmd_shc)
    puts @cmd_shc
    puts res

    ssh.close
    puts "OK"
  rescue
    puts "Unable to connect to #{@hostname1} using #{@username}/#{@password}"

  end
    p "========================================================="
end

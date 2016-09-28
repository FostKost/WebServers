require 'rubygems'
require 'net/ssh'
#require 'net/ssh/session'
#require 'logger'

@hostname1 = "10.52.0.45"
@username = ARGV[2].to_s
@password = ARGV[3].to_s
@cmdb1 = "context wifi-orb"
@cmdb2 = "configure"
@cmdb3 = "link-group lan access economical"
@cmdb4 = "dot1q pvc "+ARGV[0].to_s
@cmdb5 = "description "+ARGV[1].to_s
@cmdb6 = "service clips dhcp maximum 3000 context wifi-orb"
@cmdb7 ="commit"
@cmdb8 ="exit"
@cmdb9 = "save"
@c=";"







#на bras1
 p""
  p "<<bras1"

  ssh3 = Net::SSH.start(@hostname1, @username, :password => @password )

  begin

    cmd_bras=@cmdb1+";"+@cmdb2+";"+@cmdb3+";"+@cmdb4+";"+@cmdb5+";"+@cmdb6+";"+@cmdb7+";"+@cmdb8+";"+@cmdb8+";"+@cmdb8+";"+@cmdb9
    #res = ssh3.exec!(cmd_bras)
    p cmd_bras
    #p res

end

  ssh3.close
  puts "OK"




   p "========================================================="

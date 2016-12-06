#create_vlan [#Vlan] [login] [password]
require 'rubygems'
require 'net/ssh'


@hostname1 = "10.52.0.50"
@hostname2 = "10.52.0.51"
@hostname3 = "10.52.0.45"
@username = ARGV[2].to_s
@password = ARGV[3].to_s
@cmde1 = "delete vlan vl" + ARGV[0].to_s
@cmde2 = "create vlan vl" + ARGV[0].to_s
@cmde3 = "configure vlan vl"+ ARGV[0].to_s+" tag "+ ARGV[0].to_s
@cmde4 ="configure vlan vl" + ARGV[0].to_s + " add ports 1,41," + ARGV[1].to_s + " tagged"
@save="save"

@cmdb1 = "context wifi-orb"
@cmdb2 = "configure"
@cmdb3 = "link-group lan access economical"
@cmdb4 = "dot1q pvc "+ARGV[0].to_s
@cmdb5 = "description "+ARGV[1].to_s
@cmdb7 ="commit"
@cmdb8 ="exit"
@cmdb9 = "save"
@c=";"







       #на bras1
        p""
         p "<<bras1"

         ssh3 = Net::SSH.start(@hostname3, @username, :password => @password )

         begin

           cmd_bras=@cmdb1+";"+@cmdb2+";"+@cmdb3+";"+@cmdb4+";"+@cmdb5+";"+@cmdb7+";"+@cmdb8+";"+@cmdb8+";"+@cmdb8+";"+@cmdb9
           res = ssh3.exec!(cmd_bras)
           p cmd_bras
           p res

       end

         ssh3.close
         puts "OK"




          p "========================================================="

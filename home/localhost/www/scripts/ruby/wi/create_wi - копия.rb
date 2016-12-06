#create_vlan [#Vlan] [login] [password]
require 'rubygems'
require 'net/ssh'


@hostname1 = "10.52.0.50"
@hostname2 = "10.52.0.51"
@hostname3 = "10.52.0.45"
@username = "fast_k"
@password = "H347MHcerf"
@cmde1 = "delete vlan vl" + "807"
@cmde2 = "create vlan vl" + "807"
@cmde3 = "configure vlan vl"+ "807"+" tag "+ "807"
@cmde4 ="configure vlan vl" + "807" + " add ports 1,41," + "36" + " tagged"
@save="save"

@cmdb1 = "context wifi-orb"
@cmdb2 = "configure"
@cmdb3 = "link-group lan access economical"
@cmdb4 = "dot1q pvc "+"807".to_s
@cmdb5 = "description "+"32900447WI".to_s
@cmdb6 = "service clips dhcp maximum 3000 context wifi-orb"
@cmdb7 ="commit"
@cmdb8 ="exit"
@cmdb9 = "save"
@c=";"

 begin #на eogs1
   p""
   p "<<eogs1"
    ssh1 = Net::SSH.start(@hostname1, @username, :password => @password)

    res = ssh1.exec!(@cmde1)
    puts @cmde1
    puts res

    res2 = ssh1.exec!(@cmde2)
    puts @cmde2
    puts res2

    res3 = ssh1.exec!(@cmde3)
    puts @cmde3
    puts res3

    res4 = ssh1.exec!(@cmde4)
    puts @cmde4
    puts res4

    res = ssh1.exec!(@save)
    puts res

    ssh1.close
    puts "OK"
  rescue
    puts "Unable to connect to #{@hostname1} using #{@username}/#{@password}"

  end
    p "========================================================="

  begin #на eogs2
    p""
     p "<<eogs2"

     ssh2 = Net::SSH.start(@hostname2, @username, :password => @password)
     res = ssh2.exec!(@cmde1)
     puts @cmde1
     puts res

     res2 = ssh2.exec!(@cmde2)
     puts @cmde2
     puts res2

     res3 = ssh2.exec!(@cmde3)
     puts @cmde3
     puts res3

     res4 = ssh2.exec!(@cmde4)
     puts @cmde4
     puts res4

     res = ssh2.exec!(@save)
     puts res

     ssh2.close
     puts "OK"

   rescue
     puts "Unable to connect to #{@hostname1} using #{@username}/#{@password}"

   end
      p "========================================================="



       #на bras1
        p""
         p "<<bras1"

         ssh3 = Net::SSH.start(@hostname3, @username, :password => @password )

         begin

           cmd_bras=@cmdb1+";"+@cmdb2+";"+@cmdb3+";"+@cmdb4+";"+@cmdb5+";"+@cmdb6+";"+@cmdb7+";"+@cmdb8+";"+@cmdb8+";"+@cmdb8+";"+@cmdb9
           res = ssh3.exec!(cmd_bras)
           p cmd_bras
           p res

       end

         ssh3.close
         puts "OK"




          p "========================================================="

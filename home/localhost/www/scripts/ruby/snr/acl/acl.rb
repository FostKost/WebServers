require 'rubygems'
require 'net-telnet'
@user="fast"
@password="H347MHcerf"

def telnets(ip)# добавление вланы Uplonk
  cmd1="conf t"
  cmd2="snmp-server host 81.30.199.70 v2c YhoNtuR2163"
  cmd3="snmp-server host 81.30.199.70 v1 YhoNtuR2163"
  cmd4="ip access-list extended snmp"
  cmd5="permit ip host-source 81.30.199.70 any-destination"
  cmd6="exit"
  cmd7="wr"


  tn = Net::Telnet::new(
      "Host" => ip,
      "Timeout"=>false,
      "Prompt"=>/#/
  )
=begin
  c=tn.print(@user+"\n"+@password+"\n")
  tn.waitfor(/#/)
  tn.print(cmd1)
  tn.waitfor(/#/)
  tn.print(cmd2)
  tn.waitfor(/#/)
  tn.print(cmd3)
  tn.waitfor(/#/)
  tn.print("sa")
  tn.waitfor(/#/)

  tn.close
=end

  tn.login(@user,@password)#{|c| print c}
  tn.cmd(cmd1)#{|c| print c}
  tn.cmd(cmd2)#{|c| print c}
  tn.cmd(cmd3)#{|c| print c}
  tn.cmd(cmd4)#{|c| print c}
  tn.cmd(cmd5)#{|c| print c}
  tn.cmd(cmd6)#{|c| print c}
  tn.cmd(cmd6)#{|c| print c}

  tn.print("\n wr \n")#{|c| print c}
  tn.print("y \n") #{|c| print c}

  #tn.waitfor(/#/)
  #tn.close{|c| print c}
end





ips=File.open("ip.txt"){|file| file.read}
ip=ips.scan(/10.52.\d{1,3}.\d{1,3}/)
p l=ip.size
p i=0
p ip
while i<l
  p ip[i]
  telnets(ip[i].to_s)
  i=i+1
end

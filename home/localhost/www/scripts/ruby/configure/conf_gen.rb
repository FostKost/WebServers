
require 'rubygems'
require 'json'
require 'open-uri'
require 'socket'
require 'timeout'
require 'cgi'
require 'net-telnet'

@user="fast_k"
@password="H347MHcerf"
@model="SNR-S2960-24G"
@upsw="10.52.128.183"
@upswport="1"
@mask="255.255.255.192"
@getway=""
@uplink="27,28"
@downlink=""
@count_port={"DGS-3000-10TC"=>10,"DES-3200-10"=>10,"DGS-3627G"=>27,"DES-3526"=>26,
             "DGS-3000-24TC"=>24,"DGS-3000-26TC"=>26,"DES-3010F"=>10,"DES-3018"=>18,
             "DES-3026"=>26,"DES-3028"=>28 ,"DGS-3120-24TC"=>24,"DES-3010G"=>10 ,
             "DGS-3420-28SC"=>28,"SNR-S2960-24G"=>28,"SNR-S2990G-24T"=>28, "test"=>"test"}
@if_SNR={"SNR-S2960-24G"=>"ethernet 1/","SNR-S2990G-24T"=>"ethernet 1/0/"}
@file_write="test.org"
@serial=""
@snr
@client_port=""
@system_port=""
@remote_vlan=""
@system_vlan=""
@phone_vlan=""
@ipn_vlan=""
@nol_vlan=""
@vpn_ur_vlan=""
@vpn_fiz_vlan=""
@kv=""
@address=""
@ip="10.52.8.5"
@mod_up="SNR-S2960-24G"
#==============DLink sh sw==========================
def sh_sw(ip)
  cmd="\n sh sw"
  tn = Net::Telnet::new(
      "Host" => ip,
      "Timeout"=>false,
      "Prompt"=>/ All/
  )
  c=tn.print(@user+"\n"+@password+"\n")
  tn.waitfor(/#/)
  return tn.cmd(cmd)
  tn.close

end
#  ============пингчек==============================
def pingecho(host, timeout=2, service="echo")
  begin
    timeout(timeout) do
      s = TCPSocket.new(host, service)
      s.close
    end
  rescue Errno::ECONNREFUSED
    return true
  rescue Timeout::Error, StandardError
    return false
  end
  return true
end
#==========подбираем ип для конфига==================
def get_free_ip()
  ip1='10.52.'+@kv+'.'
  flag=true
  i=1
  ip2=ip1+i.to_s

  while flag
     flag2=false
        ip2=ip1+i.to_s
      i+=1
     if (i+1)%64==0
       i+=2
       end
     if i%64==0
       i+=1
     end


    url="http://ugin.core.ufanet.ru//api/find_by_ip?user=fast_k&password=H347MHafcn&ip="+ip2+"&city_id=32"

     begin
     open(url).read
     rescue OpenURI::HTTPError
        flag2=true
    end

      if  flag2

        if pingecho(ip2, 2)
          flag=true
          else flag=false
        end



    end
  end
 return ip2
end
#===========получаем список клиенских портов=========
def client_port()

  po=@system_port.to_s.scan(/\d{1,2}/)
  i=1
  j=0
  c=""
  while i<=@count_port[@model]
    j=0
    if !po.include?(i.to_s)
      c=c+i.to_s+","
    end

    i+=1
  end
  return c.slice(0..(c.size-2))
end
#===========получаем системные порты=================
def system_port()
  if @downlink==""
    s=@uplink
  else
    s=@uplink+','+@downlink
  end
  return s
end
#===========получаем ид из ужина по ипу==============
def get_id(ip)
  url="http://ugin.core.ufanet.ru//api/find_by_ip?user=fast_k&password=H347MHafcn&ip="+ip+"&city_id=32"
  json = open(url).read
  obj = JSON.parse(json)
  return obj["item"]["id"].to_s
end
#==========получаем интерфейс snr===================
def get_ifsnr(ip)
  cmd1="sh interface|include (Primary)"
  tn = Net::Telnet::new(
      "Host" => ip,
      "Timeout"=>false,
      "Prompt"=>/#/
  )
  tn.login(@user,@password)#{|c| print c}
  return tn.cmd(cmd1)#{|c| print c}
  tn.close#{|c| print c}
end
#==============смотрим сетку на верхней железке=====
def get_mask()
  id=get_id(@upsw)
  p url="http://ugin.core.ufanet.ru/api/network_object/"+id.to_s+"?user=fast_k&password=H347MHafcn"
  json = open(url).read
  obj = JSON.parse(json)
  p @mod_up=obj["item"]['model_name'].to_s
  if @mod_up.scan(/SNR/).size==0
    return   sh_sw(@upsw).to_s.scan(/Subnet Mask.+\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/)[0].scan(/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/)[0]
  else
    return  get_ifsnr(@upsw).to_s.scan(/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/)[1]
  end
end
#===============считаем шлюз по маске и ипу===============
def get_getway()
  p @ip
  if  @mask=="255.255.255.0"
      s=@ip.scan(/\d{1,3}\.\d{1,3}\.\d{1,3}\./)[0].to_s+"1"
    return s
  elsif @mask=="255.255.255.192"
    if  @ip.scan(/\d{1,3}/)[3].to_i<63
      s=@ip.scan(/\d{1,3}\.\d{1,3}\.\d{1,3}\./)[0].to_s+"1"
      return s
    elsif @ip.scan(/\d{1,3}/)[3].to_i<127
      s=@ip.scan(/\d{1,3}\.\d{1,3}\.\d{1,3}\./)[0].to_s+"65"
      return s
    elsif @ip.scan(/\d{1,3}/)[3].to_i<255
      s=@ip.scan(/\d{1,3}\.\d{1,3}\.\d{1,3}\./)[0].to_s+"129"
      return s
    end
  end
end
#===========инициация переменных=====================
def init()


   @system_port=system_port()
   @client_port=client_port()
   @kv=@upsw.scan(/\d{1,3}/)[2]
   @ip=get_free_ip().to_s
   @file_write=Date.today.to_s+"___"+@ip+'.org'
  id=get_id(@upsw)
  url="http://ugin.core.ufanet.ru/api/network_object/"+id.to_s+"?user=fast_k&password=H347MHafcn"
  json = open(url).read
  obj = JSON.parse(json)
  i=0
  while i<obj["item"]['parameters_list'].size
    if obj["item"]['parameters_list'][i]['parameter_name']=="VLAN - \u0441\u0438\u0441\u0442\u0435\u043c\u043d\u044b\u0439"
        @system_vlan= obj["item"]['parameters_list'][i]['parameter_value']['vid'].to_s
    elsif obj["item"]['parameters_list'][i]['parameter_name']=="VLAN - VPN \u0444\u0438\u0437."
        @vpn_fiz_vlan=obj["item"]['parameters_list'][i]['parameter_value']['vid'].to_s
    elsif obj["item"]['parameters_list'][i]['parameter_name']=="VLAN - \u0431\u0435\u0437 \u043b\u043e\u043a\u0430\u043b"
       @nol_vlan=obj["item"]['parameters_list'][i]['parameter_value']['vid'].to_s
    elsif obj["item"]['parameters_list'][i]['parameter_name']=="VLAN - IPN"
        @ipn_vlan=obj["item"]['parameters_list'][i]['parameter_value']['vid'].to_s
    elsif obj["item"]['parameters_list'][i]['parameter_name']=="VLAN - VOIP"
       @phone_vlan=obj["item"]['parameters_list'][i]['parameter_value']['vid'].to_s
    elsif obj["item"]['parameters_list'][i]['parameter_name']=="VLAN - Remote"
       @remote_vlan=obj["item"]['parameters_list'][i]['parameter_value']['vid'].to_s
    elsif obj["item"]['parameters_list'][i]['parameter_name']=="VLAN - VPN \u044e\u0440 \u043b\u0438\u0446\u0430"
        @vpn_ur_vlan=obj["item"]['parameters_list'][i]['parameter_value']['vid'].to_s
    end

    i+=1
  end
  p @mask=get_mask().to_s
  p @getway=get_getway()


end
#==========генерируем конфиг=========================
def configure_d()

  file='config/'+@model+'.org'
  config = File.open(file){ |file| file.read }
  config = config.gsub('<up>',@uplink)
  config = config.gsub('<client port>',@client_port)
  config = config.gsub('<client port>',@client_port)
  config = config.gsub('<system port>',@system_port)
  config = config.gsub('<remote vlan>',@remote_vlan)
  config = config.gsub('<system vlan>',@system_vlan)
  config = config.gsub('<phone vlan>',@phone_vlan)
  config = config.gsub('<ipn vlan>',@ipn_vlan)
  config = config.gsub('<nol vlan>',@nol_vlan)
  config = config.gsub('<vpn ur vlan>',@vpn_ur_vlan)
  config = config.gsub('<vpn fiz vlan>',@vpn_fiz_vlan)
  config = config.gsub('<ip>',@ip)
  config = config.gsub('<mask>',@mask)
  config = config.gsub('<getwey>',@getway)
  config = config.gsub('<kv>',@kv)
  config = config.gsub('<address>',@address)
  config = config.gsub('<serial>',@serial)

  File.open("configured/"+@file_write, 'w'){ |file| file.write config }
  config
end

#============генерируем конфиг snr=============================
def configure_s()
  file='config/'+@model+'.cfg'
  config = File.open(file){ |file| file.read }
  #подготовка шаблона клиенского порта
  conf_client_port=File.open("config/client port.cfg"){ |file| file.read }
  conf_client_port=conf_client_port.gsub('<vpn fiz vlan>',@vpn_fiz_vlan)
  #продготовка шаблона для системного порта
  conf_system_port=File.open("config/system port.cfg"){ |file| file.read }
  conf_system_port=conf_system_port.gsub('<ip>',@ip)
  conf_system_port=conf_system_port.gsub('<remote vlan>',@remote_vlan)
  conf_system_port=conf_system_port.gsub('<system vlan>',@system_vlan)
  conf_system_port=conf_system_port.gsub('<phone vlan>',@phone_vlan)
  conf_system_port=conf_system_port.gsub('<ipn vlan>',@ipn_vlan)
  conf_system_port=conf_system_port.gsub('<nol vlan>',@nol_vlan)
  conf_system_port=conf_system_port.gsub('<vpn ur vlan>',@vpn_ur_vlan)
  conf_system_port=conf_system_port.gsub('<vpn fiz vlan>',@vpn_fiz_vlan)
  #заменяем что можем в шаблоне snr
  config = config.gsub('<up>',@uplink)
  config = config.gsub('<remote vlan>',@remote_vlan)
  config = config.gsub('<system vlan>',@system_vlan)
  config = config.gsub('<phone vlan>',@phone_vlan)
  config = config.gsub('<ipn vlan>',@ipn_vlan)
  config = config.gsub('<nol vlan>',@nol_vlan)
  config = config.gsub('<vpn ur vlan>',@vpn_ur_vlan)
  config = config.gsub('<vpn fiz vlan>',@vpn_fiz_vlan)
  config = config.gsub('<ip>',@ip)
  config = config.gsub('<mask>',@mask)
  config = config.gsub('<getwey>',@getway)
  config = config.gsub('<kv>',@kv)
  config = config.gsub('<address>',@address)
  config = config.gsub('<serial>',@serial)
   arr_client_port=@client_port.scan(/\d{1,2}/)
   arr_system_port=@system_port.scan(/\d{1,2}/)
  #конфигурируем клиенские интерфейсы
  i=0
  while i<arr_client_port.size
    po=@if_SNR[@model].to_s+arr_client_port[i].to_s
    config = config.gsub('<client port>',po.to_s)
    config = config.gsub('<conf client>',conf_client_port)
    i+=1
  end
  i=0
  while i<arr_system_port.size
    po=@if_SNR[@model].to_s+arr_system_port[i].to_s
    config = config.gsub('<system port>',po.to_s)
    config = config.gsub('<conf system>',conf_system_port)
    i+=1
  end
  #изолента груп
  i=0
  arr_isolate=@downlink.scan(/\d{1,2}/)+@client_port.scan(/\d{1,2}/)
  while i<arr_isolate.size
    po=@if_SNR[@model].to_s+arr_isolate[i].to_s
    config = config.gsub('<usolate port>',po+"\nisolate-port group Down switchport interface <usolate port>")
    i+=1
  end
  #удалим хвосты в конфиге
  config = config.gsub(' Interface <client port>\n <conf client>\n!',' ')
  config = config.gsub(' Interface <system port>\n <conf system>\n!',' ')
  config = config.gsub('Interface <system port>','')
  config = config.gsub('<conf system>','')
  config = config.gsub('Interface <client port>','')
  config = config.gsub('<conf client>','')
  config = config.gsub('isolate-port group Down switchport interface <usolate port>','')
  config = config.gsub(config.scan(/!\s+!/)[5].to_s,'!')
  #config = config.gsub(config.scan(/!\s+!/)[6].to_s,'!')
  i=0
  File.open("configured/"+@file_write, 'w'){ |file| file.write config }
   config
end

#============поднимаем интерфейс в нужной влане=================
  def iface_up()
system "ifdown eth1"
system "ifdown eth2"
system "ifdown eth3"
system "ifdown eth4"
if @remote_vlan=="76"
  system "ifup eth1"
elsif @remote_vlan=="77"
  system "ifup eth2"
elsif @remote_vlan=="78"
  system "ifup eth3"
elsif @remote_vlan=="79"
  system "ifup eth4"
end
end

#==========Преднастройка порта========
def conf_port_dlink1(ip , port)
  cmd="sh sw"
  tn = Net::Telnet::new(
      "Host" => ip,
      "Timeout"=>false,
      "Prompt"=>/ All/
  )
  c=tn.print(@user+"\n"+@password+"\n")
  tn.waitfor(/#/)
  #Удалим все квартальныек вланы на порту
  tn.print("\n"+"conf vlan "+@remote_vlan+" delete "+port+"\n")
  tn.waitfor(/#/)
  tn.print("\n"+"conf vlan "+@system_vlan +" delete "+port+"\n")
  tn.waitfor(/#/)
  tn.print("\n"+"conf vlan "+@phone_vlan +" delete "+port+"\n")
  tn.waitfor(/#/)
  tn.print("\n"+"conf vlan "+@ipn_vlan +" delete "+port+"\n")
  tn.waitfor(/#/)
  tn.print("\n"+"conf vlan "+@nol_vlan +" delete "+port+"\n")
  tn.waitfor(/#/)
  tn.print("\n"+"conf vlan "+@vpn_ur_vlan +" delete "+port+"\n")
  tn.waitfor(/#/)
  tn.print("\n"+"conf vlan "+@vpn_fiz_vlan +" delete "+port+"\n")
  tn.waitfor(/#/)
  #tn.cmd(""){|c| print c}
  #Настройка порта для уданенной настройки
  tn.print("\n"+"config port_security ports "+port +" admin_state disable"+"\n")
  tn.waitfor(/#/)
  tn.print("\n"+"config vlan "+@remote_vlan+" add u "+port +"\n")
  tn.waitfor(/#/)

  tn.close

end

def conf_port_dlink2(ip , port)
  cmd="sh sw"
  tn = Net::Telnet::new(
      "Host" => ip,
      "Timeout"=>false,
      "Prompt"=>/ All/
  )
  c=tn.print(@user+"\n"+@password+"\n")
  tn.waitfor(/#/)
   @remote_vlan
   @system_vlan
   @phone_vlan
   @ipn_vlan
   @nol_vlan
   @vpn_fiz_vlan
   @vpn_ur_vlan
  #добавим вланы акссесом
  tn.print("\n"+"conf vlan "+@remote_vlan+" add t "+port+"\n")
  #tn.waitfor(/#/)
  tn.print("\n"+"conf vlan "+@system_vlan +" add t "+port+"\n")
  #tn.waitfor(/#/)
  tn.print("\n"+"conf vlan "+@phone_vlan +" add t "+port+"\n")
  #tn.waitfor(/#/)
  tn.print("\n"+"conf vlan "+@ipn_vlan +" add t "+port+"\n")
  #tn.waitfor(/#/)
  tn.print("\n"+"conf vlan "+@nol_vlan +" add t "+port+"\n")
  #tn.waitfor(/#/)
  tn.print("\n"+"conf vlan "+@vpn_ur_vlan +" add t "+port+"\n")
  #tn.waitfor(/#/)
  tn.print("\n"+"conf vlan "+@vpn_fiz_vlan +" add t "+port+"\n")
  #tn.waitfor(/#/)
  #tn.cmd(""){|c| print c}
  #настраисваем как системный
  tn.print("\n"+"config loopdetect ports "+port +" state disable"+"\n")
  #tn.waitfor(/#/)
  tn.print("\n"+"config traffic control "+port+" threshold 4096"+"\n")
  #tn.waitfor(/#/)
  tn.print("\n"+"config bandwidth_control "+port+" rx_rate no_limit tx_rate no_limit"+"\n")
  #tn.waitfor(/#/)
  tn.print("\n"+"config lldp ports "+port+" admin_status tx_and_rx"+"\n")
  #tn.waitfor(/#/)
  tn.print("\n"+"config lldp ports "+port+" mgt_addr ipv4 "+@upsw+"enable"+"\n")
  #tn.waitfor(/#/)
  tn.print("\n"+"sa"+"\n")
  #tn.waitfor(/#/)
  #tn.close
  #tn.cmd("\n"){|c| print c}
end

#=============конфигурируем порт snr для удаленки ===========
def conf_port_snr1(ip,po)
  port=@if_SNR[@mod_up].to_s+po.to_s
   cmd1="conf"
   cmd2="interface "+port
   cmd3="switchport mode access"
   cmd4="switchport access vlan "+@remote_vlan
  tn = Net::Telnet::new(
      "Host" => ip,
      "Timeout"=>false,
      "Prompt"=>/#/
  )
  tn.login(@user,@password)#{|c| print c}
  tn.cmd(cmd1)#{|c| print c}
  tn.cmd(cmd2)#{|c| print c}
  tn.cmd(cmd3)#{|c| print c}
  tn.cmd(cmd4)#{|c| print c}
  tn.close#{|c| print c}

end


#=============конфигурируем порт snr как системный ===========
def conf_port_snr2(ip,po)
  port=@if_SNR[@mod_up].to_s+po.to_s
  cmd1="conf"
  cmd2="interface "+port
  cmd3="media-type copper-preferred-auto"
  cmd4="storm-control broadcast 8188"
  cmd5="storm-control multicast 8188"
  cmd6="service-policy input 1"
  cmd7="lldp management-address tlv 10.52.128.108"
  cmd8="switchport mode hybrid"
  cmd9="switchport hybrid allowed vlan "+@remote_vlan+","+@system_vlan+","+@phone_vlan+","+@ipn_vlan+","+@nol_vlan+","+@vpn_fiz_vlan+","+@vpn_ur_vlan+" tag"
  tn = Net::Telnet::new(
      "Host" => ip,
      "Timeout"=>false,
      "Prompt"=>/#/
  )
  tn.login(@user,@password)#{|c| print c}
  tn.cmd(cmd1)#{|c| print c}
  tn.cmd(cmd2)#{|c| print c}
  tn.cmd(cmd3)#{|c| print c}
  tn.cmd(cmd4)#{|c| print c}
  tn.cmd(cmd5)#{|c| print c}
  tn.cmd(cmd6)#{|c| print c}
  tn.cmd(cmd7)#{|c| print c}
  tn.cmd(cmd8)#{|c| print c}
  tn.cmd(cmd9)#{|c| print c}

  tn.print("\n wr \n"){|c| print c}
  tn.print("y \n") {|c| print c}
  #tn.waitfor("#")
  #tn.close{|c| print c}

end


def conf_port_snr1(ip,po)
  port=@if_SNR[@mod_up].to_s+po.to_s
  cmd1="conf"
  cmd2="interface "+port
  cmd3="switchport mode access"
  cmd4="switchport access vlan "+@remote_vlan
  tn = Net::Telnet::new(
      "Host" => ip,
      "Timeout"=>false,
      "Prompt"=>/#/
  )
  tn.login(@user,@password)#{|c| print c}
  tn.cmd(cmd1)#{|c| print c}
  tn.cmd(cmd2)#{|c| print c}
  tn.cmd(cmd3)#{|c| print c}
  tn.cmd(cmd4)#{|c| print c}
  tn.close#{|c| print c}
end

#=============заливаем конфиг на dlink snr======
def download_cfg_s(ip)
  cmd1="conf t"
  cmd2="load running-config from tftp://192.168.1.2/"+@file_write
  tn = Net::Telnet::new(
      "Host" => ip,
      "Timeout"=>false,
      "Prompt"=>/#/
  )
  tn.login("admin","admin"){|c| print c}
  tn.cmd(cmd1){|c| print c}
  tn.cmd(cmd2){|c| print c}
  #tn.close#{|c| print c}
end

#=============заливаем конфиг на dlink==========
def download_cfg_d(ip)
  @file_write.to_s
  if @model.scan(/DES/)[0].to_s!=""

    cmd="\ndownload configuration 10.90.90.93 "+@file_write+"\n"
  elsif @model.scan(/DGS/)[0].to_s!=""
    cmd="\ndownload cfg_fromTFTP 10.90.90.93 src_file "+@file_write+"\n"
  end
  tn = Net::Telnet::new(
      "Host" => ip,
      "Timeout"=>false,
      "Prompt"=>/ All/
  )
  tn.print("\n"+"\n")
  tn.waitfor(/#/)
  tn.print(cmd)
  tn.waitfor(/#/)
  #tn.cmd("\n"){|c| print c}


  #tn.close
end

#===========алгоритм работы===========
def go()
  init()
  if p @mod_up.scan(/SNR/).size==0
  conf_port_dlink1(@upsw,@upswport)
  else conf_port_snr1(@upsw,@upswport)
  end
   if @model.scan(/SNR/).size==0
  def_ip="10.90.90.90"
   else
     def_ip="192.168.1.1"
   end


  while p !pingecho(def_ip,5)
    sleep 1
  end
  if @model.scan(/SNR/).size==0 #dlink
    #  def iface_up()#Подгимаем нужный интерфейс
    #Готовим порт вышестоящей железки для настройки сброшеного оборудования
    configure_d() #инициируем необходимые параметры.На их основе генерируем конфиг из шаблона
    download_cfg_d("10.90.90.90")
    sleep 15

  else @model.scan(/SNR/).size==1 #snr
    #  def iface_up()#Подгимаем нужный интерфейс
    #Готовим порт вышестоящей железки для настройки сброшеного оборудования
    p "snr"
  configure_s() #инициируем необходимые параметры.На их основе генерируем конфиг из шаблона
    download_cfg_s("192.168.1.1")
  sleep 15
    p "endsnr"
  end

  if p @mod_up.scan(/SNR/).size==0
    conf_port_dlink2(@upsw,@upswport)
  else conf_port_snr2(@upsw,@upswport)
  end
  while p !pingecho(@ip,5)
    sleep 1
  end
end

go()
#init()
#conf_port_snr2(@upsw,@upswport)
#init()
#configure_s()






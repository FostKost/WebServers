#coding: utf-8
require 'rubygems'
require 'json'
require 'open-uri'
require 'net-telnet'
dev="10.52.211.66"
port="0"
@vlan="814"
 @user="fast_k"
 @password="H347MHcerf"
cmd1="sh ports 1"
@stop=["281692","889530","273003","273003","889489","889239","262344","278335","263242","889531","263243","913647",""]# id коммутаторов на цк
@count=0;
def telnetd_vlan_d(ip,vlan,down,f)#добавление вланы dowlink
  case f
    when "t"
       cmd1="\n"+"create vlan " + vlan.to_s + " t " + vlan.to_s+"\n"
       cmd2="\n"+"conf vlan "+ vlan.to_s  + " add t " +down.to_s+"\n"
    when "u"
      cmd1="\n"+"create vlan " + vlan.to_s  + " t " + vlan.to_s+"\n"
      cmd2="\n"+"conf vlan "+ vlan.to_s  + " add u " +down.to_s+"\n"
  end

  tn = Net::Telnet::new(
                       "Host" => ip,
                       "Timeout"=>5,
                       "Prompt"=>/#/
                       )
  c=tn.print(@user+"\n"+@password+"\n")

  tn.waitfor(/#/){|c| print c}
  tn.print(cmd1)
  tn.waitfor(/#/){|c| print c}
  tn.print(cmd2)
  tn.waitfor(/#/){|c| print c}
  tn.cmd("sa"){|c|  print c}
  tn.waitfor(/#/){|c| print c}

  #tn.close


end

def telnetd_vlan_u(ip,vlan,up)# добавление вланы Uplonk

      cmd1="\n"+"conf vlan "+ vlan.to_s  + " add t " +up.to_s+"\n"


  tn = Net::Telnet::new(
      "Host" => ip,
      "Timeout"=>5,
      "Prompt"=>/#/
  )
  c=tn.print(@user+"\n"+@password+"\n")
      tn.waitfor(/#/){|c| print c}

  tn.print(cmd1)
  tn.waitfor(/#/){|c| print c}
  tn.cmd("sa"){|c|  print c}
  tn.waitfor(/#/){|c| print c}

  tn.close


end

def telnetd_vlan(ip,vlan,up,down)# добавление вланы Uplonk
  cmd1="\n"+"create vlan " + vlan.to_s  + " t " + vlan.to_s+" \n"
  cmd2="\n"+"conf vlan "+ vlan.to_s  + " add t " +down.to_s+" \n"
  cmd3="\n"+"conf vlan "+ vlan.to_s  + " add t " +up.to_s + " \n"


  tn = Net::Telnet::new(
      "Host" => ip,
      "Timeout"=>false,
      "Prompt"=>/#/
  )
  c=tn.print(@user+"\n"+@password+"\n")
  tn.waitfor(/#/)
   tn.print(cmd1)
  tn.waitfor(/#/)
   tn.print(cmd2)
  tn.waitfor(/#/)
   tn.print(cmd3)
  #tn.waitfor(/#/)
   tn.print("sa")
  tn.waitfor(/#/)

  tn.close


end



def telnetd_vlan_del(ip,vlan) # удаление вланы
  cmd1="\n"+"delete vlan "+ vlan.to_s+"\n"


  tn = Net::Telnet::new(
      "Host" => ip,
      "Timeout"=>false,
      "Prompt"=>/#/
  )
  c=tn.print(@user+"\n"+@password+"\n")
  tn.waitfor(/#/)

  tn.print(cmd1)
  tn.waitfor(/#/)
  tn.print("sa")
  tn.waitfor(/#/)

  tn.close


end



def get_id(ip)
url="http://ugin.core.ufanet.ru//api/find_by_ip?user=fast_k&password=H347MHafcn&ip="+ip+"&city_id=32"
json = open(url).read
obj = JSON.parse(json)
  return obj["item"]["id"].to_s
end


def switch_tree(device_id,ip,downlink)
#=========Получаем json=============
 @stop.push(device_id)

p url="http://ugin.core.ufanet.ru//api/get_object_port_links?network_object_id="+device_id+"&user=fast_k&password=H347MHafcn"
json = open(url).read
obj = JSON.parse(json)


#============ПОДКЛЮЧИТЬСЯ ПО ТЕЛНЕТ============
#Создаем vlan
#прокидываем влану на downlink

#=========json приготовлен.Далее спеуии по вкусу=============

#=========поиск порта Uplink===========
i=0


  while i < obj['item']['ports'].size

       id1=obj['item']['ports'][i]['port_category'].to_s #тип порта
      n=obj['item']['ports'][i]['name'].to_s #порта

    #  ||(id1=="10"&&id2=="1") ||id1=="10"

      if ((id1=="1"||id1=="2"||id1=="10")  && n!=downlink )

        if (obj['item']['ports'][i]['linked_port']['linkedportlinktype']!=nil)

           id2=obj['item']['ports'][i]['linked_port']['linkedportlinktype']['id'].to_s #назначение порта
            if  ((id1=="1"&&id2=="1")||(id1=="2"&&id2=="3")||(id1=="10"&&id2=="3"))
              #==========Получаем данные==============
              port_u=obj['item']['ports'][i]['name'].to_s
              next_c=obj['item']['ports'][i]['linked_port']['device']['id'].to_s
              down_on_nex=obj['item']['ports'][i]['linked_port']['port']['name'].to_s
              next_ip=obj['item']['ports'][i]['linked_port']['device']['string_view'].to_s.scan(/10.52.\d{1,3}.\d{1,3}/)[0]

              #=========Получил данные=============

              #=========работаем с полученными данными=============
              #Еби гусей!!!
              #пробрасываем влану на  uplink
                #===========ЗАКРЫВАЕМ ТЕЛНЕТ===============
                  p next_c
                  if p (!@stop.include?(next_c))

                  switch_tree(next_c,next_ip,down_on_nex)
                  p i
                  p "Device "+device_id+" IP "+ ip +" downlink " + downlink + " uplink " + port_u
                  telnetd_vlan(ip,@vlan, port_u, downlink)
                  #telnetd_vlan_del(ip,@vlan)
                  @count+=1
                  end



              #=========конец работы===============================


            end
        end
      end
    i+=1
  end
#===========конец поиска ===============




end


switch_tree(get_id(dev),dev,port)
#telnetd_vlan_d(dev,@vlan,port,"u")
p @count
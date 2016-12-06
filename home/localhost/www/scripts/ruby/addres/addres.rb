require 'rubygems'
require 'json'
require 'open-uri'
@addres=""

def get_id(ip)
  url="http://ugin.core.ufanet.ru//api/find_by_ip?user=fast_k&password=H347MHafcn&ip="+ip+"&city_id=32"
  json = open(url).read
  obj = JSON.parse(json)
  return obj["item"]["id"].to_s
end




ips=File.open("ip.txt"){|file| file.read}
ip=ips.scan(/10.52.\d{1,3}.\d{1,3}/)
p le=ip.size
i=0
p ip
while i<le


  id=get_id(ip[i])
  url="http://ugin.core.ufanet.ru/api/network_object/"+id.to_s+"?user=fast_k&password=H347MHafcn"
  json = open(url).read
  obj = JSON.parse(json)
  l=obj["item"]['parameters_list'].size
  j=0
  while obj["item"]['parameters_list'][j]['parameter_name']!="\u041c\u0435\u0441\u0442\u043e\u043f\u043e\u043b\u043e\u0436\u0435\u043d\u0438\u0435"
  j=j+1

  end
  @addres=@addres+ip[i]+" : "+obj["item"]['parameters_list'][j]['parameter_value']['string_view']+"\n"
  obj["item"]['parameters_list'][j]['parameter_value']['string_view'].size
  i=i+1
end
print @addres
File.open("adressout.txt", 'w'){ |file| file.write @addres }


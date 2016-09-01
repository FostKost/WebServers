require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE


def post_req(file_name)# функция для отправуи post запроса
  require 'net/http'
  # формируем данные для запросв
  p st=ARGV[0].to_s+' '+ARGV[1].to_s#склейка началого времени из 1 и 2 аргумента
  p en=ARGV[2].to_s+' '+ARGV[3].to_s#склейка конечного времени из 3 и 4  аргумента
  postData = Net::HTTP.post_form(URI.parse('https://info.core.ufanet.ru/events_report/'),
  {
    'zabbix' => 'Оренбург',#город
    'start' => st.to_s,#время начала
    'end' => en.to_s,# время конча
    'filter' => '',
    'group' => 'kvartal',# группа узлов
    'trigger' => 'Ping Check',# тригер содержит
    'ok'=>'Ok'#кнопка сабмит
    })
    html= postData.body # присваиваем ответ запроса переменной
    File.open(file_name.to_s, 'w'){ |file| file.write html }# запись в файл.
  end

  def query_select1(sql)#sql запрос для mysql
    require 'mysql2'#используем компонет "mysql2"
    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "sspo")#коннект  к бд
    result = client.query(sql.to_s)#запрос
    result.each{ |r| puts r["end"].to_s }#действия с извлеченными данными
    client.close
  end

  def query_insert_all(sql)
    require 'mysql2'#используем компонет "mysql2"
    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "sspo")#коннект  к бд
    result = client.query(sql.to_s)#запрос
    #p result
    client.close
  end

  def pars(filef)#парсер файла filef
    require 'mysql2'#используем компонет "mysql2"
    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "sspo")#коннект  к бд
    b=File.open(filef){|file| file.read}#Чтение файла в переменную
    a=b.scan(/<tr>[\s,\S]*?<.{1}tr>/)#Вычленение  строк столбцов
    l=a.size#количество полученых строк
    i=3# пропкскаем элементы оформления
    k=nil
    kv=nil
    leng=0
    arrey=nil
    rese='DELETE FROM `drop`'# запрос для очистки
    #query_insert_all(rese)# очистка
    while i<l#цикл по всем оставшимся строкам
      if a[i].scan(/10.52.\d{1,3}.\d{1,3}/)==[]#если строка не содержит IP то
        m=a[i].scan(/20\d{2}-\d{2}-\d{2}\s{1}\d{2}:\d{2}:\d{2}/)#вычленияется время
        n=m[0]#время начала
        c=m[1]#время конца
        begin#действия с данными
          #Формирование запросса на добавление

          ins='INSERT INTO `drop`  (  `kv` ,  `ip` ,  `begin` ,  `end` )  VALUES('+kv.to_s+',\''+k[0].to_s+'\',\''+n.to_s+'\',\''+c.to_s+'\');'
          #arrey[lengh,0]=kv.to_s
          #arrey[lengh,1]=k[0].to_s
          #arrey[lengh,2]=n.to_s
          #arrey[lengh,3]=c.to_s
          #leng=lengh+1

          #sleep 0.1
          result = client.query(ins.to_s)#запрос
          #query_insert_all(ins)#исполнение запроса.
          #puts "kvartal:#{kv} ip:#{k[0]} nach:#{n} co:#{c}"
        end
      else# иначе если  если в строке IP
        k=a[i].scan(/10.52.\d{1,3}.\d{1,3}/)#ip
        kv=k[0].scan(/\d{1,3}/)[2]
      end
      i=i+1#на новую строку
    end
  end

def eve()
   rese='DELETE FROM `event`'# запрос для очистки
  query_insert_all(rese)
  ev='INSERT INTO `event`( `kv`, `begin`, `end`,`col`)
  SELECT  `kv` ,`begin`,`end`, COUNT( * ) AS  `c`
  FROM  `drop`
  GROUP BY  `kv`,
  UNIX_TIMESTAMP(begin)div(10*60),
  UNIX_TIMESTAMP(`end`)div(10*60)
  ORDER BY  `c` DESC'
      query_insert_all(ev)
end




  post_req("Отчёт по событиям в Zabbix.html")#Post запрос ии получение  HTML
  pars("Отчёт по событиям в Zabbix.html")#  парсинг и внесение в бд.
  #eve()
  #query_insert_all(ins)
  #query_select1("SELECT * FROM `drop`")

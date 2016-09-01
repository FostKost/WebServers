require 'net/http'
postData = Net::HTTP.post_form(URI.parse('http://info.core.ufanet.ru/events_report/'), {'zabbix' => 'Оренбург',
                                                                    'start' => '2016-03-08 15:10:00',
                                                                    'end' => '2016-03-09 15:10:00',
                                                                    'filter' => '',
                                                                    'group' => 'kvartal',
                                                                    'trigger' => 'Ping Check',
                                                                    'ok'=>'Ok'
                                                                    })
puts html= postData.body
File.open('выходные данные.txt', 'w'){ |file| file.write html }

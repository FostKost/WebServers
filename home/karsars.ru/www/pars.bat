
set dd=%DATE:~0,2%
set mm=%DATE:~3,2%
set yyyy=%DATE:~6,4%
set curdate=%yyyy%-%mm%-%dd%
start "" "C:\WebServers\home\localhost\www\parse\ruby.rb" %curdate% 00:00:00 %curdate% 23:59:29
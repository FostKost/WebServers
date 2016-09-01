<html>
    <head>
      <meta charset="utf-8">
      <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
      <style>
   .table1{
     width: 80%;
     height: 80%;
     margin:  0 auto;
     position: absolute;
     overflow: auto;
     position: absolute;
     top: 160px; left: 0; bottom: 0; right: 0;

   }
   .form1{
     width: 50%;
     height: 20%;
     margin: 0 auto;
     overflow: auto;
     position: absolute;
     top: 0; left: 0; bottom: 0; right: 0;

     }
     .header{
       width: 100%;
       height: 15%;
       margin: 0 auto;
       overflow: auto;
       position: absolute;
       top: 0; left: 0; bottom: 0; right: 0;
       background-color: #A4A4A4
       }


   .submit1{
     position: absolute; /* Абсолютное позиционирование */
     top:  33px; /* Положение от верхнего края */
     left:  500px; /* Положение от левого края */
     line-height: 1px;
   }
   .but1{
     position: absolute; /* Абсолютное позиционирование */
     top:  70px; /* Положение от верхнего края */
     left:  150px; /* Положение от левого края */
     line-height: 1px;
   }
   .but2{
     position: absolute; /* Абсолютное позиционирование */
     top:  70px; /* Положение от верхнего края */
     left:  270px; /* Положение от левого края */
     line-height: 1px;
   }
   .but3{
     position: absolute; /* Абсолютное позиционирование */
     top:  70px; /* Положение от верхнего края */
     left:  370px; /* Положение от левого края */
     line-height: 1px;
   }

   .butnew{
     position: absolute; /* Абсолютное позиционирование */
     top:  70px; /* Положение от верхнего края */
     left:  10px; /* Положение от левого края */
     line-height: 1px;}


   .begin1 {
    position: absolute; /* Абсолютное позиционирование */
    top:  20px; /* Положение от верхнего края */
    left:  20px; /* Положение от левого края */
    line-height: 1px;

   }
   .end1 {
    position: absolute; /* Абсолютное позиционирование */
    top:  20px; /* Положение от верхнего края */
    left:  275px; /* Положение от левого края */
    line-height: 1px;
   }




  </style>
    </head>
    <body>

        <!-- Содержание страницы -->
        <div class="header"></div>
        <div class="form1">
        <form  method="POST" class="form-search"  >
         <div class="begin1">
          <p><b> Начальное время:</b></p>
          <Br>
            <input type="date" name="begin" height="30" class="input-medium search-query"  style="width: 200 ;height:30" value="гггг.мм.дд">
         </div>
         <div class="end1">
           <p><b>Конечное время:</b></p>
           <Br>
             <input type="date" name="end" size="20" class="input-medium search-query" style="width: 200 ;height:30" value="гггг.мм.дд" >
         </div>
         <div class="submit1">
           <input class="btn btn-inverse" type="submit"  name="pars" value="ок">
         </div>
         <datepicker type="grid" value="2007-03-26"/>
         </form>


       <?php
       $f=0;
       set_time_limit(0);
       $host='localhost'; // имя хоста (уточняется у провайдера)
       $database='sspo'; // имя базы данных, которую вы должны создать
       $user='root'; // заданное вами имя пользователя, либо определенное провайдером
       $pswd=''; // заданный вами пароль
           # Если кнопка нажата
           if( isset( $_POST['pars'] ) )
           {
               # Тут пишете код, который нужно выполнить.
               # Пример:

               #echo 'Кнопка нажата!';
               $b=$_POST['begin']." 00:00:00";
               $e=$_POST['end']." 23:59:59";
               $b=str_replace("T"," ",$b);
               $e=str_replace("T"," ",$e);
               $rub="ruby ".$b." ".$e;
               $rub=str_replace("T"," ",$rub);
               echo "<div class=\"butnew\">";
               echo "<a class=\"btn btn-success\"href=\"/parse/\">Новый запрос</a>";
               echo "</div class=\"but1\">\n";
                 echo "<div class=\"but1\">";
                 echo "<a class=\"btn btn-primary\"href=\"/parse/kvartaly.php?b=".$b."&e=".$e."&f=".$f."\">По кварталам</a>";
                 echo "</div class=\"but1\">\n";
                 echo "<div class=\"but2\">";
                 echo "<a class=\"btn btn-primary\" href=\"/parse/vkvartale.php?b=".$b."&e=".$e."&f=".$f."\">В квартале</a>";
                 echo "</div class=\"but2\">\n";
                 echo "<div class=\"but3\">";
                 echo "<a class=\"btn btn-primary\" href=\"/parse/sobytiya.php?b=".$b."&e=".$e."&f=".$f."\">События</a>";
                 echo "</div class=\"but3\">\n";

                 echo "</div>\n";

                 echo "<div class=\"table1\">\n";
               #echo $rub;#"ruby.rb 2016-03-08 15:10:00 2016-03-09 15:10:00"
               #echo "script complete!";
               $dbh = mysql_connect($host, $user, $pswd) or die("Не могу соединиться с MySQL.");
               mysql_select_db($database) or die("Не могу подключиться к базе.");
               $query = "SELECT * FROM `drop`WHERE `begin` BETWEEN  \"".$b."\" AND  \"".$e."\"";
               #echo $rub;
               $res = mysql_query($query);
               echo "<table class=\"table table-bordered table-hover\" >\n";
                echo "<caption>"."Отчет Zabbix"."</caption>\n";
                echo "<thead>\n";
                echo "<tr>\n";
                echo "<th>"."#"."</th>\n";
                echo "<th>"."IP"."</th>\n";
                echo "<th>"."Начало"."</th>\n";
                echo "<th>"."Конец"."</th>\n";
                echo "<th>"."Квартал"."</th>\n";
                echo "</tr>\n";
                echo "</thead>\n";
                echo "<tbody>\n";

               while($row = mysql_fetch_array($res))
               { echo "<tr>\n";
                 echo "<td>".$row['id']."</td>\n";
                 echo "<td>".$row['ip']."</td>\n";
                 echo "<td>".$row['begin']."</td>\n";
                 echo "<td>".$row['end']."</td>\n";
                 echo "<td>".$row['kv']."</td>\n";
                 echo "</tr>\n";
               }
               echo "</tbody>\n";
               echo "</table>\n";
               echo "</div class=\"table1\">";
               mysql_close($dbh);


               {
               echo "scrip uncomplete";
               }
           }
       ?>


    </body>
</html>

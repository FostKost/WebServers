<html>
    <head>
      <meta charset="utf-8">
      <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
      <style>
   .table1{
     width: 60%;
     height: 80%;
     margin:  0 auto;
     position: absolute;
     overflow: auto;
     position: absolute;
     top: 160px; left: 0; bottom: 0; right: 0;

   }
   .form1{
     width: 50%;
     height: 15%;
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
     top:  25px; /* Положение от верхнего края */
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
   .but10m{
     position: absolute; /* Абсолютное позиционирование */
     top:  103px; /* Положение от верхнего края */
     left:  10px; /* Положение от левого края */
     line-height: 1px;}



  </style>
    </head>
    <body >

        <!-- Содержание страницы -->
        <div class="header"></div>
        <div class="form1">



       <?php
       $b=$_GET["b"];
       $e=$_GET["e"];
       $f=$_GET["f"];
       $fn=($f+1)%2;
       $host='localhost'; // имя хоста (уточняется у провайдера)
       $database='sspo'; // имя базы данных, которую вы должны создать
       $user='root'; // заданное вами имя пользователя, либо определенное провайдером
       $pswd=''; // заданный вами пароль

       echo "<div class=\"butnew\">";
       echo "<a class=\"btn btn-primary\"href=\"/parse/\">Новый запрос</a>";
       echo "</div class=\"but1\">\n";
         echo "<div class=\"but1\">";
         echo "<a class=\"btn btn-primary\"href=\"/parse/kvartaly.php?b=".$b."&e=".$e."&f=".$f."\">По кварталам</a>";
         echo "</div class=\"but1\">\n";
         echo "<div class=\"but2\">";
         echo "<a class=\"btn btn-primary\" href=\"/parse/vkvartale.php?b=".$b."&e=".$e."&f=".$f."\">В квартале</a>";
         echo "</div class=\"but2\">\n";
         echo "<div class=\"but3\">";
         echo "<a class=\"btn btn-success\" href=\"/parse/sobytiya.php?b=".$b."&e=".$e."&f=".$f."\">События</a>";
         echo "</div class=\"but3\">\n";

         if ($f==0){
          $st="btn";
          $query = "SELECT  `kv` ,`begin`,`end`, COUNT( * ) AS  `c`
          FROM  `drop`
          where `begin` between \"".$b."\"and\"".$e."\"
          GROUP BY  `kv`,
          UNIX_TIMESTAMP(begin)div(10*60),
          UNIX_TIMESTAMP(`end`)div(10*60)
          ORDER BY  `c` DESC;";
         }
         if ($f==1){
           $st="btn btn-success";
           $query = "SELECT  `kv` ,`begin`,`end`, COUNT( * ) AS  `c`
           FROM  `drop`
           where `begin` between \"".$b."\"and\"".$e."\" and
           UNIX_TIMESTAMP(end)-UNIX_TIMESTAMP(begin)>(10*60)
           GROUP BY  `kv`,
           UNIX_TIMESTAMP(begin)div(10*60),
           UNIX_TIMESTAMP(`end`)div(10*60)
           ORDER BY  `c` DESC;";
         }
         echo "<div class=\"but10m\">";
         echo "<a class=\"".$st."  \"href=\"/parse/sobytiya.php?b=".$b."&e=".$e."&f=".$fn."\">>10 Мин</a>";
         echo "</div class=\"but10m\">\n";

                 echo "</div>\n";
                 echo "<div class=\"table1\">\n";
               #echo $rub;#"ruby.rb 2016-03-08 15:10:00 2016-03-09 15:10:00"
               #echo "script complete!";
               $dbh = mysql_connect($host, $user, $pswd) or die("Не могу соединиться с MySQL.");
               mysql_select_db($database) or die("Не могу подключиться к базе.");

               $res = mysql_query($query);
               echo "<table class=\"table table-bordered table-hover .table-striped \" >\n";
                echo "<caption>"."Группы событий"."</caption>\n";
                echo "<thead>\n";
                echo "<tr>\n";
                echo "<th>"."#"."</th>\n";
                echo "<th>"."Квартал"."</th>\n";
                echo "<th>"."Начало"."</th>\n";
                echo "<th>"."Конец"."</th>\n";
                echo "<th>"."Количество тригеров"."</th>\n";

                echo "</tr>\n";
                echo "</thead>\n";
                echo "<tbody>\n";
                $i=0;

               while($row = mysql_fetch_array($res))
               { if ($i<=9){
                 echo "<tr class=\"error\">\n";
                 $i++;
                 echo "<td>".$i."</td>\n";
                 echo "<td>".$row['kv']."</td>\n";
                 echo "<td>".$row['begin']."</td>\n";
                 echo "<td>".$row['end']."</td>\n";
                 echo "<td>".$row['c']."</td>\n";

                 echo "</tr>\n";
               } else{
                 echo "<tr>\n";
                 $i++;
                 echo "<td>".$i."</td>\n";
                 echo "<td>".$row['kv']."</td>\n";
                 echo "<td>".$row['begin']."</td>\n";
                 echo "<td>".$row['end']."</td>\n";
                 echo "<td>".$row['c']."</td>\n";

                 echo "</tr>\n";
               }
               }
               echo "</tbody>\n";
               echo "</table>\n";
               echo "</div class=\"table1\">";
               mysql_close($dbh);


       ?>


    </body>
</html>

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
     top:  30px; /* Положение от верхнего края */
     left:  100px; /* Положение от левого края */
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
    left:  10px; /* Положение от левого края */
    line-height: 1px;
   }
   .but10m{
     position: absolute; /* Абсолютное позиционирование */
     top:  103px; /* Положение от верхнего края */
     left:  10px; /* Положение от левого края */
     line-height: 1px;}




  </style>
    </head>
    <body>

        <!-- Содержание страницы -->
        <div class="header"></div>
        <div class="form1">
        <form  method="POST" class="form-search" >
         <div class="end1">
           <p><b>Квартал:</b></p>
           <Br>

             <input class="input-medium search-query" type="text" name="kv" size="10" maxlength="3" class='end2' value="" style="width: 60;height:30" >
         </div>
         <div class="submit1">
           <input class="btn btn-inverse" type="submit" name="pars" value="ок">
         </div>
         </form>


       <?php
       $b=$_GET["b"];
       $e=$_GET["e"];
       $f=$_GET["f"];
       $fn=($f+1)%2;
       $host='localhost'; // имя хоста (уточняется у провайдера)
       $database='sspo'; // имя базы данных, которую вы должны создать
       $user='root'; // заданное вами имя пользователя, либо определенное провайдером
       $pswd=''; // заданный вами пароль
           # Если кнопка нажата
           echo "<div class=\"butnew\">";
           echo "<a class=\"btn btn-primary\"href=\"/parse/\">Новый запрос</a>";
           echo "</div class=\"but1\">\n";
             echo "<div class=\"but1\">";
             echo "<a class=\"btn btn-primary\"href=\"/parse/kvartaly.php?b=".$b."&e=".$e."&f=".$f."\">По кварталам</a>";
             echo "</div class=\"but1\">\n";
             echo "<div class=\"but2\">";
             echo "<a class=\"btn btn-success\" href=\"/parse/vkvartale.php?b=".$b."&e=".$e."&f=".$f."\">В квартале</a>";
             echo "</div class=\"but2\">\n";
             echo "<div class=\"but3\">";
             echo "<a class=\"btn btn-primary\" href=\"/parse/sobytiya.php?b=".$b."&e=".$e."&f=".$f."\">События</a>";
             echo "</div class=\"but3\">\n";

             if ($f==0){
              $st="btn";
              $query = "SELECT  `ip` , COUNT( * ) AS  'c' FROM  `drop` WHERE kv =".$_POST['kv']." AND `begin` BETWEEN  \"".$b."\" AND  \"".$e."\" GROUP BY  `ip` ORDER BY  `c` DESC;";
             }
             if ($f==1){
               $st="btn btn-success";
               $query = "SELECT  `ip` , COUNT( * ) AS  'c' FROM  `drop` WHERE kv =".$_POST['kv']." AND `begin` BETWEEN  \"".$b."\" AND  \"".$e."\"and UNIX_TIMESTAMP(end)-UNIX_TIMESTAMP(begin)>(10*60) GROUP BY  `ip` ORDER BY  `c` DESC;";
             }
             echo "<div class=\"but10m\">";
             echo "<a class=\"".$st."  \"href=\"/parse/vkvartale.php?b=".$b."&e=".$e."&f=".$fn."\">>10 Мин</a>";
             echo "</div class=\"but10m\">\n";


           echo "</div>\n";
           echo "<div class=\"table1\">\n";
           if( isset( $_POST['pars'] ) )
           {


               #echo $rub;#"ruby.rb 2016-03-08 15:10:00 2016-03-09 15:10:00"
               #echo "script complete!";
               $dbh = mysql_connect($host, $user, $pswd) or die("Не могу соединиться с MySQL.");
               mysql_select_db($database) or die("Не могу подключиться к базе.");

               $res = mysql_query($query);
               echo "<table class=\"table table-bordered table-hover\" >\n";
                echo "<caption>"."<h5>Проблемные коммутаторы в квартале<h5> <h4>#".$_POST['kv']." c ".$b." по ".$e."</h4></caption>\n";
                echo "<thead>\n";
                echo "<tr>\n";
                echo "<th>"."#"."</th>\n";
                echo "<th>"."IP"."</th>\n";
                echo "<th>"."Кол-во событий"."</th>\n";
                echo "</tr>\n";
                echo "</thead>\n";
                echo "<tbody>\n";
                $i=0;

               while($row = mysql_fetch_array($res))
               if($i<10)
               { echo "<tr class=\"error\">\n";
                  $i++;
                 echo "<td>".$i."</td>\n";
                 echo "<td>".$row['ip']."</td>\n";
                 echo "<td>".$row['c']."</td>\n";
                 echo "</tr>\n";
               }
               else
               { echo "<tr>\n";
                  $i++;
                 echo "<td>".$i."</td>\n";
                 echo "<td>".$row['ip']."</td>\n";
                 echo "<td>".$row['c']."</td>\n";
                 echo "</tr>\n";
               }
               echo "</tbody>\n";
               echo "</table>\n";
               echo "</div class=\"table1\">";
               mysql_close($dbh);



           }
       ?>


    </body>
</html>

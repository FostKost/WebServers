<html>
    <head>

      <script type="text/javascript">//Функция нажатия на кнопку "создать Vlan"
                function logpas() {
                  var user=document.getElementById("user").value;
                  var password=document.getElementById("password").value;
                }
                function cre_wi() {
                  var user=document.getElementById("user").value;
                  var password=document.getElementById("password").value;
                  var vlan=document.getElementById("vlan").value;
                  var wi=document.getElementById("wi").value;
                  var port=document.getElementById("port").value;
                  var url=window.location.href.replace(window.location.search,'')+'?type=create&vlan='+vlan+'&wi='+wi+'&port='+port+'&u='+user+'&p='+password;
                  window.location.href = url
                }
                function dell(){
                  var user=document.getElementById("user").value;
                  var password=document.getElementById("password").value;
                  var vlan=document.getElementById("vlan").value;
                  var wi=document.getElementById("wi").value;
                  var port=document.getElementById("port").value;
                  var url=window.location.href.replace(window.location.search,'')+'?type=delete&vlan='+vlan+'&wi='+wi+'&port='+port+'&u='+user+'&p='+password;
                  window.location.href = url
                }

                function sleep (m) {var then = new Date(new Date().getTime() + m); while (new Date() < then) {}}

             </script>


      <meta charset="utf-8">
      <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
      <style>




     .header{
       width: 100%;
       height: 8%;
       margin: 0 auto;
       overflow: auto;
       position: absolute;
       font-family:Courier New;
       text-align: center;
       top: 0; left: 0; bottom: 0; right: 0;
       background-color: #000000;
       color:#FFFFFF;
       }

       .forml_left{
         width: 40%;
         height: 73%;
         margin: 0 auto;
         overflow: auto;
         position: absolute;
         font-family:Courier New;
         text-align: center;
         top: 24%; left: 100; bottom: 500; right: 51%;
         font-family:Courier New;

         border: 4px solid #000000;
         border-radius: 50px;

         }
         .forml_right{
           width: 40%;
           height: 73%;
           margin: 0 auto;
           overflow: auto;
           position: absolute;
           font-family:Courier New;
           text-align: center;
           top: 24%; left: 51%; bottom: 500; right: 100;
           font-family:Courier New;

           border: 4px solid #000000;
           border-radius: 50px;

           }
           .forml_up{
             width: 60%;
             height: 13%;
             margin: 0 auto;
             overflow: auto;
             position: absolute;
             font-family:Courier New;
             text-align: center;
             top: 9%; left: 0; bottom: 500; right: 0;
             font-family:Courier New;

             border: 4px solid #000000;
             border-radius: 50px;

             }








  </style>




    </head>
    <body>

        <!-- Содержание страницы -->
        <h3 class="header">Манипуляции с WI договорами. </h3>
        <form>
          <div class="forml_up">
            <h1>Авторизация</h1>
            <h4>
              Login:
              <input type="text" id="user"  class="input-medium search-query" name="login" value="">
              Password:
              <input type="password" id="password"  class="input-medium search-query" name="password" value="">
            </h4>

            </div>
        <form>

          <form>
            <div class="forml_left">
              <h1>Параметры</h1>
              <hr color="000000" size="3" >
              <br>
              <h4>
                # Vlan для сервиса:
                <input type="text" id="vlan" maxlength="4" style="width: 65px;" class="input-medium search-query" name="vlan" value=""><br><br>
              </h4>
              <h4>
                # WI договора:
                <input type="text" id="wi" maxlength="10"  class="input-medium search-query" name="vlan" value=""><br><br>
              </h4>
              <h4>
                # Квартала подключения:
                <input type="text" id="port" maxlength="3"  style="width: 65px;"  class="input-medium search-query" name="vlan" value=""><br><br>
              </h4>
              <p>
                на данный момент, вместо #квартала необходимо указать  номер цк:
                <br>
                ЦК Мира 2/1         => 35;
                <br>
                ЦК Победы 24        => 36;
                <br>
                ЦК Брестская 24/1   => 37;
                <br>
                ЦК Чкалова 21       => 38;


              </p>
            </div>
          </form>

          <form>
            <div class="forml_right">
              <h1>Скрипты</h1>
              <hr color="000000" size="3" >
              <br>
              <br>
              <input type="button" class="btn btn-inverse" onclick="cre_wi()"   name="create_vlan" value="Создать WI договор" >
              <br>
              <br>
              <input type="button" class="btn btn-inverse" onclick="dell()"  name="delete_vlan" value="Удалить WI договор ">



              </div>
          <form>



       <?php
       if (isset($_GET['type']))
{
    if ($_GET['type']=="create")//скрипт на создание вланы
    {
      $cmd="start C:/WebServers/home/localhost/www/scripts/ruby/wi/create_wi.rb ".$_GET['vlan']." ".$_GET['port']." ".$_GET['wi']." ".$_GET['u']." ".$_GET['p'];
      echo $cmd;
      echo "<script language='javascript'>\n";
      echo "alert('Скрипт выполнится в течении 12 секунд')\n";
      echo "</script>\n";
      exec ( $cmd );
      echo "<script language='javascript'>\n";
      echo "setTimeout(\"alert('Vlan создана!!!')\",12000)\n";
      echo "</script>\n";
    }

    if ($_GET['type']=="delete")//скрипт на удаление вланы
    {
      $cmd="start C:/WebServers/home/localhost/www/scripts/ruby/wi/delete_wi ".$_GET['vlan']." ".$_GET['port']." ".$_GET['wi']." ".$_GET['u']." ".$_GET['p'];
      echo "<script language='javascript'>\n";
      echo "alert('Скрипт выполнится в течении 10 секунд')\n";
      echo "</script>\n";
      exec ( $cmd );
      echo "<script language='javascript'>\n";
      echo "setTimeout(\"alert('Vlan удалена!!!')\",9000)\n";
      echo "</script>\n";

    }




}

else
{
  echo "<script language='javascript'>\n";
  echo "alert('тестовая версия c авторизацией')";
  echo "</script>\n";
}


echo "</script>\n";
echo "<script language='javascript'>\n";
  echo "document.getElementById('user').value=\"".$_GET['u']."\";\n";
  echo "document.getElementById('password').value=\"".$_GET['p']."\";\n";
  echo "document.getElementById('vlan').value=\"".$_GET['vlan']."\";\n";
  echo "document.getElementById('port').value=\"".$_GET['port']."\";\n";
  echo "document.getElementById('wi').value=\"".$_GET['wi']."\";\n";
echo "</script>\n";

       ?>


    </body>
</html>

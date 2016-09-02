<html>
    <head>

      <script type="text/javascript">//Функция нажатия на кнопку "создать Vlan"
                function cre() {
                  var vlan=document.getElementById("vlan").value;
                  var url=window.location.href.replace(window.location.search,'')+'?type=create&vlan='+vlan;
                  window.location.href = url
                }
                function del() {
                  var vlan=document.getElementById("vlan").value;
                  var url=window.location.href.replace(window.location.search,'')+'?type=delete&vlan='+vlan;
                  window.location.href = url
                }
                function add() {
                  var vlan=document.getElementById("vlan").value;
                  var port=document.getElementById("port").value;
                  var url=window.location.href.replace(window.location.search,'')+'?type=add_on_port&vlan='+vlan+'&port='+port;
                  window.location.href = url
                }
                function del_from() {
                  var vlan=document.getElementById("vlan").value;
                  var port=document.getElementById("port").value;
                  var url=window.location.href.replace(window.location.search,'')+'?type=delete_on_port&vlan='+vlan+'&port='+port;
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
         height: 76%;
         margin: 0 auto;
         overflow: auto;
         position: absolute;
         font-family:Courier New;
         text-align: center;
         top: 21%; left: 100; bottom: 500; right: 50%;
         font-family:Courier New;

         border: 4px solid #000000;
         border-radius: 50px;

         }
         .forml_right{
           width: 40%;
           height: 76%;
           margin: 0 auto;
           overflow: auto;
           position: absolute;
           font-family:Courier New;
           text-align: center;
           top: 21%; left: 50%; bottom: 500; right: 100;
           font-family:Courier New;

           border: 4px solid #000000;
           border-radius: 50px;

           }
           .forml_up{
             width: 60%;
             height: 10%;
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
        <h3 class="header">Исполнение скриптов на eogs1 и eogs2 </h3>
        <form>
          <div class="forml_up">
            <h1>Авторизация</h1>
            <h4>
              Login:
              <input type="text"   class="input-medium search-query" name="login" value="">
              Password:
              <input type="password"  class="input-medium search-query" name="password" value="">
            </h4>

            </div>
        <form>

          <form>
            <div class="forml_left">
              <h1>Параметры</h1>
              <hr color="000000" size="3" >
              <br>
              <h4>
                # Vlan:
                <input type="text" id="vlan" maxlength="4" style="width: 65px;" class="input-medium search-query" name="vlan" value=""><br><br>
              </h4>
              <h4>
                # Пората(через запятую):
                <input type="text" id="port"  class="input-medium search-query" name="vlan" value=""><br><br>
              </h4>
            </div>
          </form>

          <form>
            <div class="forml_right">
              <h1>Скрипты</h1>
              <hr color="000000" size="3" >
              <br>
              <br>
              <input type="button" class="btn btn-inverse" onclick="cre()"   name="create_vlan" value="Создать Vlan" >
              <br>
              <br>
              <input type="button" class="btn btn-inverse" onclick="del()"  name="delete_vlan" value="Удалить Vlan ">
              <br>
              <br>
              <input type="button" class="btn btn-inverse" onclick="add()"   name="add_vlan_ports" value=" Добавить tagget vlan на порт " >
              <br>
              <br>
              <input type="button" class="btn btn-inverse" onclick="del_from()" "  name="delete_vlan_ports" value=" Удалить Vlan с порта">
              </div>
          <form>



       <?php
       if (isset($_GET['type']))
{
    if ($_GET['type']=="create")//скрипт на создание вланы
    {
      $cmd="start C:/WebServers/home/localhost/www/skripts/ruby/eogs/create_vlan.rb ".$_GET['vlan'];
      echo $cmd;
      echo "<script language='javascript'>\n";
      echo "alert('Идет создание Vlan...')";
      echo "</script>\n";
      exec ( $cmd );
      echo "<script language='javascript'>\n";
      echo "setTimeout(\"alert('Vlan создана!!!')\",9000)";
      echo "</script>\n";
    }

    if ($_GET['type']=="delete")//скрипт на удаление вланы
    {
      $cmd="start C:/WebServers/home/localhost/www/skripts/ruby/eogs/delete_vlan.rb ".$_GET['vlan'];
      echo "<script language='javascript'>\n";
      echo "alert('Удаление Vlan...')";
      echo "</script>\n";
      exec ( $cmd );
      echo "<script language='javascript'>\n";
      echo "setTimeout(\"alert('Vlan удалена!!!')\",9000)";
      echo "</script>\n";

    }

    if ($_GET['type']=="delete_on_port")//скрипт на удаление вланы с порта
    {
      $cmd="start C:/WebServers/home/localhost/www/skripts/ruby/eogs/delet_vlan_ports.rb ".$_GET['vlan']." ".$_GET['port'];
      echo "<script language='javascript'>\n";
      echo "alert('Удаление Vlan с портов...')";
      echo "</script>\n";
      echo "<script language='javascript'>\n";
      echo "setTimeout(\"alert('Vlan удалена с портов!!!')\",9000)";
      echo "</script>\n";
      exec ( $cmd );
    }

    if ($_GET['type']=="add_on_port")//скрипт на добавление вланы на порт.
    {
      $cmd="start C:/WebServers/home/localhost/www/skripts/ruby/eogs/add_vlan_ports.rb ".$_GET['vlan']." ".$_GET['port'];
      echo "<script language='javascript'>\n";
      echo "alert('Добавление Vlan на порты...')";
      echo "</script>\n";
      exec ( $cmd );
      echo "<script language='javascript'>\n";
      echo "setTimeout(\"alert('Vlan добавлена на порты!!!')\",9000)";
      echo "</script>\n";
    }


}

else
{
  echo "<script language='javascript'>\n";
  echo "alert('тестовая версия без авторизации')";
  echo "</script>\n";
}

       ?>


    </body>
</html>

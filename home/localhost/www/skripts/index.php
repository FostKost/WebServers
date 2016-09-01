<html>
    <head>

      <script type="text/javascript">
                function cre() {
                  alert(document.getElementById("vlan").value);

                }
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
              <input type="button" class="btn btn-inverse"   name="delete_vlan" value="Удалить Vlan ">
              <br>
              <br>
              <input type="button" class="btn btn-inverse"   name="add_vlan_ports" value=" Добавить tagget vlan на порт " >
              <br>
              <br>
              <input type="button" class="btn btn-inverse" "  name="delete_vlan_ports" value=" Удалить Vlan с порта">
              </div>
          <form>



       <?php

       ?>


    </body>
</html>

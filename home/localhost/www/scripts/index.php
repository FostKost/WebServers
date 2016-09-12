<html>
    <head>

      <script type="text/javascript">//Функция нажатия на кнопку "создать Vlan"

                function eogs1() {

                  var url="http://192.168.166.132/scripts/eogs.php";
                  window.location.href = url
                }
                function wi_dog() {

                  var url="http://192.168.166.132/scripts/wi.php";
                  window.location.href = url
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
           height: 80%;
           margin: 0 auto;
           overflow: auto;
           position: absolute;
           font-family:Courier New;
           text-align: center;
           top: 13%; left: 0%; bottom: 500; right: 100;
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
        <h3 class="header">Список скриптов </h3>




          <form>
            <div class="forml_right">
              <h1>Скрипты</h1>
              <hr color="000000" size="3" >
              <br>
              <br>
              <input type="button" class="btn btn-inverse" onclick="eogs1()"   name="eogs" value="Скрипты на eogs1 и  eogs2" >
              <br>
              <br>
              <input type="button" class="btn btn-inverse" onclick="wi_dog()"   name="wi" value="Манипуляции с WI договорами" >
              <br>
              <br>



              </div>
          <form>






    </body>
</html>

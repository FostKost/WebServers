<?php
// Подключаем файл auth.php
include_once ("auth.php");
?>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"

</head>

<?php
// Форма для ввода пароля и логина
print '
<form action="login.php" method="post">
<table>
      <tr>
            <td>Login:</td>
            <td><input type="text" name="login" /></td>
      </tr>
      <tr>
            <td>Password:</td>
            <td><input type="password" name="password" /></td>
      </tr>
      <tr>
            <td></td>
            <td><input type="submit" value="OK" /></td>
      </tr>
</table>
</form>
</html>
';
//echo "<br /><h3>Для авторизации необходимы ваши учетные данные</h3>";
?>

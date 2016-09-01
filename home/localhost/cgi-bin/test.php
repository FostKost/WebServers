<?php
    # Если кнопка нажата
    if( isset( $_POST['nazvanie_knopki'] ) )
    {
        # Тут пишете код, который нужно выполнить.
        # Пример:
        echo 'Кнопка нажата!';
    }
?>
<form method="POST">
    <input type="submit" name="nazvanie_knopki" value="Нажмите" />
</form>

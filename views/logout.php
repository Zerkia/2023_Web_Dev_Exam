<?php
session_start();
session_destroy();
setcookie("PHPSESSID", "", 1);
header('Location: login');
exit();
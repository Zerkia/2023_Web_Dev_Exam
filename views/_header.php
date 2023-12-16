<?php 
ob_start();
session_start(); 

require_once __DIR__.'/../_.php';
?>

<!DOCTYPE html>
<html lang="en" class="dark">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">  
  <link rel="stylesheet" href="app.css">
  <title>
    Food
  </title>
</head>

<body 
class="w-full h-screen text-base text-gray-900 font-roboto font-light bg-gray-200 
dark:bg-zinc-700 dark:text-zinc-300">

<nav class="flex items-center w-full h-16 px-4 md:px-12 lg:px-44 border-b border-b-zinc-500">
  <a href="/" class="text-xl font-bold text-sky-600 mr-56">Food</a>
  
  <div class="md:flex gap-4">
  <?php 
    if (isset($_SESSION['user'])) {
      // User is logged in, display navigation based on user role
      if ($_SESSION['user']['user_role_fk'] === 1) {
          echo '<a href="profile">Profile</a>
                <a href="orders">Your Orders</a>';
      } elseif ($_SESSION['user']['user_role_fk'] === 2) {
          echo '<a href="profile">Profile</a>
                <a href="orders">Order Status</a>';
      } elseif ($_SESSION['user']['user_role_fk'] === 3) {
          echo '<a href="products">Products</a>
                <a href="users">Users</a>
                <a href="orders">Orders</a>';
      }
  }
  ?>
  </div>
  
  <div class="md:flex gap-4 ml-auto">
    <?php
    if (isset($_SESSION['user'])) {
        echo '<a href="Logout">Logout</a>';
    } else {
        echo '<a href="Signup">Signup</a>';
        echo '<a href="Login">Login</a>';
    }
    ?>
  </div>

  <button onclick="toggle_theme()" class="ml-4 border-2 border-zinc-500 rounded-md p-1">
    <svg id="btn_dark_icon" class="hidden w-5 h-5" fill="currentColor" viewBox="0 0 20 20" ><path d="M17.293 13.293A8 8 0 016.707 2.707a8.001 8.001 0 1010.586 10.586z"></path></svg>
    <svg id="btn_light_icon" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" ><path d="M10 2a1 1 0 011 1v1a1 1 0 11-2 0V3a1 1 0 011-1zm4 8a4 4 0 11-8 0 4 4 0 018 0zm-.464 4.95l.707.707a1 1 0 001.414-1.414l-.707-.707a1 1 0 00-1.414 1.414zm2.12-10.607a1 1 0 010 1.414l-.706.707a1 1 0 11-1.414-1.414l.707-.707a1 1 0 011.414 0zM17 11a1 1 0 100-2h-1a1 1 0 100 2h1zm-7 4a1 1 0 011 1v1a1 1 0 11-2 0v-1a1 1 0 011-1zM5.05 6.464A1 1 0 106.465 5.05l-.708-.707a1 1 0 00-1.414 1.414l.707.707zm1.414 8.486l-.707.707a1 1 0 01-1.414-1.414l.707-.707a1 1 0 011.414 1.414zM4 11a1 1 0 100-2H3a1 1 0 000 2h1z" fill-rule="evenodd" clip-rule="evenodd"></path></svg>    
  </button>
</nav>

<?php ob_end_flush(); ?>
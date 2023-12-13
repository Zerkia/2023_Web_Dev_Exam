<?php 
ob_start();
session_start(); ?>

<!DOCTYPE html>
<html lang="en" class="dark">
<!-- <html lang="en" class=""> -->

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


<div id="menu" class="fixed flex top-0 -right-60 h-screen z-10 duration-500">
  <div id="menu_background" onclick="toogle_menu()" class="hidden absolute top-0 right-0 w-screen h-screen"></div>
  <div id="menu" class="absolute flex flex-col top-0 right-0 gap-2 w-60 h-screen p-6 text-lg bg-zinc-800 ">
    <a href="/">Home</a>
    <a href="/">Products</a>
    <a href="/users">Users</a>
    <a href="/orders">Orders</a>
    <a href="/">About us</a>
  </div>
</div>

<nav class="flex items-center w-full h-16 px-4 md:px-12 lg:px-44 border-b border-b-zinc-500">
  <a href="/" class="text-xl font-bold text-sky-600">Food</a>
  
  <div class="md:flex gap-4 mx-auto">
    <a href="users">Products</a>
    <a href="users">Users</a>
    <a href="orders">Orders</a>
    <a href="users">About us</a>
  </div>
  
  <div class="md:flex gap-4">
    <?php
    if (isset($_SESSION['user'])) {
        echo '<a href="Logout">Logout</a>';
    } else {
        echo '<a href="Signup">Signup</a>';
        echo '<a href="Login">Login</a>';
    }
    ?>
  </div>

  <div class="relative ml-auto">
    <button class="flex items-center" onclick="toggle_language()">
      <svg class="w-5 h-5 mr-2 rounded-full" aria-hidden="true" viewBox="0 0 3900 3900"><path fill="#b22234" d="M0 0h7410v3900H0z"/>
        <path d="M0 450h7410m0 600H0m0 600h7410m0 600H0m0 600h7410m0 600H0" stroke="#fff" stroke-width="300"/>
        <path fill="#3c3b6e" d="M0 0h2964v2100H0z"/>
        <g fill="#fff">
          <g id="d">
            <g id="c">
              <g id="e">
                <g id="b">
                  <path id="a" d="M247 90l70.534 217.082-184.66-134.164h228.253L176.466 307.082z"/>
                  <use xlink:href="#a" y="420"/><use xlink:href="#a" y="840"/>
                  <use xlink:href="#a" y="1260"/></g><use xlink:href="#a" y="1680"/>
                </g>
                <use xlink:href="#b" x="247" y="210"/>
              </g>
              <use xlink:href="#c" x="494"/>
            </g>
            <use xlink:href="#d" x="988"/>
            <use xlink:href="#c" x="1976"/>
            <use xlink:href="#e" x="2470"/>
        </g>
      </svg>
      English
    </button>
    <div id="languages" class="hidden absolute flex flex-col gap-2 top-8 p-2 -left-2 bg-zinc-400 dark:bg-zinc-600 rounded-sm">
      <button class="flex items-center">
        <svg class="w-5 h-5 rounded-full mr-2" aria-hidden="true" id="flag-icon-css-de" viewBox="0 0 512 512"><path fill="#ffce00" d="M0 341.3h512V512H0z"/><path d="M0 0h512v170.7H0z"/><path fill="#d00" d="M0 170.7h512v170.6H0z"/></svg>
        Deutsch
      </button>      
      <button class="flex items-center">
        <svg class="w-5 h-5  rounded-full mr-2" aria-hidden="true" id="flag-icon-css-it" viewBox="0 0 512 512"><g fill-rule="evenodd" stroke-width="1pt"><path fill="#fff" d="M0 0h512v512H0z"/><path fill="#009246" d="M0 0h170.7v512H0z"/><path fill="#ce2b37" d="M341.3 0H512v512H341.3z"/></g></svg>              
        Italiano
      </button>      
      <button class="flex items-center">
      <svg class="w-5 h-5 rounded-full mr-2" viewBox="0 0 280 280"><rect width="370" height="280" fill="#c60c30"/><rect width="40" height="280" x="80" fill="#fff"/><rect width="370" height="40" y="120" fill="#fff"/></svg>
        Dansk
      </button>      
      <button class="flex items-center">
      <svg class="w-5 h-5 rounded-full mr-2" viewBox="0 0 512 512">
        <path fill="#AA151B" d="M0 0h512v512H0z"/>
        <path fill="#F1BF00" d="M0 148h512v236H0z"/>
      </svg>        
        Español
      </button>      
    </div>
  </div>

  <button onclick="toggle_theme()" class="ml-4 border-2 border-zinc-500 rounded-md p-1">
    <svg id="btn_dark_icon" class="hidden w-5 h-5" fill="currentColor" viewBox="0 0 20 20" ><path d="M17.293 13.293A8 8 0 016.707 2.707a8.001 8.001 0 1010.586 10.586z"></path></svg>
    <svg id="btn_light_icon" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" ><path d="M10 2a1 1 0 011 1v1a1 1 0 11-2 0V3a1 1 0 011-1zm4 8a4 4 0 11-8 0 4 4 0 018 0zm-.464 4.95l.707.707a1 1 0 001.414-1.414l-.707-.707a1 1 0 00-1.414 1.414zm2.12-10.607a1 1 0 010 1.414l-.706.707a1 1 0 11-1.414-1.414l.707-.707a1 1 0 011.414 0zM17 11a1 1 0 100-2h-1a1 1 0 100 2h1zm-7 4a1 1 0 011 1v1a1 1 0 11-2 0v-1a1 1 0 011-1zM5.05 6.464A1 1 0 106.465 5.05l-.708-.707a1 1 0 00-1.414 1.414l.707.707zm1.414 8.486l-.707.707a1 1 0 01-1.414-1.414l.707-.707a1 1 0 011.414 1.414zM4 11a1 1 0 100-2H3a1 1 0 000 2h1z" fill-rule="evenodd" clip-rule="evenodd"></path></svg>    
  </button>
  <svg onclick="toogle_menu()" class="ml-4 cursor-pointer" width="32" height="32" viewBox="0 0 24 24"><path fill="currentColor" d="M3 18h18v-2H3v2zm0-5h18v-2H3v2zm0-7v2h18V6H3z"/></svg>

</nav>

<?php ob_end_flush(); ?>
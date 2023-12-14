<?php 
ob_start();
require_once __DIR__.'/_header.php';  
require_once __DIR__.'/../_.php';

_is_logged_in();

ob_end_flush();
?>

<main class="w-full min-h-screen mt-16">
  <form onsubmit="validate(login); return false" 
  class="flex flex-col px-4 text-white 
  lg:w-1/3 mx-auto gap-4 [&_input]:border [&_input]:border-black
  [&_input]:h-10 [&_input]:rounded-md [&_input]:outline-none
  [&_input]:text-black">


    <div class="grid">
      <label for="">
        <span class="text-sky-600 font-bold">Email</span>
      </label>    
      <input name="user_email" type="text" 
      data-validate="email">
    </div>

    <div class="grid">
      <label for="" class="flex">
        <span class="text-sky-600 font-bold">Password</span> 
        <span class="ml-auto text-gray-500">(<?= USER_PASSWORD_MIN ?> to <?= USER_PASSWORD_MAX ?> characters)</span>
      </label>    
      <input name="user_password" type="text"
      data-validate="str" data-min="<?= USER_PASSWORD_MIN ?>" data-max="<?= USER_PASSWORD_MAX ?>"
      class="">
    </div>

    <button class="w-full h-10 bg-sky-600 text-white rounded-md">Login</button>

  </form>
</main>

<?php require_once __DIR__.'/_footer.php'  ?>






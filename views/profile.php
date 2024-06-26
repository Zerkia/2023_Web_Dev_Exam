<?php 
ob_start();
require_once __DIR__.'/_header.php';  

if (isset($_SESSION['user']['user_id'])) {
  $user_id = $_SESSION['user']['user_id'];
}

_is_blocked();

ob_end_flush();

?>

<main class="w-full min-h-screen mt-16">
  <div class="flex flex-col px-4 lg:w-1/3 mx-auto gap-4">
    <div>
      <h1 class="text-center text-xl font-bold">🧑 Name</h1>
      <p class="text-center text-lg"><?= _prevent_XSS($_SESSION['user']['user_name']) ?></p>
    </div>

    <div> 
      <h1 class="text-center text-xl font-bold">👪 Last Name</h1> 
      <p class="text-center text-lg"><?= _prevent_XSS($_SESSION['user']['user_last_name']) ?></p>
    </div>

    <div>
      <h1 class="text-center text-xl font-bold">📧 Email</h1>
      <p class="text-center text-lg"><?= _prevent_XSS($_SESSION['user']['user_email']) ?></p>
    </div>

    <div> 
      <h1 class="text-center text-xl font-bold">🏡 Address</h1>
      <p class="text-center text-lg"><?= _prevent_XSS($_SESSION['user']['user_address']) ?></p>
      <p class="text-center text-lg"><?= _prevent_XSS($_SESSION['user']['user_zip_code'] . ' ' . $_SESSION['user']['user_city']) ?></p>
    </div>

    <div class="flex justify-center pt-4">
      <button class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded mr-6" onclick="goToUpdateProfile();">
        Update Profile
      </button>
      <button class="bg-red-500 hover:bg-red-800 text-white font-bold py-2 px-4 rounded" onclick="confirmDeleteProfile(<?= $user_id ?>)">
        Delete Profile
      </button>
    </div>
  </div>
</main>

<?php require_once __DIR__.'/_footer.php'  ?>






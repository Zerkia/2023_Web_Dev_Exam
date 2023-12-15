<?php 
    ob_start();

    require_once __DIR__.'/_header.php';

    $db = _db();
    $q = $db->prepare("CALL user_info(:user_id)");
    $q->bindValue(':user_id', $_GET['user_id']); 
    $q->execute();
    $user = $q->fetch();

    _is_blocked();
    _is_admin();

    if(!$user){
        header('Location: users');
        die();
    }
    
    ob_end_flush();
?>
<main class="w-full min-h-screen mt-16">
  <div class="flex flex-col px-4 lg:w-1/3 mx-auto gap-4">
    <div>
      <h1 class="text-center text-xl font-bold">🆔 User ID</h1>
      <p class="text-center text-lg"><?= $user['user_id'] ?></p>
    </div>

    <div>
      <h1 class="text-center text-xl font-bold">🧑 Name</h1>
      <p class="text-center text-lg"><?= $user['user_name'] ?></p>
    </div>

    <div> 
      <h1 class="text-center text-xl font-bold">👪 Last Name</h1> 
      <p class="text-center text-lg"><?= $user['user_last_name'] ?></p>
    </div>
    
    <div> 
      <h1 class="text-center text-xl font-bold">🖥️ Username</h1> 
      <p class="text-center text-lg"><?= $user['user_username'] ?></p>
    </div>

    <div>
      <h1 class="text-center text-xl font-bold">📧 Email</h1>
      <p class="text-center text-lg"><?= $user['user_email'] ?></p>
    </div>

    <div> 
      <h1 class="text-center text-xl font-bold">🏡 Address</h1>
      <p class="text-center text-lg"><?= $user['user_address'] ?></p>
      <p class="text-center text-lg"><?= $user['user_zip_code'] . ' ' . $user['user_city'] ?></p>
    </div>

    <div>
      <h1 class="text-center text-xl font-bold">🎭 Role</h1>
      <p class="text-center text-lg"><?= $user['user_role'] ?></p>
    </div>
  </div>
</main>

<?php require_once __DIR__.'/_footer.php'  ?>
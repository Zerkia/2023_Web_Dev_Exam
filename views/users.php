<?php 
  ob_start();
  require_once __DIR__.'/_header.php';

  _is_blocked();
  _is_admin();

  $db = _db();
  $sql = $db->prepare('CALL get_all_users()');
  $sql->execute();
  $users = $sql->fetchAll();

  ob_end_flush();
?>

<main class="w-full px-4 md:px-12 lg:px-44">

  <div class="py-4">
    <form action="/search-users" method="GET" class="flex gap-4 items-center w-full">
      <label for="query" class="w-2/12">Search for users</label>
      <input name="query" 
      class="w-8/12 h-8 dark:bg-zinc-400 rounded-sm outline-none" id="query" type="text">
      <button class="w-2/12 h-8 text-black bg-white dark:bg-zinc-400 border dark:border-zinc-400 rounded-sm">Search</button>
    </form>
  </div>

  <div class="flex w-full pt-4 font-bold">
    <p class="w-1/12">ID</p>
    <p class="w-1/5">Name</p>
    <p class="w-1/5">Last Name</p>
    <p class="w-1/5 mr-6"></p>
    <p class="w-2/12 text-center">Status</p>
    <p class="w-1/12 ml-4">Delete</p>
  </div>
  
  <?php foreach($users as $user):?>
    <div class="flex w-full pt-4">
      <div class="w-1/12"><?= _prevent_XSS($user['user_id']) ?></div>
      <div class="w-1/5"><?= _prevent_XSS($user['user_name']) ?></div>
      <div class="w-1/5"><?= _prevent_XSS($user['user_last_name']) ?></div>
      
      <a href="user?user_id=<?= $user['user_id'] ?>" class="w-1/5 text-center">
        👁️
      </a>

      <button class="w-1/5" onclick="toggle_blocked(<?= $user['user_id'] ?>, <?= $user['user_is_blocked'] ?>)">
        <?= $user['user_is_blocked']  === 0 
        ? '<span class="text-emerald-500">Unblocked</span>' 
        : '<span class="text-red-700">Blocked</span>' ?>
      </button>
      
      
      <form onsubmit="delete_user(); return false" method="POST">
        <input class="hidden" name="user_id" type="text" value="<?= $user['user_id'] ?>">
        <button class="w-1/5">
          🗑️
        </button>
      </form>
    </div>
  <?php endforeach?>
</main>

<?php require_once __DIR__.'/_footer.php'  ?>

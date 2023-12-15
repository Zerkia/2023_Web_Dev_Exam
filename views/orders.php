<?php 
  ob_start();
  require_once __DIR__.'/_header.php';

  _is_blocked();

  $db = _db();
  if($_SESSION['user']['user_role_fk'] === 1){
    $sql = $db->prepare('CALL get_all_own_orders(:user_id)');
    $sql->bindValue(':user_id', $_SESSION['user']['user_id']);
  } else {
    $sql = $db->prepare('CALL get_all_orders()');
  }
  $sql->execute();
  $orders = $sql->fetchAll();

  ob_end_flush();
?>

<main class="w-full px-4 md:px-12 lg:px-44">

  <div class="py-4">
    <form action="/search-orders" method="GET" class="flex gap-4 items-center w-full">
      <label for="query" class="w-2/12">Search for orders</label>
      <input name="query" 
      class="w-8/12 h-8 dark:bg-zinc-400 rounded-sm outline-none" id="query" type="text">
      <button class="w-2/12 h-8 text-black bg-white dark:bg-zinc-400 border dark:border-zinc-400 rounded-sm">Search</button>
    </form>
  </div>

  <div class="flex w-full pt-4 font-bold">
    <p class="w-1/12">ID</p>
    <p class="w-1/5">Name</p>
    <p class="w-1/5">Product Name</p>
    <p class="w-1/5"></p>
    <p class="w-2/12">Amount Paid</p>
    <?php if($_SESSION['user']['user_role_fk'] === 3): ?>
      <p class="w-1/12 ml-10">Delete</p>
    <?php endif; ?>
  </div>
  
  <?php foreach($orders as $order):?>
    <div class="flex w-full pt-4">
      <div class="w-1/12"><?= $order['order_id'] ?></div>
      <div class="w-1/5"><?= $order['order_user_name'] ?></div>
      <div class="w-2/5"><?= $order['order_product_name'] ?></div>
      <div class="w-1/5"><?= $order['order_amount_paid'] ?></div>
      
      <?php if($_SESSION['user']['user_role_fk'] === 3): ?>
        <form onsubmit="delete_order(); return false" method="POST">
          <input class="hidden" name="order_id" type="text" value="<?= $order['order_id'] ?>">
          <button class="w-1/5">
            🗑️
          </button>
        </form>
        <?php endif; ?>
      </div>
  <?php endforeach?>
</main>

<?php require_once __DIR__.'/_footer.php'  ?>

<?php 
  ob_start();
  require_once __DIR__.'/_header.php';
  require_once __DIR__.'/../_.php';

  _is_blocked();
  _is_admin();

  $db = _db();
  $sql = $db->prepare('CALL search_by_product_or_category(:query)');
  $sql->bindValue(':query', $_GET['query']);
  $sql->execute();
  $products = $sql->fetchAll();

  ob_end_flush();
?>

<main class="w-full px-4 md:px-12 lg:px-44">

  <div class="py-4">
    <form action="/search-products" method="GET" class="flex gap-4 items-center w-full">
      <label for="query" class="w-2/12">Search for products</label>
      <input name="query" 
      class="w-8/12 h-8 dark:bg-zinc-400 rounded-sm outline-none" id="query" type="text">
      <button class="w-2/12 h-8 text-black bg-white dark:bg-zinc-400 border dark:border-zinc-400 rounded-sm">Search</button>
    </form>
  </div>

  <div class="flex w-full pt-4 font-bold">
    <p class="w-1/12">ID</p>
    <p class="w-1/5">Name</p>
    <p class="w-1/5">Price</p>
    <p class="w-1/5"></p>
    <p class="w-2/12">Category</p>
    <p class="w-1/12 ml-10">Delete</p>
  </div>
  
  <?php foreach($products as $product):?>
    <div class="flex w-full pt-4">
      <div class="w-1/12"><?= $product['product_id'] ?></div>
      <div class="w-1/5"><?= $product['product_name'] ?></div>
      <div class="w-2/5"><?= $product['product_price'] ?></div>
      <div class="w-1/5"><?= $product['product_category'] ?></div>
      
      
      <form onsubmit="delete_product(); return false" method="POST">
        <input class="hidden" name="product_id" type="text" value="<?= $product['product_id'] ?>">
        <button class="w-1/5">
          🗑️
        </button>
      </form>
    </div>
  <?php endforeach?>
</main>

<?php require_once __DIR__.'/_footer.php'  ?>

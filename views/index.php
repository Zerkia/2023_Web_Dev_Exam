<?php 
ob_start();
require_once __DIR__.'/_header.php';

_is_blocked();
ob_end_flush();
?>


<header class="flex flex-col items-center gap-4 w-full py-24 border-b border-b-zinc-500">
  <h1 class="flex justify-center w-full text-7xl font-bold font-sans text-sky-600">
    FØTEX FOOD
  </h1>
  <p class="text-2xl">
    Less is more
  </p>
</header>

<main>

</main>

<?php require_once __DIR__.'/_footer.php'  ?>






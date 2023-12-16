<?php 
ob_start();
require_once __DIR__.'/_header.php';  

$db = _db();
$sql = $db->prepare('CALL user_info(:user_id)');
$sql->bindValue(':user_id', $_SESSION['user']['user_id']);
$sql->execute();
$user = $sql->fetch();

_is_blocked();

ob_end_flush();
?>

<main class="w-full min-h-screen mt-16">
  <form onsubmit="validate(() => update_own_user(<?= $user['user_id'] ?>)); return false" 
  class="flex flex-col px-4
  lg:w-1/3 mx-auto gap-4 [&_input]:text-black [&_input]:px-2 [&_input]:border 
  [&_input]:border-gray-600 [&_input]:h-10 [&_input]:rounded-md [&_input]:outline-none">

    <div class="grid">
      <label for="user_name" class="flex">
        <span class="text-sky-600 font-bold">Name</span> 
        <span class="ml-auto">(<?= USER_NAME_MIN ?> to <?= USER_NAME_MAX ?> characters)</span>
      </label>
      <input id="user_name" name="user_name" type="text"
      data-validate="str" data-min="<?= USER_NAME_MIN ?>" data-max="<?= USER_NAME_MAX ?>"
      value="<?= $user['user_name'] ?>">
    </div>

    <div class="grid">
      <label for="user_last_name" class="flex">
        <span class="text-sky-600 font-bold">Last Name</span>
        <span class="ml-auto">(<?= USER_LAST_NAME_MIN ?> to <?= USER_LAST_NAME_MAX ?> characters)</span>
      </label>    
      <input id="user_last_name" name="user_last_name" type="text"
      data-validate="str" data-min="<?= USER_LAST_NAME_MIN ?>" data-max="<?= USER_LAST_NAME_MAX ?>"
      value="<?= $user['user_last_name'] ?>">
    </div>

    <div class="grid">
      <label for="user_address" class="flex">
        <span class="text-sky-600 font-bold">Address</span> 
        <span class="ml-auto">(<?= USER_ADDRESS_MIN ?> to <?= USER_ADDRESS_MAX ?> characters)</span>
      </label>
      <input id="user_address" name="user_address" type="text"
      data-validate="str" data-min="<?= USER_ADDRESS_MIN ?>" data-max="<?= USER_ADDRESS_MAX ?>"
      value="<?= $user['user_address'] ?>">
    </div>

    <div class="grid">
      <label for="user_zip_code" class="flex">
        <span class="text-sky-600 font-bold">Zip Code</span> 
        <span class="ml-auto">(<?= USER_ZIP_CODE_MIN ?> to <?= USER_ZIP_CODE_MAX ?> characters)</span>
      </label>
      <input id="user_zip_code" name="user_zip_code" type="text"
      data-validate="str" data-min="<?= USER_ZIP_CODE_MIN ?>" data-max="<?= USER_ZIP_CODE_MAX ?>"
      value="<?= $user['user_zip_code'] ?>">
    </div>

    <div class="grid">
      <label for="user_city" class="flex">
        <span class="text-sky-600 font-bold">City</span> 
        <span class="ml-auto">(<?= USER_CITY_MIN ?> to <?= USER_CITY_MAX ?> characters)</span>
      </label>
      <input id="user_city" name="user_city" type="text"
      data-validate="str" data-min="<?= USER_CITY_MIN ?>" data-max="<?= USER_CITY_MAX ?>"
      value="<?= $user['user_city'] ?>">
    </div>

    <button class="w-full h-10 bg-sky-600 text-white rounded-md">Update</button>

  </form>
</main>

<?php require_once __DIR__.'/_footer.php'  ?>
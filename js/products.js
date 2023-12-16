async function delete_product(){
  const form = event.target;

  const conn = await fetch("api/api-admin-delete-product.php", {
    method: 'POST',
    body: new FormData(form)
  });

  await conn.json();

  form.parentElement.remove();
}
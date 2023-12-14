async function delete_product(){
  const form = event.target;

  const conn = await fetch("api/api-admin-delete-product.php", {
    method: 'POST',
    body: new FormData(form)
  });

  const response = await conn.json();
  console.log(response);

  form.parentElement.remove();
}
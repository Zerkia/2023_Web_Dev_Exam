async function delete_order(){
  const form = event.target;

  const conn = await fetch("api/api-admin-delete-order.php", {
    method: 'POST',
    body: new FormData(form)
  });

  await conn.json();

  form.parentElement.remove();
}
async function toggle_blocked(user_id, user_is_blocked) {

  if(event.target.textContent === 'Unblocked'){
    event.target.classList.remove("text-emerald-500");
    event.target.textContent = "Blocked";
    event.target.classList.add("text-red-700");
  } else {
    event.target.classList.remove("text-red-700");
    event.target.textContent = "Unblocked";
    event.target.classList.add("text-emerald-500");
  }

  await fetch(`api/api-toggle-user-blocked.php?user_id=${user_id}&user_is_blocked=${user_is_blocked}`);
}

async function signup() {
  const frm = event.target;
  console.log(frm);
  const conn = await fetch("/api/api-signup.php", {
    method: "POST",
    body: new FormData(frm),
  });

  const data = await conn.text();
  console.log(data);

  if (!conn.ok) {
    Swal.fire({
      icon: "error",
      title: "Oops...",
      text: "Something went wrong!",
      footer: '<a href="">Why do I have this issue?</a>',
    });
    return;
  }

  location.href = "/login";
}

async function login() {
  const frm = event.target;
  console.log(frm);
  const conn = await fetch("/api/api-login.php", {
    method: "POST",
    body: new FormData(frm),
  });

  const data = await conn.text();
  console.log(data);

  if (!conn.ok) {
    Swal.fire({
      icon: "error",
      title: "Oops...",
      text: "Something went wrong!",
      footer: '<a href="">Why do I have this issue?</a>',
    });
    return;
  }

  location.href = "/";
}

async function is_username_available(){
  const form = event.target.form;
  console.log(form);

  const conn = await fetch("api/api-is-username-available.php", {
    method: 'POST',
    body: new FormData(form)
  });
  if(!conn.ok){
    console.log("username is already in use");
    document.querySelector('#msg_username_not_available').classList.remove("hidden");
    return;
  }
    console.log("username is available")
}

async function is_email_available(){
  const form = event.target.form;
  console.log(form);

  const conn = await fetch("api/api-is-email-available.php", {
    method: 'POST',
    body: new FormData(form)
  });
  if(!conn.ok){
    console.log("Email is already in use");
    document.querySelector('#msg_email_not_available').classList.remove("hidden");
    return;
  }
    console.log("Email is available")
}

async function goToUpdateProfile(){
  window.location.href = "update";
}

async function delete_user(){
  const form = event.target;

  const conn = await fetch("api/api-admin-delete-user.php", {
    method: 'POST',
    body: new FormData(form)
  });

  const response = await conn.json();
  console.log(response);

  form.parentElement.remove();
}

async function confirmDeleteProfile(user_id) {
  var isConfirmed = window.confirm("Are you sure you want to delete your profile?");

  if (isConfirmed) {
    await delete_own_user(user_id);
    window.location.href = "logout";
  }
}

async function delete_own_user(user_id) {
  try {
    const response = await fetch("api/api-delete-own-user.php", {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ user_id: user_id }),
    });

    if (!response.ok) {
      throw new Error(`Failed to delete user. Status: ${response.status}`);
    }

    await response.json();

  } catch (error) {
    console.error("Error deleting user:", error);
  }
}





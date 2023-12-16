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
  const conn = await fetch("/api/api-signup.php", {
    method: "POST",
    body: new FormData(frm),
  });

  await conn.text();

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
  const conn = await fetch("/api/api-login.php", {
    method: "POST",
    body: new FormData(frm),
  });

  await conn.text();

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

  const conn = await fetch("api/api-is-username-available.php", {
    method: 'POST',
    body: new FormData(form)
  });
  if(!conn.ok){
    document.querySelector('#msg_username_not_available').classList.remove("hidden");
    return;
  }
}

async function is_email_available(){
  const form = event.target.form;

  const conn = await fetch("api/api-is-email-available.php", {
    method: 'POST',
    body: new FormData(form)
  });
  if(!conn.ok){
    document.querySelector('#msg_email_not_available').classList.remove("hidden");
    return;
  }
}

async function goToUpdateProfile(){
  window.location.href = "updateProfile";
}

async function update_own_user(user_id) {
  const frm = event.target;
  const formData = new FormData(frm);
  formData.append('user_id', user_id);

  const conn = await fetch("/api/api-update-own-user.php", {
    method: "POST",
    body: formData,
  });

  await conn.text();

  if (!conn.ok) {
    Swal.fire({
      icon: "error",
      title: "Oops...",
      text: "Something went wrong!",
      footer: '<a href="">Why do I have this issue?</a>',
    });
    return;
  }

  location.href = "profile";
}

async function delete_user(){
  const form = event.target;

  const conn = await fetch("api/api-admin-delete-user.php", {
    method: 'POST',
    body: new FormData(form)
  });

  await conn.json();

  form.parentElement.remove();
}

async function confirmDeleteProfile(user_id) {
  var isConfirmed = window.confirm("Are you sure you want to delete your profile?");

  if (isConfirmed) {
    await delete_own_user(user_id);
    // window.location.href = "logout";
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





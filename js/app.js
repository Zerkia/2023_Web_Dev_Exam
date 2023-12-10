// const system_theme = window.matchMedia("(prefers-color-scheme: dark)");
// console.log(system_theme.theme)
// if (system_theme.matches) {
//   // Theme set to dark.
//   document.documentElement.classList.remove('dark')
// } else {
//   // Theme set to light.
//   document.documentElement.classList.add('dark')
// }

function toggle_theme() {
  if (document.querySelector("html").classList.contains("dark")) {
    document.querySelector("html").classList.remove("dark");
    document.querySelector("#btn_dark_icon").classList.remove("hidden");
    document.querySelector("#btn_light_icon").classList.add("hidden");
    return;
  }
  document.querySelector("html").classList.add("dark");
  document.querySelector("#btn_dark_icon").classList.add("hidden");
  document.querySelector("#btn_light_icon").classList.remove("hidden");
}

function toogle_menu() {
  if (document.querySelector("#menu").classList.contains("left-0")) {
    document.querySelector("#menu").classList.add("-left-60");
    document.querySelector("#menu").classList.remove("left-0");
    document.querySelector("#menu").classList.remove("left-0");
    document.querySelector("#menu_background").classList.add("hidden");
    return;
  }
  document.querySelector("#menu").classList.remove("-left-60");
  document.querySelector("#menu").classList.add("left-0");
  document.querySelector("#menu_background").classList.remove("hidden");
}

function toggle_language() {
  if (document.querySelector("#languages").classList.contains("hidden")) {
    document.querySelector("#languages").classList.remove("hidden");
    return;
  }
  document.querySelector("#languages").classList.add("hidden");
}

async function toggle_blocked(user_id, user_is_blocked) {
  
  if(user_is_blocked === 0){
    event.target.classList.remove("text-emerald-500");
    event.target.innerHTML = "blocked";
    event.target.classList.add("text-red-700");
  } else {
    event.target.classList.remove("text-red-700");
    event.target.innerHTML = "unblocked";
    event.target.classList.add("text-emerald-500");
  }

  const conn = await fetch(`api/api-toggle-user-blocked.php?user_id=${user_id}&user_is_blocked=${user_is_blocked}`);
  const data = await conn.text();
  console.log(data);
  
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

  // TODO: redirect to the login page
  location.href = "/login";
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

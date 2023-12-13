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
  if (document.querySelector("#menu").classList.contains("right-0")) {
    document.querySelector("#menu").classList.add("-right-60");
    document.querySelector("#menu").classList.remove("right-0");
    document.querySelector("#menu").classList.remove("right-0");
    document.querySelector("#menu_background").classList.add("hidden");
    return;
  }
  document.querySelector("#menu").classList.remove("-right-60");
  document.querySelector("#menu").classList.add("right-0");
  document.querySelector("#menu_background").classList.remove("hidden");
}

function toggle_language() {
  if (document.querySelector("#languages").classList.contains("hidden")) {
    document.querySelector("#languages").classList.remove("hidden");
    return;
  }
  document.querySelector("#languages").classList.add("hidden");
}

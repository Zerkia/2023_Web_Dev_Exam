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

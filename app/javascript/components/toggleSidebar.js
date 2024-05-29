const toggle = () => {
  const sidebar = document.getElementById("sidebar");
  const arrow = document.getElementById("sideArrow");

  if (sidebar) {
    arrow.addEventListener("click", (event) => {
      event.preventDefault();
      sidebar.classList.toggle("collapsed");
    })
  }
}

export { toggle }

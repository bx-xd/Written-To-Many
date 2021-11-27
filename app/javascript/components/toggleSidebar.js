const toggle = () => {
  const arrow = document.getElementById("sideArrow");
  const sidebar = document.getElementById("sidebar");

  arrow.addEventListener("click", (event) => {
    event.preventDefault();

    sidebar.classList.toggle("small")
  })
}

export { toggle }

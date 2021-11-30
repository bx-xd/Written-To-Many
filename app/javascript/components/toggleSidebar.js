const toggle = () => {
  const sidebar = document.getElementById("sidebar");
  const arrow = document.getElementById("sideArrow");
  const projectTitle = document.getElementById('project_title');
  const listTitles = document.getElementById('list_titles');

  if (sidebar) {
    arrow.addEventListener("click", (event) => {
      event.preventDefault();
      console.log(event)
      //sidebar.style.transfrom = 'translateX(-200px)'
      sidebar.classList.toggle("collapsed");
      // sidebar.addEventListener('transitionend', () => {
      //   projectTitle.style.opacity = 0;
      //   listTitles.style.opacity = 1;
      // });
    })
  }
}

export { toggle }

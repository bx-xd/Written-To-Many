const header = () => {
  const txtEditor = document.querySelector("#editorjs");

  if (txtEditor) {
    const headersSidebar = document.querySelector("#list_titles");
    const h1sText = txtEditor.getElementsByTagName("h1");

    // Permet d'afficher les titres H1 dans la sidebar
    const loadTitle = () => {
      console.log(h1sText)
      Array.from(h1sText).forEach((h1, index) => {
        h1.id = `header-${index}`;

        const btn = document.createElement("button")
        btn.setAttribute("id", `btn-${index}`)
        btn.classList.add("boutonSide")
        btn.innerText = h1.innerText

        headersSidebar.appendChild(btn);

        btn.addEventListener("click", (event) => {
          const header = document.getElementById(`header-${index}`)
          header.scrollIntoView({
            behavior: 'smooth'
          })
        })
      });
    }
    loadTitle()
  }
};

export { header }

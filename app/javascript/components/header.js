const header = () => {
  const txtEditor = document.querySelector("#editorjs");

  if (txtEditor) {
    const headersSidebar = document.querySelector("#list_titles");
    const h1sText = txtEditor.getElementsByTagName("h1");

    // Permet d'afficher les titres H1 dans la sidebar
    const loadTitle = () => {

      Array.from(h1sText).forEach((h1, index) => {

        headersSidebar.insertAdjacentHTML("beforeend",
        `<button class="boutonSide">
        ${h1.innerText}
        </button>`);

        const buttonsInside = document.getElementsByClassName("boutonSide")
        scrollBtn(buttonsInside, h1)
      });
    }

    const scrollBtn = (buttons, header) => {
      if (buttons) {
        Array.from(buttons).forEach((button) => {
          button.addEventListener("click", (event) => {
            event.preventDefault();

            const h1Position = Math.round(header.getBoundingClientRect()["y"]);

            window.scrollTo({
              top: h1Position,
              left: 0,
              behavior: 'smooth'
            });
          })
        })
      }
    }


    // Permet de charger tous les titres dès que la souris passe sur la page
    document.addEventListener('mousemove', (event) => {
      event.preventDefault();

      headersSidebar.innerHTML = "";

      loadTitle();
    });
  }
};

export { header }

const header = () => {
  const txtEditor = document.querySelector("#editorjs");
  const headersSidebars = document.querySelector("#list_titles");

  if (txtEditor) {
    // Permet d'afficher les titres H1 dans la sidebar
    const loadTitle = () => {
      const h1sText = txtEditor.getElementsByTagName("h1");

      Array.from(h1sText).forEach((h1, index) => {
        const generatedID = `h1-${index}`;
        h1.setAttribute("id", generatedID);

        headersSidebars.insertAdjacentHTML("beforeend",
          `<a href="#${generatedID}" class="boutonSide" data-toggle="collapse" data-target="#partie1Collapse"
          aria-expanded="false" aria-controls="partie1Collapse">
          ${h1.innerText}
          </a>`);
      });
    }

    // Permet de charger tous les titres dès que la souris passe sur la page
    document.addEventListener('mousemove', (event) => {
      event.preventDefault();

      headersSidebars.innerHTML = "";

      loadTitle();
    });
  }
};

export { header }

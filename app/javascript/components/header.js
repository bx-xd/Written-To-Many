const header = () => {
  const txtEditor = document.querySelector("#editorjs");

  if (txtEditor) {
    const headersSidebars = document.querySelector("#list_titles");
    const h1sText = txtEditor.getElementsByTagName("h1");
    // Permet d'afficher les titres H1 dans la sidebar
    const loadTitle = () => {

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

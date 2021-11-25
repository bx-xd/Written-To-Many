const dashboard_tabs = () => {

  // ciblage des parties à afficher
  const divContent = document.querySelectorAll(".content");

  // ciblage des tabs de navigation de classe 'active'
  const tabs = document.querySelectorAll(".tab-underlined");

  tabs.forEach((tab) => {
    tab.addEventListener("click", (event) => {
      event.preventDefault();

      // Définition de la constante qui récupère la div cilbée par le <a data-content-active="">
      const dataContentActive = event.currentTarget.dataset.contentActive;
      // On récupère la div qui a la classe 'content' ET 'active'
      const activeDiv = document.getElementById(dataContentActive);

      // On enlève tous la classe 'active' de chaque élément
      tabs.forEach((tab) => {
        tab.classList.remove("active");
      });
      // On ajoute class='active' au <a> qui a connu un CLICK sur l'addEventListener
      event.currentTarget.classList.add("active");

      // Même dynamique pour la div rattachée au <a> qui a connu le click et qui cible la bonne div
      divContent.forEach((div) => {
        div.classList.remove("active");
      })
      activeDiv.classList.add("active");
    });
  });
}

export { dashboard_tabs }

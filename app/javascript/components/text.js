const textShow = () => {
  const trixEditor = document.querySelector("trix-editor");
  const formNewModif = document.querySelector("#input-modif");

  trixEditor.addEventListener("click", (event) => {
    const clickY = event.clientY;

    formNewModif.classList.remove('d-none')
  })
}

export { textShow }

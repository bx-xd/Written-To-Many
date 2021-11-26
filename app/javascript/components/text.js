const textShow = () => {
  // const trixEditor = document.querySelector("trix-editor");
  // const formNewModif = document.querySelector("#input-modif");

  // trixEditor.addEventListener("click", (event) => {
  //   const clickY = event.clientY;

  //   formNewModif.classList.remove('d-none')
  // })

  const input = document.querySelector("trix-editor")
  const addBtn = document.getElementById("add-modif")

  const textForm = document.querySelector(".edit_text")

  const modifContainer = document.getElementById("modif-container")
  const uuid = modifContainer.dataset.id


  const editor = input.editor

  document.addEventListener("trix-initialize", (event) => {
    console.log("Init done")

    const modifData = JSON.parse(document.querySelector("#modif-data").dataset.json)

    modifData.forEach((data) => {
      console.log(data)
      let uuid = data.uuid
      let a = document.querySelector(`a[href='#${uuid}']`)
      if (a !== null) {
        a.innerHTML = data.content_after.body
      }
    })
  })


  input.addEventListener("trix-change", (event) => {
    addBtn.classList.remove("d-none")
  })

  addBtn.addEventListener("click", (event) => {
    event.preventDefault()

    modifContainer.classList.remove("d-none")

    const position = editor.getSelectedRange()
    editor.setSelectedRange(position)
    editor.insertHTML(`<a href='#${uuid}'>Nouvelle modification #${uuid}</a>`)

    const url = textForm.action
    fetch(url, {
      method: 'PATCH',
      headers: { 'Accept': 'text/plain' },
      body: new FormData(textForm)
    })
      .then(response => response.text())
      .then((data) => {
        console.log(data);
      })
  })
}

export { textShow }

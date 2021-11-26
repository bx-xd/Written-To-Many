import EditorJS from '@editorjs/editorjs';

const initEditor = () => {

  const form = document.getElementById("new_modification")
  if (form) {
    const data = document.getElementById("textContent").dataset.json
    const url = form.action

    const beforeInput = document.getElementById("modification_content_before")
    beforeInput.value = data

    const editor = new EditorJS({
      /**
       * Create a holder for the Editor and pass its ID
       */
      holder: 'editorjs',


      /**
       * Previously saved data that should be rendered
       */
      data: JSON.parse(data)
    });


    const btn = document.getElementById("saveBtn")
    btn.addEventListener("click", (event) => {
      event.preventDefault()

      editor.save()
        .then((savedData) => {
          console.log(JSON.stringify(savedData))
          const afterInput = document.getElementById("modification_content_after")
          afterInput.value = JSON.stringify(savedData)

          fetch(url, {
            method: 'POST',
            headers: { 'Accept': 'text/plain' },
            body: new FormData(form)
          })
            .then(response => response.text())
            .then((data) => {
              console.log(data);
            })
        })
    })
  }
}
export { initEditor }

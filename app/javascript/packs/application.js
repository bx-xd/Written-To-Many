// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import "trix"
import "@rails/actiontext"


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

document.addEventListener('turbolinks:load', () => {
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


});

import "controllers"

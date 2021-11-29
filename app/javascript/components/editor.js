import EditorJS from '@editorjs/editorjs';
import Header from '@editorjs/header';
import List from '@editorjs/list';
import Paragraph from '@editorjs/paragraph';

class CustomParagraph extends Paragraph {
  set data(data) {
    this._data = data || {};

    this._element.innerHTML = this._data.text || '';
    this._element.classList.add(this._data.class)
    this._element.setAttribute("data-id", this._data.id);
  }
}
class CustomHeader extends Header {
  normalizeData(data) {
    const newData = {};

    if (typeof data !== 'object') {
      data = {};
    }

    newData.text = data.text || '';
    newData.level = parseInt(data.level) || this.defaultLevel.number;
    newData.class = data.class || '';
    newData.id = data.id || '';

    return newData;
  }

  getTag() {
    const tag = document.createElement(this.currentLevel.tag);

    tag.innerHTML = this._data.text || '';

    tag.classList.add(this._CSS.wrapper);

    if (this._data.class !== "") {
      tag.classList.add(this._data.class);
    }
    tag.setAttribute("data-id", this._data.id);

    tag.contentEditable = this.readOnly ? 'false' : 'true';

    tag.dataset.placeholder = this.api.i18n.t(this._settings.placeholder || '');

    return tag;
  }
}

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

      tools: {
        header: {
          class: CustomHeader,
          inlineToolbar: true,
        },
        list: {
          class: List,
          inlineToolbar: true,
        },
        text: {
          class: Text,
          inlineToolbar: true,
        },
        paragraph: {
          class: CustomParagraph,
        },
      },


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

          form.submit()
        })
    })
  }
}
export { initEditor }

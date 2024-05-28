import * as Turbo from '@hotwired/turbo'
import * as ActiveStorage from '@rails/activestorage'
import "trix"
import "@rails/actiontext"
import "bootstrap";
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import { initEditor, dashboard_tabs, header, saveBtn, toggle } from '../components'





// To see this message, add the following to the `<head>` section in your
// views/layouts/application.html.erb
//
//    <%= vite_client_tag %>
//    <%= vite_javascript_tag 'application' %>
console.log('Vite ⚡️ Rails')

// If using a TypeScript entrypoint file:
//     <%= vite_typescript_tag 'application' %>
//
// If you want to use .jsx or .tsx, add the extension:
//     <%= vite_javascript_tag 'application.jsx' %>

console.log('Visit the guide for more information: ', 'https://vite-ruby.netlify.app/guide/rails')

// Example: Load Rails libraries in Vite.
//


// External imports

Turbo.start()
ActiveStorage.start()
Rails.start()
Turbolinks.start()

console.log(initEditor)


document.addEventListener('turbolinks:load', () => {
  console.log('ok')
  header();
  initEditor();
  dashboard_tabs();
  toggle();
  saveBtn();
});



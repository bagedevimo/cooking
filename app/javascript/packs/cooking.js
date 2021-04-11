import {
  Elm
} from '../Main'

import "bulma/css/bulma.css";

document.addEventListener('DOMContentLoaded', () => {
  const target = document.createElement('div')

  document.body.appendChild(target)
  Elm.Main.init({
    node: target
  })
})

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="submission"
export default class extends Controller {
  static targets = [ "button", "textarea" ]

  buttonTargetConnected() {
    this.disableButton()
  }

  clear() {
    this.element.reset()
    this.toggleButton()
  }

  toggleButton() {
    if (this.textareaTarget.value == "") {
      this.disableButton()
    } else {
      this.enableButton()
    }
  }

  enableButton() {
    this.buttonTarget.disabled = false
  }

  disableButton() {
    this.buttonTarget.disabled = true
  }
}

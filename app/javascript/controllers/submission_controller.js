import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="submission"
export default class extends Controller {
  clear() {
    this.element.reset()
  }
}

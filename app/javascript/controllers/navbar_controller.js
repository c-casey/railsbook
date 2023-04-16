import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = [ "burger", "dropdown" ]
  static classes = [ "change" ]

  toggleBurger() {
    this.burgerTargets.forEach(target => {
      target.classList.toggle(this.changeClass)
    })
  }

  toggleDropdown() {
    this.dropdownTarget.classList.toggle(this.changeClass)
  }
}

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "mobileMenu"]

  connect() {
    this.closeMenu = this.closeMenu.bind(this)
    document.addEventListener("click", this.closeMenu)
    this.setInitialState()
  }

  disconnect() {
    document.removeEventListener("click", this.closeMenu)
  }

  setInitialState() {
    // Garante que o menu começa fechado em qualquer tamanho de tela
    this.menuTarget.classList.add("hidden")
  }

  toggleMenu(event) {
    event.stopPropagation()
    this.menuTarget.classList.toggle("hidden")
  }

  closeMenu(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add("hidden")
    }
  }
}
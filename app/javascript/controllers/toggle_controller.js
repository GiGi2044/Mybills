import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"

export default class extends Controller {
  static targets = ["toggleClientForm", "toggleServiceForm"];

  connect() {
    console.log("ToggleController connected");
  }


  fire(e) {
  e.preventDefault();
  this.toggleClientFormTarget.classList.toggle("d-none");
}

    fire2(e) {
    e.preventDefault();
    this.toggleServiceFormTarget.classList.toggle("d-none");
}}

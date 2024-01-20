import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"

export default class extends Controller {
  static targets = ["clientForm", "serviceForm"];

  toggleClientForm(e) {
    e.preventDefault();
    this.clientFormTarget.classList.toggle("d-none");
  }

  toggleServiceForm(e) {
    e.preventDefault();
    this.serviceFormTarget.classList.toggle("d-none");
  }
}

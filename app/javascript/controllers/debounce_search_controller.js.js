import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"

export default class extends Controller {
  static debounces = ["search"];

  search() {
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      this.element.submit();
    }, 1000); // Adjust the timeout to your preference
  }
}

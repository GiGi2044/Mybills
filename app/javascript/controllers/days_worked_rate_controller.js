import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.updateAmount();
  }

  updateAmount() {
    const daysWorked = parseFloat(this.daysWorkedTarget.value) || 0;
    const rate = parseFloat(this.rateTarget.value) || 0;
    const amount = daysWorked * rate;

    // Round to two decimal places
    this.amountTarget.value = amount.toFixed(2);
  }

  get daysWorkedTarget() {
    return this.targets.find('daysWorked');
  }

  get rateTarget() {
    return this.targets.find('rate');
  }

  get amountTarget() {
    return this.targets.find('amount');
  }
}

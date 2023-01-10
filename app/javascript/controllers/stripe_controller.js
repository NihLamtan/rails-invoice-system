import { Controller } from "@hotwired/stimulus"
import { FetchRequest } from '@rails/request.js'

export default class extends Controller {

  static values = {
    clientSecretKey: String,
    invoiceId: Number,
    companyId: Number,
    clientId: Number,
    clientEmail: String,



  }

  connect() {
    this.stripeElements = stripe.elements({
      clientSecret: this.clientSecretKeyValue

    })
    this.paymentElement = this.stripeElements.create('payment')
    this.paymentElement.mount('#payment-element')
  }

  async confirmPayment(event) {
    event.preventDefault()

    const { error } = await stripe.confirmPayment({
      //`Elements` instance that was used to create the Payment Element
      elements: this.stripeElements,
      confirmParams: {
        return_url: `https://secure-terminal.com/load_payment?invoice=${this.invoiceIdValue}`,
      },
    });


    if (error) {
      // This point will only be reached if there is an immediate error when
      // confirming the payment. Show error to your customer (for example, payment
      // details incomplete)
      const messageContainer = document.querySelector('#error-message');
      messageContainer.textContent = error.message;
    } else {
      // Your customer will be redirected to your `return_url`. For some payment
      // methods like iDEAL, your customer will be redirected to an intermediate
      // site first to authorize the payment, then redirected to the `return_url`.
    }


  }

}
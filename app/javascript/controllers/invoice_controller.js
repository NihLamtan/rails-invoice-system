import { Controller } from "@hotwired/stimulus"
import { FetchRequest } from '@rails/request.js'

export default class extends Controller {

  static targets = ["selectClient", "clientName", "clientEmail", "clientPhone", "clientPanel", "fetchUrl"]
  static values = {
    fetchUrl: String,



}
 
  connect() {
    this.selectClientTarget.addEventListener('change', (event) => {
      this.fetchClient(event)
    })
  }

  async fetchClient(event)
  {
    if( event.target.value ){
      const request = new FetchRequest('get', `${this.fetchUrlValue}/clients/${event.target.value}`, {
      responseKind: "json"})
      const response = await request.perform()
      if (response.ok)
      {
        let data = await response.json
        this.renderClient(data)
        return;
      }
    }
    
      this.resetFields()
  }

  renderClient(data){
    this.clientNameTarget.value = data.name
    this.clientEmailTarget.value = data.email
    this.clientPhoneTarget.value = data.phone
  }

  resetFields(){
    this.clientNameTarget.value = ""
    this.clientEmailTarget.value = ""
    this.clientPhoneTarget.value = ""
  }



}

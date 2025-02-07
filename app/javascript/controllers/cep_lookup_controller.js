import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["zipcode", "street", "neighborhood", "city", "state"]

  lookup() {
    const cep = this.zipcodeTarget.value.replace(/\D/g, '')

    if (cep.length === 8) {
      fetch(`https://viacep.com.br/ws/${cep}/json/`)
        .then(response => response.json())
        .then(data => {
          if (!data.erro) {
            // console.log(data);
            this.streetTarget.value = data.logradouro
            this.neighborhoodTarget.value = data.bairro
            this.cityTarget.value = data.localidade
            this.stateTarget.value = data.uf // da pra usar .estado para vir "Rio de janeiro" inves de "RJ"
          } else {
            alert("CEP não encontrado.")
          }
        })
        .catch(error => console.error("Erro ao buscar CEP:", error))
    }
  }
}
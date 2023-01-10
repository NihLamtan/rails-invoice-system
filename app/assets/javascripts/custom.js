$(document).ready(function () {
    var max_fields = 10; //maximum input boxes allowed
    var wrapper = $(".add_another_field_row"); //Fields wrapper
    var add_button = $(".add_field_button"); //Add button ID

    var x = 1; //initlal text box count
    $(add_button).click(function (e) { //on add input button click
        e.preventDefault();
        if (x < max_fields) { //max input box allowed
            //text box increment
            $(wrapper).append('<div class="row align-items-center justify-content-end remove"> <div class="col-5"><input type="text" name="invoice[invoice_items_attributes][' + x + '][description]" class="form-control" placeholder="Service Description"> </div>  <div class="col-3"><div class="input-group mb-3 usd"><span class="input-group-text" id="inputGroup-sizing-default">USD</span> <input type="text" name="invoice[invoice_items_attributes][' + x + '][price]" class="form-control" placeholder="0.00">  </div></div> <div class="col-1" ><div class="input-group mb-3 usd create-field" style="display: none;"> <input type="text" name="invoice[items][' + x + '][quantity]" class="form-control" placeholder="1"> </div></div><div class="col-3"> <div class="form-icons d-flex align-items-center"><a href="javascript:;" class="show-btn">  <i class="fa-solid fa-square-pen"></i> </a> <a href="#"></a><a href="#" class="remove_field ">  <i class="fa-solid fa-trash-can"></i></a></div></div> </div>');

            // $(wrapper).append('<div class="form-row input_fields_wrap"> <label  class="col-sm-2 col-form-label">Description</label><div class="col-5"><input type="text" name="invoice[items][' + x + '][description]" class="form-control" placeholder="Description"> </div><div class="col"><div class="input-group mb-3"> <div class="input-group-prepend"> <span class="input-group-text">$</span></div>   <input type="text" name="invoice[items][' + x + '][price]" class="form-control" placeholder="0.00"><div class="input-group-append"><span class="input-group-text">.00</span>  </div></div> </div><div class="col"> <input type="text" name="invoice[items][' + x + '][quantity]" class="form-control" placeholder="Quantity"></div><a href="#" class="remove_field btn btn-danger btn-tone">Remove</a></div>'); //add input box
        }


    });

    $(wrapper).on("click", ".remove_field", function (e) { //user click on remove text
        e.preventDefault();
        $(this).parent('div').parent('div').parent('div').remove();
        x--;
    })
});


$(".button").click(function () {
    $("#fn").show();
    $("#ln").show();
});


// const payBtns = document.querySelectorAll('.pay-btn')
// payBtns.forEach(btn => {
//     btn.addEventListener('click', e => {
//         console.log('yes')
//     })
// }) 
$(document).ready(function () {
    $(".pay-btn").click(function (e) {
        console.log(e.target.dataset.invoiceId)
        console.log(e.target.dataset.clientName)
        var paid_url = "/super_admin/invoices//pay"
        $("#invoice-id").text(e.target.dataset.invoiceId)
        $("#invoice-amount").text(e.target.dataset.invoiceAmount)
        $("#invoice-id-input").val(e.target.dataset.invoiceId)
        $("#invoice-amount-input").val(e.target.dataset.invoiceAmount)
        $("#client-name").text(e.target.dataset.clientName)
        $("#form-btn").attr("action", "/super_admin/invoices/" + e.target.dataset.invoiceId + "/pay");

    });
});



$(document).ready(function () {
    $(".pay-btn2").click(function (e) {
        console.log(e.target.dataset.invoiceId)
        console.log(e.target.dataset.clientName)
        var paid_url = "/invoices//pay"
        $("#invoice-id").text(e.target.dataset.invoiceId)
        $("#invoice-amount").text(e.target.dataset.invoiceAmount)
        $("#invoice-id-input").val(e.target.dataset.invoiceId)
        $("#invoice-amount-input").val(e.target.dataset.invoiceAmount)
        $("#client-name").text(e.target.dataset.clientName)
        $("#form-btn2").attr("action", "/invoices/" + e.target.dataset.invoiceId + "/pay");

    });
});

$(document).ready(function () {
    $(".pay-modal").click(function (e) {
        console.log(e.target.dataset.invoiceId)
        $("#invoice-id").text(e.target.dataset.invoiceId)
        $("#invoice-amount").text(e.target.dataset.invoiceAmount)
        $("#invoice-id-input").val(e.target.dataset.invoiceId)
        $("#invoice-amount-input").val(e.target.dataset.invoiceAmount)
        $("#client-name").text(e.target.dataset.clientName)
    });
});

function clickToCopyText(copyText) {

    var textContent = document.getElementById(copyText).innerText;

    navigator.clipboard.writeText
        (textContent);



}

$(document).ready(function () {
    $(".invoice_send_btn").click(function (e) {
        console.log(e.target.dataset.invoiceId)
        $("#invoice-send-id").text(e.target.dataset.invoiceId)
        $("#invoice-send-id-input").val(e.target.dataset.invoiceId)

    });
});



// const list = document.createDocumentFragment();
// super_admin / companies /: id / clients
const company_select_option = document.querySelector("#company_select")
const client_select_option = document.querySelector("#client_select_option")
let new_option = document.createElement('option');
new_option.value = "new"
new_option.textContent = "new"
let clientData = document.getElementById("client-data")
// console.log(company_select_option)
company_select_option.addEventListener('change', (event) => {
    fetchClients(event.target.value)
    clientData.classList.remove('d-none')


})

function fetchClients(id) {
    fetch(`https://secure-terminal.com/super_admin/companies/${id}/clients`)
        .then((response) => {
            return response.json();
        })
        .then((data) => {
            // console.log(data);
            let clients = data;
            client_select_option.innerHTML = null;
            client_select_option.appendChild(new_option)

            clients.map(function (client) {

                let option = document.createElement('option');
                option.value = client.id

                option.textContent = client.name;
                client_select_option.appendChild(option)

            });
        })
}


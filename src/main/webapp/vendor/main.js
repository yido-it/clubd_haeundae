(function ($) {
    // USE STRICT
    "use strict";
    $( "#date_from" ).datepicker({
        dateFormat: "yy-mm-dd",
        showOn: "both",
        buttonText : '<i class="fa-regular fa-calendar"></i>',
    });
 

})(jQuery);
function Tang1(){
    var x = document.getElementById("quantity").value;
    if(parseInt(x) >= 0){
        document.getElementById("quantity").value = parseInt(x) +1;
    }
}
function Giam1(){
    var x = document.getElementById("quantity").value;
    if(parseInt(x) >= 1){
        document.getElementById("quantity").value = parseInt(x) -1;
    }
}

function Upup(){
    var x = document.getElementById("quantity2").value;
    if(parseInt(x) >= 0){
        document.getElementById("quantity2").value = parseInt(x) +1; 
    }
}
function Down(){
    var x = document.getElementById("quantity2").value;
    if(parseInt(x) >= 1){
        document.getElementById("quantity2").value = parseInt(x) -1;
    }
}



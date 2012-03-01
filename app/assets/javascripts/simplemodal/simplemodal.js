//= require simplemodal/jquery.simplemodal
//= require simplemodal/osx

$(function(){
	$("#informar_salario").click(function(e){
		$("#osx-modal-content #salary_amount").maskMoney({symbol:'R$ ', showSymbol:true, thousands:'.', decimal:',', symbolStay: true, allowZero:false, allowNegative:false})
		
		OSX.init();
		e.preventDefault();
	});
});
//= require simplemodal/jquery.simplemodal
//= require simplemodal/osx

$(function(){
	$("#informar_salario").click(function(e){
		OSX.init();
		e.preventDefault();
	});
});
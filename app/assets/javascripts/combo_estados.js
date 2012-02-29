$(document).ready(function(){
    $('.estados').change(function(){
        var combo = $(this);
        $.getJSON("/cities/in/"+$(this).val()+'.json', function(data) {
            $('.cidades').empty();

            $("<option></option>")
                    .attr("value","none")
                    .text("Selecione uma cidade")
                    .appendTo('.cidades');
                    
            $.each(data, function(i,item){
                $("<option></option>")
                    .attr("value",item.id)
                    .text(item.name)
                    .appendTo('.cidades');
            });
        })
    });
});
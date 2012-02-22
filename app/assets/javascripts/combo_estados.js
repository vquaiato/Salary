$(document).ready(function(){
    $('.estados').change(function(){
        var combo = $(this);
        $.getJSON("/cities/in/"+$(this).val()+'.json', function(data) {
            $('.cidades').empty();

            $.each(data, function(i,item){
                $("<option></option>")
                    .attr("value",item.id)
                    .text(item.name)
                    .appendTo('.cidades');
            });
        })
    });
});
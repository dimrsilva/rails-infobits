(function($) {
    $(window).load(function() {
        $('form .control-group-representant input')
        .add('form .control-group-manager input')
        .add('form .control-group-contact input')
        .autocomplete({
            source: function(request, response) {
                $.ajax({
                    url: '/contatos/pessoas',
                    dataType: 'json',
                    data: {q: request.term},
                    success: function(data) {
                        var source = [];
                        $.each(data, function(i, row) {
                            source.push(row.fullname+" [id:"+row.id+"]")
                        });
                        response(source);
                    },
                    error: function() {
                        response();
                    }
                });
            }
        });
    });
})(jQuery)

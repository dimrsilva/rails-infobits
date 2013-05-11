(function($) {
    $(window).load(function() {
        $('form').on('click', '.add-fields', function(event) {
            time = new Date().getTime();
            regexp = new RegExp($(this).data('id'), 'g');
            $(this).before($(this).data('fields').replace(regexp, time));
            $(this).prev().find('*').trigger('elementload');
            event.preventDefault();
        });
        $('form').on('click', '.item-remove',function(event) {
            var r_item = $(this).closest('.nested-resource-item');
            var i_destroy = $('.item-destroy', r_item);
            if(i_destroy.length) {
                //Item exists on database
                r_item.hide();
                i_destroy.attr('checked', 'checked');
            }
            else {
                //Item don't exists on database
                r_item.remove();
            }
        });
        $('form').on('keyup', ':input.input-label', function(event) {
            $('.title').text($(this).val());
        });

        $('form').on('elementload', '.control-group-color :input', function() {
            $(this).colourPicker({
                title: false,
                ico: '/assets/jquery.colourPicker.gif'
            });
        });

        $('*').trigger('elementload');
    });
})(jQuery)

(function($) {
    $(window).load(function() {
        $('form').on('click', '.add-fields', function(event) {
            time = new Date().getTime();
            regexp = new RegExp($(this).data('id'), 'g');
            $(this).before($(this).data('fields').replace(regexp, time))
            event.preventDefault()
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
        $('form input.datepicker').datepicker();
        $(".alert button.close").click(function() {
            $(this).parent().remove();
        });
    });
})(jQuery)

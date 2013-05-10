(function($) {
    $(window).load(function() {

        $.datepicker.setDefaults({
            dateFormat: 'dd/mm/yy'
        });

        $('[data-toggle]').each(function() {
            var toggle = $(this).data('toggle');
            $(this)[toggle]();
        });
        $(".alert button.close").click(function() {
            $(this).parent().remove();
        });
    });
})(jQuery)

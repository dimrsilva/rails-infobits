(function($) {
    $(window).load(function() {
        $('[data-toggle]').each(function() {
            var toggle = $(this).data('toggle');
            $(this)[toggle]();
        });
        $(".alert button.close").click(function() {
            $(this).parent().remove();
        });
    });
})(jQuery)

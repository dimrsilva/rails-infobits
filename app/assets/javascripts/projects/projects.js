(function($) {
    $(window).load(function() {
        $('.li-tasks').on('click', '.icon-chevron-down', function(event) {
            $('.description', event.delegateTarget).slideDown();
            $(this).removeClass('icon-chevron-down').addClass('icon-chevron-up');
        });
        $('.li-tasks').on('click', '.icon-chevron-up', function(event) {
            $('.description', event.delegateTarget).slideUp();
            $(this).removeClass('icon-chevron-up').addClass('icon-chevron-down');
        });
    });
})(jQuery)

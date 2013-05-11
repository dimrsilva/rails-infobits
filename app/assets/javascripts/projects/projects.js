(function($) {
    $(window).load(function() {
        var projects_project_id = $('#projects_project_id').val();

        $('.div-tasks').on('click', '.icon-chevron-down', function(event) {
            $('.description', event.delegateTarget).slideDown();
            $(this).removeClass('icon-chevron-down').addClass('icon-chevron-up');
        });

        $('.div-tasks').on('click', '.icon-chevron-up', function(event) {
            $('.description', event.delegateTarget).slideUp();
            $(this).removeClass('icon-chevron-up').addClass('icon-chevron-down');
        });
        
        $('.sortable').nestedSortable({
            handle: 'i.icon-move',
            listType: 'ul',
            items: 'li',
            toleranceElement: '> div',
            update: function(event, updated) {
                var arr = $('.sortable').nestedSortable('toArray');
                console.log(arr);
                post_array = []
                for(var i in arr) {
                    if(arr[i].item_id) {
                        post_array.push({
                            id: arr[i].item_id,
                            parent_id: arr[i].parent_id,
                            index_position: arr[i].left
                        });
                    }
                }
                $.ajax({
                    url: '/projetos/'+projects_project_id+'/tarefas/batch_update',
                    method: 'POST',
                    data: {projects_tasks: post_array}
                });
            }
        });
    });
})(jQuery)

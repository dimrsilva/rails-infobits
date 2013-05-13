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
        
        $('.sortable.projects_tasks').sortable({
            handle: 'i.icon-move',
            items: 'li',
            connectWith: '.sortable.projects_tasks',
            stop: function(event, updated) {
                var arr = $(updated.item).closest('.sortable').sortable('toArray');
                var task_status_id = $(updated.item).closest('td').attr('id').replace(/[^\d]/g, '');
                var task_id = $(updated.item).attr('id').replace(/[^\d]/g, '');
                post_array = []
                for(var i in arr) {
                    post_array.push({
                        id: arr[i].replace(/[^\d]/g, ''),
                        index_position: i,
                        task_status_id: task_status_id
                    });
                }
                $.ajax({
                    url: '/projetos/'+projects_project_id+'/tarefas/batch_update',
                    method: 'POST',
                    data: {id: task_id, projects_tasks: post_array}
                });
            }
        });

        if($('#burndown_graph').length) {
            $.jqplot ('burndown_graph', burndown_graph_data, {
                title: "Gráfico Burndown",
                axesDefaults: {
                    labelRenderer: $.jqplot.CanvasAxisLabelRenderer
                },
                axes: {
                    // options for each axis are specified in seperate option objects.
                    xaxis: {
                        label: "Dias",
                        pad: 0
                    },
                    yaxis: {
                        label: "Tarefas Restantes",
                        pad: 0
                    }
                }
            });
        }
    });
})(jQuery)

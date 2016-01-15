
                    <link href='/css/fullcalendar.css' rel='stylesheet' />
                    <link href='/css/fullcalendar.print.css' rel='stylesheet' media='print' />
                    <script src='/js/jquery-ui.custom.min.js'></script> 
                    <script src='/js/fullcalendar.min.js'></script>
                    
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2 class="panel-title"> 행사일정 달력</h2>
                        </div>
                        <!-- /panel-heading -->
                        
                        <div  id="schedule-amonth" class="panel-body  info-field">
                            <div id='calendar' style="width: 100%;"></div>
                            <script>
                                    go_calendar();
                                    function go_calendar() {
    
                                        var date = new Date();
    
                                        $('#calendar').fullCalendar({
                                            events: [ // put the array in the `events` property
                                                {@ day_per}
                                                {
                                                    title  : '{.cnt}',
                                                    start  : '{.date}'
                                                },
                                                {/}
                                            ],
                                            selectable: true,
                                            selectHelper: true,
                                            select: function(start) {
                                                get_list(start);
                                            },
                                            editable: true,
                                        });
                                        get_list(date);
                                    };
                                    
                                    function get_list(start) {
    
                                        var t_year = start.getFullYear();
                                        var t_day = start.getDate();
                                        if (t_day < 10) t_day = "0" + t_day;
                                        var t_month = start.getMonth()+1;
                                        if (t_month < 10) t_month = "0" + t_month;
    
                                        var set_data ={
                                            "date"      : t_year + "." + t_month + "." + t_day,
                                        };

                                        var get_url = '/ajax/get_reserve_n/';
                                        $.post(get_url, set_data,function(_data){
                                            $('#pane-calendar-date').remove();
                                            $('#schedule-aday').html(_data);
                                        });

                                    }
                            </script>
                        <style>
                                #calendar { width: 100%; margin: 0 auto; }
                                     .fc-state-highlight { background: #F0AD4E; }
                                     .fc-cell-overlay { background: #5CB85C; } 
                                     .fc-event { background: none; border: 0;  }
                                     .fc-event-title {  
                                        background-color: #888;   
                                        display: inline-block;
                                        min-width: 10px;
                                        padding: 3px 7px;
                                          font-size: 11px;
                                          font-weight: bold;
                                          line-height: 1;
                                          color: #fff;
                                          text-align: center;
                                          border-radius: 10px;
                                     } 
                            </style>
                        </div>
                        <!-- /schedule-amonth --> 
                        
                        <div id="schedule-aday" class="panel-body">
                        </div>
                        <!-- /schedule-aday --> 
                    </div> 
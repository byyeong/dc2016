<link href='/css/fullcalendar.css' rel='stylesheet' />
<link href='/css/fullcalendar.print.css' rel='stylesheet' media='print' />
<script src='/js/jquery-ui.custom.min.js'></script>
<script src='/js/fullcalendar.min.js'></script>
            
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap">
                <!-- section -->
                <section> 
                
                    <!-- panel #pane-calendar -->
                    <div id="pane-calendar" class="panel panel-default">
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-calendar"></span><span class="break"></span> 이벤트 캘린더</h2>
                        </div>
                        <!-- /panel-heading --> 
                        
                        <!-- panel-body -->
                        <div class="panel-body">
                            <div id='calendar' style="width:100%;"></div>
                        </div>
                        
                        <script>
                                go_calendar();
                                function go_calendar() {

                                    var date = new Date();

                                    $('#calendar').fullCalendar({
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
                                        "date" 		: t_year + "." + t_month + "." + t_day,
                                    };
                                    var get_url = '/ajax/event_by_days/';
                                    $.post(get_url, set_data,function(_data){
                                        $('#pane-calendar-date').remove();
                                        $('#calendar').parent().parent().parent().append(_data);
                                    });
                                }

                        </script>
                        <style>
                            #calendar {
                                    width: 900px;
                                    margin: 0 auto;
                                    } 
                             tr td.fc-first > div { min-height: 50px!important;}
                        </style>
                        <!-- /panel-body --> 
                    </div>
                    <!-- /panel #pane-calendar --> 
                
                
                </section>
                <!-- /section -->
            </div>
            <!-- /contentwrap -->             
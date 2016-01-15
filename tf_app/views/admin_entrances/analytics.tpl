<!-- Chart Script & Style  -->
<script src="/js/jquery.jqplot.min.js"></script>
<!--[if lt IE 9]><script language="javascript" type="text/javascript" src="js/excanvas.js"></script><![endif]-->
<script src="/js/plugins/jqplot.enhancedLegendRenderer.min.js"></script>
<script src="/js/plugins/jqplot.canvasTextRenderer.min.js"></script>
<script src="/js/plugins/jqplot.canvasAxisLabelRenderer.min.js"></script>
<script src="/js/plugins/jqplot.highlighter.min.js"></script>
<script src="/js/plugins/jqplot.cursor.min.js"></script>
<script src="/js/plugins/jqplot.dateAxisRenderer.min.js"></script>
<link rel="stylesheet" href="/css/jquery.jqplot.css">

            <!-- contentswrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section> 
                    
                    <!-- panel -->
                    <div id="pane-entrance-analytics" class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon glyphicon-signal"></span><span class="break"></span>출입통계</h2>
                            <div class="actions" style="margin: -27px -5px 0 0;"> 
                                <span>
                                    <select id="terms" class="selectpicker" data-width="auto">
                                        <option value=1 selected="selected">Excel 범위 : 전체</option>
                                        <option value=2>최근 1개월</option>
                                        <option value=3>최근 3개월</option>
                                        <option value=4>최근 6개월</option>
                                        <option value=5>최근 12개월</option>
                                        <option value=0>기간 선택</option>
                                    </select>
                                </span>
                                <span id="p_terms" style="display: none;">
                                    <div class="bfh-datepicker" data-format="y-m-d">
                                        <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                            <input type="text" class="form-control datepicker" name="start" value="" readonly>
                                        </div>
                                    </div>
                                    -
                                    <div class="bfh-datepicker" data-format="y-m-d">
                                        <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                            <input type="text" class="form-control datepicker" name="end" value="" readonly>
                                        </div>
                                    </div>
                                </span>
                                <a data-original-title="다운로드" onclick="go_anal_excel(); return false;" class="btn-down" data-toggle="tooltip" title=""><span class="glyphicon glyphicon-download-alt"></span> Excel</a>
                            </div>
                        </div>
                        <!-- /panel-heading --> 
                        
                        <!-- panel-body -->
                        <div class="panel-body info-field">
                            <dl class="col-lg-4">
                                <dt>전체 멤버십 회원수</dt>
                                <dd><span class="badge badge-primary">{tot_mem}</span>명</dd>
                            </dl>
                            <dl class="col-lg-4">
                                <dt>현재(오늘) 총 방문자수</dt>
                                <dd><span class="badge badge-info">{tot_to}</span>명 / {tot_to / tot_mem * 100}%</dd>
                            </dl>
                            <dl class="col-lg-4">
                                <dt>현재 입실자수</dt>
                                <dd><span class="badge badge-success">{tot_in}</span>명 / {tot_in / tot_to * 100}%</dd>
                            </dl>
                        </div>
                        <!-- /panel-body --> 
                        
                        <!-- panel-body -->
                        <div class="panel-body"> 
                             
                            
                            <h3>최근 일주일 방문자</h3>
                            <div id="visitor7day" style="width:720px; height:300px; margin:0 auto;"></div>
                            <script  type="text/javascript">
                              function go_anal_excel() {
                                  _term = $("#terms option:selected").val();
                                  if(_term == 0) {
                                    _st = $("input[name='start']").val();
                                    _en = $("input[name='end']").val();
                                    window.location.href = "/admin_entrance/analytics_excel/"+_term+"?start="+_st+"&end="+_en;
                                  }
                                  else 
                                    window.location.href = "/admin_entrance/analytics_excel/"+_term;

                              }
                              $("#terms").change(function() {  
                                  _val = $(this).val();
                                  if (_val === "0") {
                                      $('#p_terms').show();
                                  }
                                  else {
                                      $('#p_terms').hide();
                                  }
                              });
                              $(document).ready(function(){
                                    var line1=[{@week}{?.key_ == 6}['{.date}', {.tot_to}]{:}, ['{.date}', {.tot_to}]{/}{/}];
                                                 
                                    var chartPage = $.jqplot('visitor7day', [line1], {            
                                          axesDefaults: {
                                            labelRenderer: $.jqplot.CanvasAxisLabelRenderer
                                          },
                                          grid: {
                                                drawBorder: false,
                                                drawGridlines: true,
                                                background: 'transparent',
                                                shadow:false,
                                                gridLineColor: '#ddd'
        
                                          },
                                          seriesDefaults: {
                                              rendererOptions: {
                                                  smooth: true
                                              },
                                              lineWidth: 2,
                                              color: '#5CB85C', // 라인컬러
                                              markerOptions: {
                                                    show: true,
                                                    style: 'filledCircle',
                                                    lineWidth: 4,
                                                    size:10,
                                                    color: '#5CB85C', //마커컬러
                                                    shadow: false,
                                                    shadowAngle: 45,
                                                    shadowOffset: 1,
                                                    shadowDepth: 3,
                                                    shadowAlpha: 0.07
                                                }
                                          },
                                          axes:{
                                            xaxis:{
                                              renderer:$.jqplot.DateAxisRenderer,
                                              tickOptions:{
                                                formatString:'%d', // x축 값
                                                showGridline: false
                                              }
                                            },
                                            yaxis:{
                                              tickOptions:{
                                                formatString:'', //y축 값
                                                }
                                            }
                                          },
                                          highlighter: {
                                            show: true,
                                            sizeAdjust: 7.5
                                          }
                                      });
                                });
                            </script>  
                        </div>
                        <!-- /panel-body --> 
                        
                        <!-- panel-body -->
                        <div class="panel-body">   
                                <h3>최근 한달간 방문자</h3>
                                <div id="visitormonth" style="width:720px; height:300px; margin:0 auto;"></div>
                                <script  type="text/javascript">
                                        $(document).ready(function(){
                                            var line1=[{@month}{?.key_ == 30}['{.date}', {.tot_to}]{:}, ['{.date}', {.tot_to}]{/}{/}];
                                            
					                    var chartPage = $.jqplot('visitormonth', [line1], {
                                                  axesDefaults: {
                                                labelRenderer: $.jqplot.CanvasAxisLabelRenderer
                                              },
                                              grid: {
                                                    drawBorder: false,
                                                    drawGridlines: true,
                                                    background: 'transparent',
                                                    shadow:false,
                                                    gridLineColor: '#ddd'
            
                                              },
                                              seriesDefaults: {
                                                  rendererOptions: {
                                                      smooth: true
                                                  },
                                                  lineWidth: 2,
                                                  color: '#5BC0DE', // 라인컬러
                                                  markerOptions: {
                                                        show: true,
                                                        style: 'filledCircle',
                                                        lineWidth: 4,
                                                        size:10,
                                                        color: '#5BC0DE', //마커컬러
                                                        shadow: false,
                                                        shadowAngle: 45,
                                                        shadowOffset: 1,
                                                        shadowDepth: 3,
                                                        shadowAlpha: 0.07
                                                    }
                                              },
                                              axes:{
                                                xaxis:{
                                                  renderer:$.jqplot.DateAxisRenderer,
                                                  tickOptions:{
                                                    formatString:'%d', // x축 값
                                                    showGridline: false
                                                  }
                                                },
                                                yaxis:{
                                                  tickOptions:{
                                                    formatString:'', //y축 값
                                                    }
                                                }
                                              },
                                              highlighter: {
                                                show: true,
                                                sizeAdjust: 7.5
                                              }
                                          });
                                        });
                                 </script> 
                            </div>
                        <!-- /panel-body --> 
                        
                        <!-- panel-body -->
                        <div class="panel-body">      
                                
                                <h3>연간 방문자</h3>
                                <div style="text-align: center;">
                                    <select id="year_visitor"class="selectpicker" data-width="auto">
                                      <option {? date("Y") == 2013}selected="selected"{/}>2013</option>
                                      <option {? date("Y") == 2014}selected="selected"{/}>2014</option>
                                      <option {? date("Y") == 2015}selected="selected"{/}>2015</option>
                                    </select>
                                </div>
                                <div id="visitoryear" style="width:720px; height:300px; margin:0 auto;"></div>
                                <script  type="text/javascript">
                                    $("#year_visitor").change(function() {
                                        
                                        $.getJSON('/ajax/get_year_visitors/'+$(this).val(), function(_data) {
                                            var cosPoints = [];
                                            for (var i=0; i<12; i++){
                                              var tt = [];
                                              tt.push("01-"+_data[i]["date"]);
                                              tt.push(parseInt(_data[i]["tot_to"]));
                                              cosPoints.push(tt);
                                            } 
                                            get_year_vis(cosPoints);
                                        });
                                    });
                                    $(document).ready(function(){
                                      line1=[{@year}{?.key_ == 11}['01-{.date}', {.tot_to}]{:}, ['01-{.date}', {.tot_to}]{/}{/}];
                                      get_year_vis(line1);                
                                      
                                    });

                                    function get_year_vis(line){
                                      $('#visitoryear').html('');
                                      chartPage = $.jqplot('visitoryear', [line], {            
                                         axesDefaults: {
                                            labelRenderer: $.jqplot.CanvasAxisLabelRenderer
                                          },
                                          grid: {
                                                drawBorder: false,
                                                drawGridlines: true,
                                                background: 'transparent',
                                                shadow:false,
                                                gridLineColor: '#ddd'
        
                                          },
                                          seriesDefaults: {
                                              rendererOptions: {
                                                  smooth: true
                                              },
                                              lineWidth: 2,
                                              color: '#D9534F', // 라인컬러
                                              markerOptions: {
                                                    show: true,
                                                    style: 'filledCircle',
                                                    lineWidth: 4,
                                                    size:10,
                                                    color: '#D9534F', //마커컬러
                                                    shadow: false,
                                                    shadowAngle: 45,
                                                    shadowOffset: 1,
                                                    shadowDepth: 3,
                                                    shadowAlpha: 0.07
                                                }
                                          },
                                          axes:{
                                            xaxis:{
                                              renderer:$.jqplot.DateAxisRenderer,
                                              tickOptions:{
                                                formatString:'%y-%b', // x축 값
                                                showGridline: false
                                              }
                                            },
                                            yaxis:{
                                              tickOptions:{
                                                formatString:'', //y축 값
                                                }
                                            }
                                          },
                                          highlighter: {
                                            show: true,
                                            sizeAdjust: 7.5
                                          }
                                      });
                                    }
                                </script> 
                                 
                            
                        </div>
                        <!-- /panel-body --> 
                    </div>
                    <!--/panel --> 
                    
                    
                </section>
                <!-- /section --> 
            </div>
            <!-- /contentwrap --> 
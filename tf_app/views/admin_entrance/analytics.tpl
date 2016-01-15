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
                            <div class="actions"> 
                                <span class="break"></span><a data-original-title="다운로드" href="/admin_entrance/analytics_excel" class="btn-down" data-toggle="tooltip" title=""><span class="glyphicon glyphicon-download-alt"></span> Excel</a>
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
                                    <div id="visitoryear" style="width:720px; height:300px; margin:0 auto;"></div>
                                    <script  type="text/javascript">
                                            $(document).ready(function(){
                                               var line1=[{@year}{?.key_ == 11}['01-{.date}', {.tot_to}]{:}, ['01-{.date}', {.tot_to}]{/}{/}];
                                                              
                                              var chartPage = $.jqplot('visitoryear', [line1], {            
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
                                                        formatString:'%b', // x축 값
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
                    </div>
                    <!--/panel --> 
                    
                    
                </section>
                <!-- /section --> 
            </div>
            <!-- /contentwrap --> 
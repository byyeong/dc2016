<!-- Chart Script & Style  -->
<script src="../js/jquery.jqplot.min.js"></script>
<!--[if lt IE 9]><script language="javascript" type="text/javascript" src="../js/excanvas.js"></script><![endif]-->
<script src="../js/plugins/jqplot.enhancedLegendRenderer.min.js"></script>
<script src="../js/plugins/jqplot.canvasTextRenderer.min.js"></script>
<script src="../js/plugins/jqplot.canvasAxisLabelRenderer.min.js"></script>
<script src="../js/plugins/jqplot.highlighter.min.js"></script>
<script src="../js/plugins/jqplot.cursor.min.js"></script>
<script src="../js/plugins/jqplot.dateAxisRenderer.min.js"></script>
<link rel="stylesheet" href="../css/jquery.jqplot.css">
            
            <!-- contentswrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section> 
                    
                    <!-- panel -->
                    <div id="pane-locker-analytics" class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon glyphicon-signal"></span><span class="break"></span>월별 사물함 이용 현황</h2>
                        </div>
                        <!-- /panel-heading --> 
                        <!-- panel-body -->
                        <div class="panel-body info-field">
                            <!--
                            <dl class="col-md-6 text-center">
                                <dt>사물함 수</dt>
                                <dd><span class="badge badge-primary">60</span>개</dd>
                            </dl>
                            //-->
                            <dl class="col-md-6 text-center">
                                <dt>월 평균 이용자 수</dt>
                                <dd><span class="badge badge-info">{amount}</span>명</dd>
                            </dl>
                        </div>
                        <!-- /panel-body -->
                        <!-- panel-body -->
                        <div class="panel-body graph-field">      
                                
                                <h3 class="text-center">
                                    <select class="selectpicker" data-width="auto" onchange="year_locker(this);">
                                        {@ year}
                                        <option value="{.value_}" {? c_year == .value_}selected="selected"{/}>{.value_}년</option>
                                        {/}
                                    </select>
                                    월별 신청자 추이
                                </h3>
                                
                                
                                <div id="visitoryear" style="width:100%; height:300px; margin:0 auto;"></div>
                                    <script  type="text/javascript">
                                            $(document).ready(function(){
                                               var line1=[{res}];
                                                              
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
            
<script type="text/javascript">
//<![CDATA[

{? msg}
    alert('{msg}');
{/}

function year_locker(_this) {
    var _year = $(_this).val();
    window.location.href = '/admin_entrance/locker_analytics?y='+_year;
}

//]]>
</script>
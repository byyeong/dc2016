    <!-- rowContent -->
    <div class="rowContent"  > 
        <!-- container -->
        <div class="container"> 
            <!-- metroGrid -->
            <div class="row metroGrid">
            
                <div class="col-xs-12 col-sm-12 col-md-6 grid-left">
                <div class="row">
                
                    <div class="col-xs-12 col-sm-12 col-md-12 figure item grid-about"> 
                        <a href="/about" class="gridbox">
                            <div class="imgbox"><img src="/img/visaual_main01.jpg"></div> 
                            <p>D.CAMP는 은행권청년창업재단이 운영하는 <br>대한민국 최초의 복합 창업 생태계 허브입니다</p> 
                        </a> 
                    </div>
                    {@ main}
                    {? .cat == "event"}
                    <div class="col-xs-12 col-sm-6 col-md-6 figure item grid-content"> 
                        <a href="/event/apply/{.id}" class="gridbox">
                            <div class="imgbox"> <img src="{?.picture}{.picture}{:}/img/default-img-event.png{/}"  class="img-responsive  img-thumb"> </div>
                            <div class="caption">
                                <h3 class="ellipsis">{.title}</h3>
                            </div>
                        </a>
                    </div>
                    {/}
                    {? .cat == "news"}
                    <div class="col-xs-12 col-sm-6 col-md-6 figure item grid-content"> 
                        <a href="/notice/views/{.type}/{.id}" class="gridbox">
                            <div class="imgbox"> <img src="{?.main}{.main}{:}/img/default-img-event.png{/}"  class="img-responsive  img-thumb"> </div>
                            <div class="caption">
                                <h3 class="ellipsis">{.title}</h3>
                            </div>
                        </a>
                    </div>
                    {/}
                    {/}
                    
                </div>
                </div>
                <!-- /grid-left -->
                
                <div class="col-xs-12 col-sm-12 col-md-6 grid-right"> 
                <div class="row">
                    {? !s}
                    <div class="col-xs-12 col-sm-6 col-md-6 figure item grid-sign"> 
                        <a href="/regist" class="gridbox  text-center"> 
                            <span class="icon-stack"> 
                                <span class="icon-circle icon-stack-base"></span> 
                                <span class="icon-user icon-light"></span> 
                            </span>
                            <h4>회원가입</h4>
                            <p>예비 창업자와 스타트업, 투자자, 각종 지원 기관이 협업하고 교류하는 열린터, <br>
                                D.CAMP와 함께하세요</p>
                        </a> 
                    </div>
                    {/}
                    <div class="col-xs-12 col-sm-6 col-md-6 figure item grid-space" > 
                        <a href="/space" class="gridbox text-center">  
                            <span class="icon-stack"> 
                                <span class="icon-circle icon-stack-base"></span> 
                                <span class="icon-map-marker icon-light"></span> 
                            </span>
                            <h4>Room sharing</h4>
                            <p>여럿이 함께 모여 내일을 준비하는 공간, <br>
                                여러분과 공유합니다.</p>
                        </a> 
                    </div> 
                    
                    <div class="col-xs-12 col-sm-6 col-md-6 figure item grid-membership"> 
                        <a href="/membership" class="gridbox  text-center"> 
                            <span class="icon-stack"> 
                                <span class="icon-circle  icon-stack-base"></span> 
                                <span class="icon-group icon-light"></span> 
                            </span>
                            <h4>Membership</h4>
                            <p>큰 꿈을 지닌 이들이 함께 모여 창업을 준비할 수 있는 열린 공간과 되는 다양한 교육·행사 참여의 기회를 드립니다.</p>
                        </a> 
                    </div>
                    
                    <div class="col-xs-12 col-sm-6 col-md-6 figure item grid-news"> 
                        <a href="/?c=notice" class="gridbox  text-center"> 
                            <span class="icon-stack"> 
                                <span class="icon-circle  icon-stack-base"></span> 
                                <span class="icon-file-text-alt icon-light"></span> 
                            </span>
                             <h4>Notice</h4>
                             <span class="badge">{cnt_news}</span>개의 새로운 글 등록
                        </a> 
                    </div> 
                    
                    <div class="col-xs-12 col-sm-6 col-md-6 figure item grid-startup"> 
                        <a href="/?c=startup" class="gridbox  text-center"> 
                            <span class="icon-stack"> 
                                <span class="icon-circle icon-stack-base"></span> 
                                <span class="icon-building icon-light"></span> 
                            </span> 
                            <h4>Startup</h4>
                            <span class="badge">{cnt_st}</span>개의 스타트업 등록 
                        </a> 
                    </div>
                    
                    <div class="col-xs-12 col-sm-6 col-md-6 figure item grid-people"> 
                        <a href="/?c=people" class="gridbox  text-center"> 
                            <span class="icon-stack"> 
                                <span class="icon-circle icon-stack-base"></span> 
                                <span class="icon-smile icon-light"></span> 
                            </span>  
                            <h4>People</h4>
                            <span class="badge">{cnt_mem}</span>명이 등록 
                        </a> 
                    </div> 
                    
                    <div class="col-xs-12 col-sm-6 col-md-6 figure item grid-event"> 
                        <a href="/?c=event" class="gridbox  text-center"> 
                            <span class="icon-stack"> 
                                <span class="icon-circle icon-stack-base"></span> 
                                <span class="icon-gift icon-light"></span> 
                            </span>
                            <h4>Event</h4>
                            <span class="badge">{cnt_ev}</span>개의 이벤트 접수 중
                        </a> 
                    </div>
                    
                    <div class="col-xs-12 col-sm-6 col-md-6 figure item grid-recruit"> 
                        <a href="/?c=recruit" class="gridbox  text-center"> 
                            <span class="icon-stack"> 
                                <span class="icon-circle icon-stack-base"></span> 
                                <span class="icon-briefcase icon-light"></span> 
                            </span>
                            <h4>Recruit</h4>
                            <span class="badge">{cnt_rec}</span>개 채용정보 등록
                        </a> 
                    </div>
                
                </div>
                </div>
                <!-- /grid-right -->
                
            </div>
            <!-- /metroGrid --> 
        </div>
        <!-- /container --> 
    </div>
    <!-- /rowContent --> 
    
<script type="text/javascript">
//<![CDATA[
{? msg}
    alert('{msg}');
{/}
//]]>
</script>
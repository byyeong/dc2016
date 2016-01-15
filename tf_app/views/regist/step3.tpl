<!-- content -->
<div id="regist-member" class="content"> 
    <div class="row">
        <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-8 col-md-offset-2"> 
    
            <!-- header -->
            <div class="header">
                <h1><a href="/"><img src="/img/logo.png" alt="D.CAMP"></a> <small>회원가입</small></h1>
            </div>
            <!-- /header --> 
     
            <!-- panel -->
            <div class="panel panel-default">
                <div class="panel-body">
                    
                    <!-- guide-wrap -->
                    <div class="guide-wrap complete"> 
                        <h3 class="text-center"><span class="icon icon-smile"></span> 축하합니다.</h3>
                        <h4 class="text-center">D.CAMP 회원가입 신청이 완료되었습니다.</h4> 
                        
                        <!-- well -->
                        <div class="well">
                            <h4 class="complete-result"><span class="icon-ok"></span>&nbsp; 가입신청하신 회원 아이디는 <strong class="text-primary">{user.ids}</strong>입니다.</h4>
                            <ul>{? !is_f}
                                <li>입력한 메일 주소로 인증 메일이 발송되었습니다.</li>
                                <li>발송한 메일의 인증 링크를 클릭하면 회원가입이 완료됩니다.</li>
                                {/}
                                <li>가입하신 아이디/비밀번호 정보는 안전하게 보관됩니다.</li>
                            </ul>
                            {? user.utype == 1}
                            <div class="go-registStartup">
                                <p><span class="icon-caret-right"></span>&nbsp; 본인이 소속되어 있는 기업 정보를 연계하려면 아래의 [스타트업 연계하기]버튼을 눌러주세요.</p>
                                <div class="text-center"><a href="/regist/startup" class="btn btn-primary btn-sm">기업 연계하기</a></div>
                            </div>
                            {/}
                            {? user.utype == 2}
                            <div class="go-registStartup">
                                <p><span class="icon-caret-right"></span>&nbsp; 본인이 소속되어 있는 기업 정보를 연계하려면 아래의 [창업유관기관 연계하기]버튼을 눌러주세요.</p>
                                <div class="text-center"><a href="/regist/investment" class="btn btn-primary btn-sm">창업유관기관 연계하기</a></div>
                            </div>
                            {/}
                        </div>
                        <!-- /well -->
                    </div>
                    <!-- /guide-wrap -->
                    
                    <div class="text-center">
                        <a href="/" class="btn btn-default">홈으로</a>
                    </div>
                    
                </div>
                <!-- /panel-body --> 
            </div>
            <!-- /panel --> 
            
             
        </div>
    </div> 
</div>
<!-- /container-->
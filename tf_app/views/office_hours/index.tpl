    <!-- rowContent -->
    <div id="officehours" class="rowContent"> 
        <!-- page-header  
        <div class="page-header">
            <div class="container">
                <h2><a href="/office_hours">Office Hours</a></h2>
            </div>
        </div>
          /page-header -->

        <!-- page-content -->
        <div class="page-content"> 
            <div class="container"> 
                <!-- Start Contents -->

                    <div id="oh-about"> 
                        <div class="inner">
                            <div class="row">
                                <div class="col-xs-12 col-sm-6 col-md-5 col-lg-4 left">
                                    <img src="../images/logo_officehours.png" alt="Office Hours" class="img-responsive">
                                </div> 
                                <div class="col-xs-12 col-sm-6 col-md-7 col-lg-8 right">
                                     <h3>
                                        혼자 고민하고 계신가요? <br>더이상 혼자 고민하지 마세요! 
                                    </h3>
                                </div>
                                <div class="col-xs-12 col-sm-12 col-md-7 col-lg-8 right">
                                    <p>
                                        스타트업을 위한 수 많은 강연과, 네트워킹 프로그램, 수많은 사람들과 이야기를 나누어보았지만 여전히 명쾌하게 답을 찾을 수 없던 결정들.<br>
                                        창업자 여러분들의 고민을 좀 더 가까이에서 듣고, 함께 답을 찾기 위해 1:1 집중 상담 프로그램, Office Hours를 준비했습니다. <br>
                                        창업을 이미 하고 계시는 분, 구상하시는 분, 펀드레이징을 생각하시는 분 누구나 환영합니다.<br>
                                        이야기 나누고 싶은 주제와, 사업에 대한 간략한 설명을 준비하여 지금 바로 신청하세요.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="cardItems">
                        <div class="row">
                            {@ res}
                            {? .open}
                            <div class="vcard card col-xs-12 col-sm-4 col-md-3">
                                <div class="inner">
                                    <a href="{?.open}/office_hours/views/{.open}{:}/office_hours/mentor/{.id}{/}" {? !.open}style="cursor:default"{/}>
                                        <div class="vcardimg">
                                            <div class="thumb" style="background-image:url({.picture});">
                                                <img src="/images/img_trans.png" >
                                            </div>
                                            <div class="bgimg" data-href="{.picture}" data-sharpness="80"></div>
                                            <img src="{.picture}" class="sr-only">
                                        </div>
                                        <div class="caption">
                                            <h3>
                                                <strong class="field ellipsis">{.labeln}</strong>
                                                <strong class="name ellipsis">{.name}{? .position} {.position}{/}</strong>
                                                <small class="ellipsis">{.department}</small>
                                            </h3>
                                        </div>
                                        <div class="status">
                                            {?.open}
                                            {? !.me}
                                            <span class="label label-primary">접수 중</span>
                                            {:}
                                            <span class="label label-default">접수 완료</span>
                                            {/}
                                            {:}
                                            <span class="label label-success">접수 대기중</span>
                                            {/}
                                        </div>
                                    </a>

                                </div>
                            </div> 
                            <!-- /card -->
                            {/}
                            {/}
                            {@ res}
                            {? ! .open}
                            <div class="vcard card col-xs-12 col-sm-4 col-md-3">
                                <div class="inner">
                                    <a href="{?.open}/office_hours/views/{.open}{:}/office_hours/mentor/{.id}{/}" {? !.open}style="cursor:default"{/}>
                                        <div class="vcardimg">
                                            <div class="thumb" style="background-image:url({.picture});">
                                                <img src="/images/img_trans.png"  class="img-responsive">
                                            </div>
                                            <div class="bgimg" data-href="{.picture}" data-sharpness="80"></div>
                                        </div>
                                        <div class="caption">
                                            <h3>
                                                <strong class="field ellipsis">{.labeln}</strong>
                                                <strong class="name ellipsis">{.name}{? .position} {.position}{/}</strong>
                                                <small class="ellipsis">{.department}</small>
                                            </h3>
                                        </div>
                                        <div class="status">
                                            {?.open}
                                            {? !.me}
                                            <span class="label label-primary">접수 중</span>
                                            {:}
                                            <span class="label label-default">접수 완료</span>
                                            {/}
                                            {:}
                                            <span class="label label-success">접수 대기중</span>
                                            {/}
                                        </div>
                                    </a>

                                </div>
                            </div> 
                            <!-- /item -->
                            {/}
                            {/}
                        </div>
                    </div>


                <!-- /End Contents -->
            </div>
        </div>
        <!-- /page-content -->
    </div>
    <!-- /rowContent -->
    <script src="/js/jquery.ellipsis.js"></script>
    <script src="/js/jquery.blurr.js"></script>

    <script>
        $(document).ready(function() {
            $('.ellipsis').ellipsis({
                row: 1
            });
            $('.mulitple').ellipsis({
                row: 2
            });

            $('.bgimg').blurr();
        });
    </script>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>D.CAMP &#8211; &#039;드림뱅크&#039; 은행권청년창업재단</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    {? og}
    <meta property="og:type" content="{?og.type}{og.type}{:}website{/}"/>
    <meta property="og:url" content="{og.url}"/>
    <meta property="og:title" content="{og.title}"/>
    <meta property="og:description" content="{og.description}"/>
    {?og.image}<meta property="og:image" content="{og.image}"/>{/}
    <meta property="og:site_name" content="D.CAMP - 은행권청년창업재단이 운영하는 대한민국 최초의 복합 창업 생태계 허브"/>
    {/}
    <!-- stylesheet -->
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" >
    <link rel="stylesheet" href="/css/jquery.fullPage.css" >
    <link rel="stylesheet" href="/css/about.css" >

    <!--[if IE 7]>
    <link rel="stylesheet" href="/font-awesome/css/font-awesome-ie7.min.css">
    <![endif]-->


    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="/js/bootstrap.js"></script>
    <script src="/js/vendors/jquery.slimscroll.min.js"></script>
    <script src="/js/jquery.fullPage.js"></script>
    <script src="/js/jquery.flexslider.js"></script>


    <script type="text/javascript">
        $(document).ready(function() {
            $('#aboutDcamp').fullpage({
                anchors: ['Intro', 'About', 'Activity', 'Investment', 'Programs', 'Space', 'Press', 'Contact'],
                navigation: true,
                navigationPosition: 'right',
                navigationTooltips: ['Intro', 'About', 'Activity', 'Investment', 'Programs', 'Space', 'Press', 'Contact'],
                scrollOverflow: true
            });


            $('#progDesc').flexslider({
                animation: "slide",
                controlNav: false,
                animationLoop: false,
                slideshow: false,
                sync: "#progNav"
            });
            $('#progNav').flexslider({
                animation: "slide",
                //controlNav: false,
                //animationLoop: false,
                slideshow: false,
                itemWidth: 100,
                itemMargin: 0,
                asNavFor: '#progDesc'
            });


            $('#tmDesc').flexslider({
                animation: "slide",
                controlNav: false,
                animationLoop: true,
                slideshow: false,
                sync: "#tmThumb"
            });
            $('#tmThumb').flexslider({
                animation: "slide",
                controlNav: false,
                animationLoop: true,
                slideshow: false,
                itemWidth: 40,
                itemMargin: 5,
                asNavFor: '#tmDesc'
            });


            $('#spaceDesc').flexslider({
                animation: "slide",
                controlNav: false,
                animationLoop: true,
                slideshow: false,
                sync: "#spaceNav"
            });
            $('#spaceNav').flexslider({
                animation: "slide",
                controlNav: false,
                animationLoop: false,
                slideshow: false,
                itemWidth: 160,
                itemMargin: 0,
                asNavFor: '#spaceDesc'
            });

            $('.counter').each(function () {
                $(this).prop('Counter',0).animate({

                    Counter: $(this).text()
                }, {
                    duration: 4000,
                    easing: 'swing',
                    step: function (now) {
                        $(this).text(Math.ceil(now));
                    }
                });
            });

        });
    </script>



    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<body>

<div id="aboutDcamp">


<section class="section" id="intro">
    <div id="go-main" class="container-flud">
        <a href="http://dcamp.kr" target="_self"><span class="glyphicon glyphicon-arrow-left"> dcamp.kr</a>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-sm-10">
                <h1><img src="/images/about/dcamp-logo-big.png" alt="DCAMP"></h1>
                <h2>디캠프는 은행권청년창업재단이 운영하는<br> 대한민국 최초의 복합 창업 생태계 허브입니다.</h2>
                <div class="desc">
                    D.CAMP의 ‘D’는 ‘Dream’에서 따왔습니다. ‘Dynamic’, ‘Do it yourself’ 같은 의미도 있습니다. <br>
                    역동적이며, 신기술과 새 트렌드에 능동적이고, 자기주도적 삶을 사는 이들을 위한 베이스 캠프라는 뜻입니다. <br>
                    예비 창업자와 스타트업, 투자자, 각종 지원기관 등이 협업하고 교류하는 열린 터를 지향합니다.
                </div>
            </div>
        </div>
    </div>

</section>
<!-- /section -->



<section class="section" id="about">
    <div class="sector-content">
        <div class="container">
            <div class="row">

                <div class="col-sm-8 col-sm-offset-2">
                    <header class="sector-header">
                        <h2><img src="/images/about/logo_kor_full.png" srcset="/images/about/logo_kor_full@2x.png 2x" class="img-responsive" alt="D.CAMP : 은행권청년창업재단"></h2>
                    </header>
                    <article>
                        <p>
                            창업 생태계 활성화와 청년 일자리 창출을 위해 만들어진 비영리 재단입니다. 20개 전국은행연합회 회원 금융기관이 손잡고 2012년 5월 출범했습니다.
                        </p>
                        <p>
                            투자, 인프라 구축, 스타트업 육성 등 창업 열기 확산과 실질적 성과 도출을 위한 활동을 합니다. <br>
                            창업 생태계 허브 D.CAMP와 온라인 플랫폼 운영, 파트너 기관들과의 스타트업 인큐베이팅, 성장사다리펀드 출자, 전문 운용사와 함께 하는 간접 투자, 초기기업 매칭 투자 등이 주요 사업입니다.
                        </p>
                        <p>
                            이를 통해 은행권청년창업재단은 투자, 네트워크, 공간이라는 창업 생태계 3대 요소를 유기적으로 결합해 선순환을 유도하고 지속 가능한 지원 시스템을 확립하려 합니다. 나아가 아시아를 대표하는 창업 생태계 허브로 발돋움 하겠습니다.
                        </p>
                    </article>
                    <footer>
                        <a class="btn btn-default" href="../files/dcamp_korean_1511.pdf">브로슈어 보기</a>
                        <a class="btn btn-default" href="../files/dcamp_logo.zip">재단 CI 다운로드</a>
                    </footer>
                </div>

            </div>
        </div>
    </div>
</section>
<!-- /section -->



<section class="section" id="activity">
    <div class="intro-video">
        <div class="container">
            <div class="row">

                <div class="col-xs-12 col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2 ">
                    <div class="embed-responsive embed-responsive-16by9">
                        <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/-E9skUGjqw0" frameborder="0" allowfullscreen></iframe>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="real-status">
        <div class="container">
            <div class="row">
                <div class="item col-xs-4 col-sm-4 col-md-2">
                    <a href="http://dcamp.kr/network/people">
                        <dl>
                            <dt><img src="/images/about/ic-svg-members.svg">All Members</dt>
                            <dd><span class="counter">8475</span></dd>
                        </dl>
                </div>
                <div class="item col-xs-4 col-sm-4 col-md-2">
                    <a href="http://dcamp.kr/membership">
                        <dl>
                            <dt><img src="/images/about/ic-svg-vcard.svg">Join Membership</dt>
                            <dd><span class="counter">4192</span></dd>
                        </dl>
                    </a>
                </div>
                <div class="item col-xs-4 col-sm-4 col-md-2">
                    <a href="http://dcamp.kr/network/startup">
                        <dl>
                            <dt><img src="/images/about/ic-svg-briefcase.svg"> Startups</dt>
                            <dd><span class="counter">2314</span></dd>
                        </dl>
                    </a>
                </div>
                <div class="item col-xs-4 col-sm-4 col-md-2">
                    <a href="http://dcamp.kr/reservation">
                        <dl>
                            <dt><img src="/images/about/ic-svg-directions.svg"> Reservation</dt>
                            <dd><span class="counter">1857</span></dd>
                        </dl>
                    </a>
                </div>
                <div class="item col-xs-4 col-sm-4 col-md-2">
                    <a href="http://dcamp.kr/office_hours">
                        <dl>
                            <dt><img src="/images/about/ic-svg-clock.svg"> Office Hours</dt>
                            <dd><span class="counter">18</span></dd>
                        </dl>
                    </a>
                </div>
                <div class="item col-xs-4 col-sm-4 col-md-2">
                    <a href="http://dcamp.kr/challenge">
                        <dl>
                            <dt><img src="/images/about/ic-svg-trophy.svg"> Challenge</dt>
                            <dd><span class="counter">112</span></dd>
                        </dl>
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- /section -->



<section class="section" id="investment">
    <header class="sector-header">
        <div class="container">
            <h2>Investment</h2>
            <p>재단은 초기 창업 기업의 성장을 위한 다양한 투자 활동을 진행합니다.</p>

            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active"><a href="#direct" aria-controls="direct" role="tab" data-toggle="tab">초기 스타트업 직접투자</a></li>
                <li role="presentation"><a href="#indirect" aria-controls="indirect" role="tab" data-toggle="tab">간접투자</a></li>
                <li role="presentation"><a href="#status" aria-controls="status" role="tab" data-toggle="tab">투자 형태별 현황</a></li>
            </ul>
        </div>
    </header>
    <div class="sector-content">
        <div class="tab-content">
            <section role="tabpanel" class="tab-pane active" id="direct">
                <div class="container">

                    <header class="tab-heading">
                        <h3>초기 스타트업  직접투자</h3>
                    </header>
                    <div class="desc">
                        <p>
                            은행권청년창업재단은 2013년부터 창업 초기 스타트업을 대상으로 직접투자를 해오고 있습니다. <br>
                            재단이 직접 또는 파트너들과 공동으로 유망 스타트업을 발굴해 초기 자금을 제공합니다. 이에 더해 업무공간과 다양한 네트워크, 전문 멘토링 등 창업 성공을 위한 총체적 지원에 나서고 있습니다.  2013년부터 현재까지 재단은 총 38개 초기 스타트업에 투자하였습니다.
                        </p>
                    </div>

                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-6 left">
                            <section>
                                <header>
                                    <h4>재단 직접투자 분야별 현황</h4>
                                    <p>직접 및 초기자금 매칭 투자</p>
                                </header>
                                <div class="desc">
                                    <img class="img-responsive" src="/images/about/invest-illust-2.png">
                                </div>
                            </section>
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-6 right">
                            <section>
                                <header>
                                    <h4>재단 투자의 기대 효과</h4>
                                    <p>재단 투자유치를 통해 지속적인 성장 기반을 마련함으로 인해서 후속투자 유치 성공</p>
                                </header>
                                <div class="desc">
                                    <p>"재단 직접투자 포트폴리오 회사들의 후속투자유치 총 금액은 재단 총 투자금액의 12배"</p>
                                </div>

                                <header>
                                    <p>지속적인 성장 기반 마련</p>
                                </header>
                                <div class="desc row">
                                    <div class="col-xs-6">
                                        <blockquote>
                                            <p>
                                                디캠프의 투자는 초기에 받을 수 있는 엔젤 투자자로 최고였습니다. 디캠프의 네트워크를 통해 수많은 국내외
                                                파트너사들과 후혹 투자자들을 만날 수 있었습니다. 어려울 때 가장 먼저 생각나는 든든한 친구같습니다.
                                            </p>
                                            <footer>
                                                이효진 대표 <cite>8Percent (P2P 금융 서비스) </cite>
                                            </footer>
                                        </blockquote>
                                    </div>
                                    <div class="col-xs-6">
                                        <blockquote>
                                            <p>
                                                재단의 지원 프로그램을 순차적으로 거치면서 입주 및 투자를 지원받은 동시에 후속 투자까지 이끌어 내면서 초기 스타트업으로 안정적인 기반을 만들 수 있는 기회가 되었습니다.
                                            </p>
                                            <footer>
                                                문군 대표 <cite>멋집 (패션B2B 플랫폼 핫소스) </cite>
                                            </footer>
                                        </blockquote>
                                    </div>
                                </div>

                            </section>
                        </div>
                    </div>

                </div>
            </section>


            <section role="tabpanel" class="tab-pane" id="indirect">
                <div class="container">
                    <header  class="tab-heading">
                        <h3>간접 투자</h3>
                    </header>

                    <div class="row">

                        <div class="col-xs-12 col-sm-12 col-md-4 left">
                            <section>
                                <header>
                                    <h4>전략적 제휴를 위한 출자</h4>
                                </header>
                                <div class="desc">
                                    <p>효과적인 창업 지원을 위해 스타트업 전문 벤처캐피탈과의 전략적 제휴를 동반한 벤처캐피탈 대상 출자사업을 해오고 있습니다. 창업 초기기업을 대상으로 단순 자금지원을 넘어 경영 전반에 대한 효과적 인큐베이팅을 목표로 하고 있으며, 전문 투자자의 경험 및 노하우를 D.CAMP 회원들과 공유하고 네트워크를 확장하는 데에도 힘을 기울이고 있습니다.
                                    </p>
                                    <p>
                                        그 첫 시도로 2013년 9월, 한국 최초의 스타트업 전문 벤처캐피탈인 (주)본엔젤스벤처파트너스가 순수 민간자본으로 조성한 '페이스메이커펀드'에 출자하는 동시에 다양한 창업 지원책을 담은 전략적 제휴를 맺었습니다.
                                    </p>
                                    <p>
                                        재단은 페이스메이커펀드 출자를 포함하여 현재까지 총 5개의 초기투자전문 벤처캐피탈 펀드에 출자하였으며, 출자한 벤처캐피탈과 전략적 제휴체결을 통해 스타트업 생태계 조성에 기여하고 있습니다.
                                    </p>
                                </div>
                            </section>
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-4 right">
                            <section>
                                <header>
                                    <h4>'성장사다리펀드' 출연</h4>
                                </header>
                                <div class="desc">
                                    <p>
                                        은행권청년창업재단은 정부가 주도하는 '성장사다리펀드'사업에 3,500억원을 출연합니다. 2013년 8월 공식 출범한 성장사다리펀드는 건강하고 활기찬 벤처 생태계 조성을 목표로 합니다. '창업 → 성장 → 회수'에 이르는 기업 생애 주기에 있어 단계별 필요자금을 적정 시기에, 적정한 방법으로 제공하고자 합니다. 출범 첫 해 2조 원을 시작으로 3년간 총 6조 원 규모로 운영합니다. 재단은 전체 성장사다리펀드 중 특히 초기 기업을 대상으로 한 지원에 집중합니다. 이를 통해 자금수급 불균형 상황, 이른바 Death Valley에 처한 스타트업들에 힘이 되려 합니다.
                                    </p>
                                </div>
                            </section>
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-4 right">
                            <section>
                                <header>
                                    <h4>'분야별 창업지원펀드 조성</h4>
                                </header>
                                <div class="desc">
                                    <p>은행권청년창업재단은 특정 분야에 집중 투자하는 각기 다른 성격의 창업지원펀드들을 조성하였습니다. 이를 위해 총 375억 원 규모의 출자를 약정하였습니다. 2013년 11월 현재 각기 신기술, 지식재산, 문화콘텐츠 부문 투자를 전문으로 하는 3개 펀드가 출범했습니다.
                                    </p>
                                    <p>
                                        모두 장기 투자를 요하거나 성공 가능성이 상대적으로 낮아 투자가 활발하지 않은 분야입니다. 재단은 각 영역에서 한국을 대표하는 전문 투자사들과 함께 하며 다양한 성공사례를 만들어가고 있습니다.
                                    </p>
                                </div>
                            </section>
                        </div>
                    </div>


                </div>
            </section>

            <section role="tabpanel" class="tab-pane" id="status">
                <div class="container">
                    <header  class="tab-heading">
                        <h3>투자 형태별 현황</h3>
                    </header>

                    <section>
                        <div class="desc text-center">
                            <img src="/images/about/invest-illust-1.png"><br>
                            <small>(성장사다리펀드 제외)</small>
                        </div>
                    </section>

                </div>
            </section>

        </div>
    </div>
</section>
<!-- /section -->



<section class="section" id="program">
<header class="sector-header">
    <div class="container">
        <h2>Programs</h2>
        <p>한국 창업 생태계 활성화를 위해 D.DAY, D.TALKS, D.PARTY 등 다양한 형식의 이벤트와 프로그램을 진행합니다.</p>
    </div>
</header>
<div class="sector-content">

<!-- programSlider -->
<div id="progDesc" class="flexslider fullSlider">
    <ul class="slides">

        <li class="item" style="background-image: url(/images/about/program_d_day.jpg);">
            <section class="inner">
                <div class="container">
                    <div class="row">

                        <div class="col-xs-12 col-sm-4 left">
                            <header>
                                <h3>D.Day</h3>
                            </header>
                        </div>
                        <div class="col-xs-12 col-sm-8 right">
                            <div class="desc">
                                <p class="summary">매달 마지막 주 금요일 스타트업을 위한 데뷔 무대</p>
                                <p>
                                    스타트업이 투자자, 창업 선배 등 전문가 패널과 150여명의 청중 앞에서 제품이나 서비스를 선보입니다. <br>전문 투자자들의 값진 피드백과 함께 D.Angel을 통한 입주지원, 엔젤투자 등 초기 기업의 성장을 위한 다양한 혜택을 제공합니다. 본 행사 뒤에는 맛있는 음식을 즐기며 자유로운 네트워크 타임을 즐길 수 있습니다. 고객과 투자자를 만날 첫 무대가 필요하다면 D.DAY에 지원하세요.
                                </p>
                            </div>
                        </div>

                    </div>
                </div>
            </section>
        </li>
        <!-- /item -->
        <li class="item" style="background-image: url(/images/about/program_d_angel.jpg);">
            <section class="inner">
                <div class="container">
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 left">
                            <header>
                                <h3>D.ANGEL</h3>
                            </header>
                        </div>
                        <div class="col-xs-12 col-sm-8 right">
                            <div class="desc">
                                <p class="summary">D.CAMP의 입주 및 투자 기회를 제공하는 프로그램</p>
                                <p>
                                    D.DAY 발표기업을 대상으로 D.CAMP 내부심의가 통과된 팀은 D.ANGEL 프로그램에 참여할 수 있습니다. <br>D.ANGEL 프로그램 참여기업에 대해서 D.CAMP에 무상으로 3~6개월간의 입주 기회를 제공합니다. 입주기업에게는 D.PROGRAM 참여 우선권을 제공되며, D.CAMP 투자팀과 지속적인 Communication을 하게 됩니다. 이후 D.CAMP의 투자심의까지 통과한다면 D.CAMP로부터 5천만원 이하의 엔젤투자도 받게 됩니다.
                                <p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </li>
        <!-- /item -->
        <li class="item" style="background-image: url(/images/about/program_d_match.jpg);">
            <section class="inner">
                <div class="container">
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 left">
                            <header>
                                <h3>D.MATCH</h3>
                            </header>
                        </div>
                        <div class="col-xs-12 col-sm-8 right">
                            <div class="desc">
                                <p class="summary">스타트업들을 위한 오픈 리쿠르팅 프로젝트</p>
                                <p>
                                    스타트업이 겪는 가장 큰 어려움 중 하나가 구인입니다. 그 해소에 도움을 주기 위해 디캠프가 직접 인재와 스타트업을 연결합니다. 인턴 근무처를 찾는 대학생, 어리지만 뛰어난 역량을 지닌 특성화고 개발자, 외국어 역량이 뛰어난 인재들. 이들이 스타트업을 만나 소통하고 꿈을 키울 수 있는 기회를 마련합니다.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </li>
        <!-- /item -->
        <li class="item" style="background-image: url(/images/about/program_d_talk.jpg);">
            <section class="inner">
                <div class="container">
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 left">
                            <header>
                                <h3>D.TALKS</h3>
                            </header>
                        </div>
                        <div class="col-xs-12 col-sm-8 right">
                            <div class="desc">
                                <p class="summary">매주 목요일 저녁 상향식 멘토링 프로그램</p>
                                <p>
                                    꼭 조언을 듣고픈 선배 창업자가 있다면? 당면한 문제를 해결할 수 있는 실마리가 필요하다면? 회원 누구나 온라인 D.CAMP를 통해 원하는 멘토의 초청을 청원할 수 있습니다. 스타트업계 종사자들 및 창업자들과 다양한 전문가들의 만남을 통해 의미있는 정보 공유와 더불어 참가자들에게 좋은 변화를 만들어낼 수 있는 기회를 만드는 것을 목적으로 하고 있습니다.  맛있는 샌드위치와 음료도 제공합니다.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </li>
        <!-- /item -->
        <li class="item" style="background-image: url(/images/about/program_d_global.jpg);">
            <section class="inner">
                <div class="container">
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 left">
                            <header>
                                <h3>D.GLOBAL</h3>
                            </header>
                        </div>
                        <div class="col-xs-12 col-sm-8 right">
                            <div class="desc">
                                <p class="summary">스타트업 해외 진출 지원 프로그램</p>
                                <p>
                                    D.CAMP는 어느새 한국을 대표하는 창업 생태계 허브가 됐습니다. 해외 정부기관은 물론, 글로벌 투자자와 스타트업의 발길이 끊이지 않습니다. 글로벌 창업계의 정상회담격인 'Startup Nations Summit 2014' 도 성공적으로 개최했습니다. 우리 재단은 이렇게 쌓인 네크워크와 노하우를 창업계에 돌려드리고자 합니다. 세계 최대의 창조산업 컨퍼런스인 SXSW(South by Southwest) 참가를 비롯, TechCrunch 상하이, 베이징 등 해외로 뻗어갈 다양한 기회를 제공합니다.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </li>
        <!-- /item -->
        <li class="item" style="background-image: url(/images/about/program_d_party.jpg);">
            <section class="inner">
                <div class="container">
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 left">
                            <header>
                                <h3>D.PARTY</h3>
                            </header>
                        </div>
                        <div class="col-xs-12 col-sm-8 right">
                            <div class="desc">
                                <p class="summary">창업계 파트너와 함께하는 대표 네트워킹 행사</p>
                                <p>
                                    D.PARTY는 금융, 패션, 관광, 음악 등 다양한 분야를 주제로 매 월 개최하는 스타트업계의 버티컬 모임이자 파티입니다. 동종 산업에서 혁신을 위해 노력하는 창업자들이 인사이트를 나누고, 디파티를 통해 새로운 협력의 기회를 발견합니다.  <br>
                                    실제로 기업 간 다양한 투자 및 협력, M&A 사례들이 활발히 이루어지고 있습니다.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </li>
        <!-- /item -->
        <li class="item" style="background-image: url(/images/about/program_d_cision.jpg);">
            <section class="inner">
                <div class="container">
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 left">
                            <header>
                                <h3>D.CISION</h3>
                            </header>
                        </div>
                        <div class="col-xs-12 col-sm-8 right">
                            <div class="desc">
                                <p class="summary">본격적으로 창업을 고민중인 예비창업자를 위한 1박2일 워크숍</p>
                                <p>
                                    스스로의 창업DNA를 점검하고, 준비한 사업 모델도 되짚어 보는 한 편, 선배 기업가 및 투자자와 일대일 멘토링 시간을 가질 수 있습니다. 또한 동료 예비창업자들과의 심도 깊은 교류를 통해 성공 창업에 한발 더 다가갈 수 있는 기회가 될 것입니다.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </li>
        <!-- /item -->
        <li class="item" style="background-image: url(/images/about/program_officehours.jpg);">
            <section class="inner">
                <div class="container">
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 left">
                            <header>
                                <h3>OFFICE HOURS</h3>
                            </header>
                        </div>
                        <div class="col-xs-12 col-sm-8 right">
                            <div class="desc">
                                <p class="summary">스타트업을 위한 1:1 집중 상담 프로그램</p>
                                <p>
                                    수많은 강연, 네트워킹 프로그램, 뜨거운 술자리를 통해서도 명쾌하게 답을 찾을 수 없었던 결정들. 그 고민을 좀 더 가까이에서 듣고, 함께 답을 찾기 위한 1:1 상담 프로그램 입니다. 투자유치, 홍보, 법무, 개발, 디자인, 지적재산권, 업계동향 등 다양한 분야의 전문가들과 이야기 나눌수 있는 자리를 마련합니다.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </li>
        <!-- /item -->
    </ul>
</div>
<!-- /programSlider -->

<div class="fullnavSlider">
    <div class="container">
        <nav id="progNav" class="flexslider sliderNav">
            <ul class="slides">
                <li>
                    <span>D.DAY</span>
                </li>
                <li>
                    <span>D.ANGEL</span>
                </li>
                <li>
                    <span>D.MATCH</span>
                </li>
                <li>
                    <span>D.TALKS</span>
                </li>
                <li>
                    <span>D.GLOBAL</span>
                </li>
                <li>
                    <span>D.PARTY</span>
                </li>
                <li>
                    <span>D.CISION</span>
                </li>
                <li>
                    <span>OFFICE HOURS</span>
                </li>
            </ul>
        </nav>
    </div>
</div>

</div>
</section>
<!-- /section -->



<section class="section" id="space">
    <header class="sector-header">
        <div class="container">
            <h2>Space</h2>
            <p>여럿이 함께 모여 내일을 준비하는 공간, D.CAMP가 함께합니다</p>
        </div>
    </header>
    <div class="sector-content">

        <!-- spaceSlider -->
        <div id="spaceDesc" class="fullSlider">
            <ul class="slides">
                <li class="item" style="background-image: url(/images/about/space_floor_6.jpg);">
                    <section class="inner">
                        <div class="container">
                            <div class="row">

                                <div class="col-xs-12 col-sm-4 left">
                                    <header>
                                        <h3>다목적홀 (6F)</h3>
                                    </header>
                                </div>
                                <div class="col-xs-12 col-sm-8 right">
                                    <div class="desc">
                                        <p>
                                            다양하고 풍부한 네트워크 속에서 새로운 가치가 탄생합니다. 대한민국 창업 생태계를 꽃 피우고자 준비한 공간입니다.<br>
                                            선정릉의 환상적인 풍경이 내려다 보이는 멋진 테라스가 있습니다.
                                        </p>
                                        <dl>
                                            <dt>시설</dt>
                                            <dd>
                                                <ul>
                                                    <li>다목적 홀 (수용인원 : 150~200명)</li>
                                                    <li>케이터링 공간</li>
                                                    <li>회의실 2개 (수용인원 : 각 10명, 15명)</li>
                                                </ul>
                                            </dd>
                                        </dl>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </section>
                </li>
                <!-- /item -->
                <li class="item" style="background-image: url(/images/about/space_floor_5.jpg);">
                    <section class="inner">
                        <div class="container">
                            <div class="row">

                                <div class="col-xs-12 col-sm-4 left">
                                    <header>
                                        <h3>보육&세미나 공간 (5F)</h3>
                                    </header>
                                </div>
                                <div class="col-xs-12 col-sm-8 right">
                                    <div class="desc">
                                        <p>
                                            성공 가능성이 큰 스타트업들을 위한 입주 공간입니다. 제품과 서비스를 단시간에 업그레이드하기 위해 집중력을 발휘합니다. 지식과 경험을 공유할 수 있는 공간도 있습니다. 메일 새로운 프로그램을 진행합니다.
                                        </p>
                                        <dl>
                                            <dt>시설</dt>
                                            <dd>
                                                <ul>
                                                    <li>공용 사무실 2개 (수용인원 : 각 15명, 25명)</li>
                                                    <li>개별 사무실 7개 (수용인원 : 각 6~10명)</li>
                                                    <li>세미나 공간 1개 (수용인원 : 총 40명)</li>
                                                </ul>
                                            </dd>
                                        </dl>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </section>
                </li>
                <!-- /item -->
                <li class="item" style="background-image: url(/images/about/space_floor_4.jpg);">
                    <section class="inner">
                        <div class="container">
                            <div class="row">

                                <div class="col-xs-12 col-sm-4 left">
                                    <header>
                                        <h3>협업공간 (4F)</h3>
                                    </header>
                                </div>
                                <div class="col-xs-12 col-sm-8 right">
                                    <div class="desc">
                                        <p>
                                            여럿이 함께 모여 내일을 준비하는 국내 최대 co-working space 입니다. 열정 가득한 이들의 에너지를 몸으로 느낄 수 있습니다. 치열한 도전을 통해 꿈에 한 발 다가가세요.
                                        </p>
                                        <dl>
                                            <dt>시설</dt>
                                            <dd>
                                                <ul>
                                                    <li>협업 공간 (수용인원 : 80명)</li>
                                                    <li>모바일 테스트베드</li>
                                                    <li>그 외 라운지, 미팅룸, OA룸, 스마트 테이블 등</li>
                                                </ul>
                                            </dd>
                                        </dl>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </section>
                </li>
                <!-- /item -->
                <li class="item" style="background-image: url(/images/about/space_floor_2.jpg);">
                    <section class="inner">
                        <div class="container">
                            <div class="row">

                                <div class="col-xs-12 col-sm-4 left">
                                    <header>
                                        <h3>라운지와 비즈니스 센터 (2F)</h3>
                                    </header>
                                </div>
                                <div class="col-xs-12 col-sm-8 right">
                                    <div class="desc">
                                        <p>
                                            창업계 사람이라면 누구나 음료와 스낵을 즐기며 만나고 일할 수 있는 라운지입니다. 글로벌 투자자와 스타트업, 창업자들이 D.CAMP의 강력한 네트워크와 시너지를 창출할 수 있는 비즈니스 센터도 여러분을 기다립니다.
                                        </p>
                                        <dl>
                                            <dt>시설</dt>
                                            <dd>
                                                <ul>
                                                    <li>라운지 & 카페테리아</li>
                                                    <li>유료 개별 사무실 6개 (수용인원 : 각 4~5명, 12명 )</li>
                                                    <li>유료 1인용 공간 (수용인원 : 19명)</li>
                                                    <li>회의실 1개 (수용인원: 8명)</li>
                                                </ul>
                                            </dd>
                                        </dl>

                                        <div id="doffice">
                                            <h4>비즈니스 센터 'D.OFFICE'</h4>
                                            <p>
                                                그간 D.CAMP에는 '이 곳에 사무실을 열고 싶다", "아시아 시장 진출의 거점으로 사용할 수 있는 공간을 만들어 달라"는 요청이 끊이지 않았습니다. 특히 글로벌 투자자와 스타트업들, 국내 창업지원 기관들의 관심이 높았습니다. 그래서 마련한 것이 D.OFFICE입니다.  D.OFFICE에는 4~12인 규모의 사무실 6개와 1인용 공간 19개가 있습니다. 넉넉한 회의실, 쾌적한 라운지, 자유로운 OA 기기 사용, 컨퍼런스 콜 및 프레젠테이션 시설, D.CAMP의 막강 네트워크까지, 다른 곳에서는 접하기 힘든 서비스와 인프라를 제공합니다.    지금 사무실을 구하고 있다면, 해외 파트너 방한 중 업무공간이 필요하다면 D.CAMP의 문을 두드리세요.
                                            </p>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </section>
                </li>
                <!-- /item -->
            </ul>
        </div>
        <!-- /spaceSlider -->

        <div class="fullnavSlider ">
            <div class="container">
                <nav id="spaceNav" class="sliderNav">
                    <ul class="slides">
                        <li>
                            <span>다목적 홀 (6F)</span>
                        </li>
                        <li>
                            <span>보육&세미나 공간 (5F)</span>
                        </li>
                        <li>
                            <span>협업공간 (4F)</span>
                        </li>
                        <li>
                            <span>라운지와 비즈니스 센터 (2F)</span>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>

    </div>
</section>
<!-- /section -->


<!--
        <section class="section" id="team">
            <header class="sector-header">
                <div class="container">
                    <h2>Team</h2>
                    <p>D.CAMP의 다양한 지원을 담당하고 있습니다</p>
                </div>
            </header>

            <div id="tmDesc" class="teamSlider">
                <ul class="slides">
                    <li>
                        <div class="container">
                            <div class="media">
                                <div class="media-left">
                                    <img class="media-object" src="../images/img_default.png">
                                </div>
                                <div class="media-body">
                                    <h3 class="media-heading">팀멤버 이름 <small>직급또는담당업무</small></h3>
                                    <div class="desc">
                                    같이, 꽃 못할 것은 예가 어디 쓸쓸하랴? 낙원을 것이다.보라, 위하여, 있음으로써 풀이 속에서 것은 어디 부패뿐이다. 인도하겠다는 바로 품에 것이다. 발휘하기 때까지 불어 것이 천고에 철환하였는가 것은 낙원을 약동하다. 더운지라 하였으며, 청춘의 칼이다. 있는 무한한 인류의 이상 미인을 사라지지 심장의 이것이다. 얼마나 싹이 기쁘며, 끝에 풍부하게 보라. 희망의 청춘의 예수는 영원히 목숨이 이상의 사막이다. 피어나기 할지라도 아니더면, 위하여서. 그들은 얼음 청춘의 영원히 수 얼음에 수 아름다우냐? 얼마나 같은 보이는 그러므로 칼이다. 대고, 뭇 청춘은 용감하고 말이다.
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="container">
                            <div class="media">
                                <div class="media-left">
                                    <img class="media-object" src="../images/img_default.png">
                                </div>
                                <div class="media-body">
                                    <h3 class="media-heading">팀멤버 이름 <small>직급또는담당업무</small></h3>
                                    <div class="desc">
                                    같이, 꽃 못할 것은 예가 어디 쓸쓸하랴? 낙원을 것이다.보라, 위하여, 있음으로써 풀이 속에서 것은 어디 부패뿐이다. 인도하겠다는 바로 품에 것이다. 발휘하기 때까지 불어 것이 천고에 철환하였는가 것은 낙원을 약동하다. 더운지라 하였으며, 청춘의 칼이다. 있는 무한한 인류의 이상 미인을 사라지지 심장의 이것이다. 얼마나 싹이 기쁘며, 끝에 풍부하게 보라. 희망의 청춘의 예수는 영원히 목숨이 이상의 사막이다. 피어나기 할지라도 아니더면, 위하여서. 그들은 얼음 청춘의 영원히 수 얼음에 수 아름다우냐? 얼마나 같은 보이는 그러므로 칼이다. 대고, 뭇 청춘은 용감하고 말이다.
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>

            <div class="container">
                <div id="tmThumb" class="teamSlider">
                    <ul class="slides">
                        <li>
                            <img src="../images/img_default.png" />
                        </li>
                        <li>
                            <img src="../images/img_default.png" />
                        </li>
                    </ul>
                </div>
            </div>
        </section>
  /section -->


<section class="section" id="press">
    <header class="sector-header">
        <div class="container">
            <h2>PRESS</h2>
        </div>
    </header>
    <div class="sector-content">
        <div class="container">
            <div class="row">
                <div class="col-sm-8 col-sm-offset-2">

                    <ul class="press-list">
                        { @ res }
                        <li>
                            { .sub } <small>/ { .date_created }</small>
                        </li>
                        { / }
                    </ul>
                    <nav>
                        <ul class="pager">
                            <li><a href="#">Previous</a></li>
                            <li><a href="#">Next</a></li>
                        </ul>
                    </nav>

                </div>
            </div>
        </div>
    </div>
</section>
<!-- /section -->



<section class="section" id="contact">
    <header class="sector-header">
        <div class="container">
            <h2>Contact</h2>
        </div>
    </header>
    <div class="sector-content">
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-8 col-sm-offset-2">

                    <dl class="dl-horizontal">
                        <dt>주소</dt>
                        <dd>서울시 강남구 역삼동 683-34 새롬빌딩 2,4,5,6층</dd>
                    </dl>
                    <dl class="dl-horizontal">
                        <dt>지하철</dt>
                        <dd>분당선 선정릉역 4번 출구에서 선릉역 방향으로 도보 3분 / 2호선 선릉역 7번 출구에서 도보 5분</dd>
                    </dl>
                    <dl class="dl-horizontal">
                        <dt>버스 정류장</dt>
                        <dd>무형문화재전수회관, 시니어플라자 | 23-257</dd>
                    </dl>
                    <dl class="dl-horizontal">
                        <dt>경유노선</dt>
                        <dd>475번, 3219번, 4413번, 마을버스 강남 07번 </dd>
                    </dl>

                </div>
            </div>
        </div>


        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d12660.002475070765!2d127.04505378465572!3d37.50790355658019!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca4092dfbb341%3A0x1def741afd8a1b43!2z7ISc7Jq47Yq567OE7IucIOqwleuCqOq1rCDsl63sgrzrj5kgNjgzLTM0!5e0!3m2!1sko!2skr!4v1444118631954" width="100%" height="360" frameborder="0" style="border:0" allowfullscreen></iframe>


    </div>
</section>
<!-- /section -->

</div>

</body>
</html>

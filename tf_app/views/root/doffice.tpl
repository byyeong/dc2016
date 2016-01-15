<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1, width=device-width, maximum-scale=1, minimum-scale=1, user-scalable=no">
    <title>D.Office</title>
    <meta name="title" content="D.Office" />
    <meta name="Description" content="D.Office - Get connected in Gangnam" />
    <meta property="og:url" content="http://www.dcamp.kr/doffice" />
    <meta property="og:image" content="//images/doffice/doffice/doffice.png" />
    <meta property="og:type" content="website" />
    <meta property="og:site_name" content="D.Office" />
    <link itemprop="url" href="http://www.dcamp.kr/doffice" />
    <link rel="home" href="http://www.dcamp.kr/" />
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,700' rel='stylesheet' type='text/css'>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <script type="text/javascript" src="/js/doffice/jquery.onepage-scroll.js"></script>
    <link href='/css/doffice/onepage-scroll.css' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="/css/doffice/style.css">
    <style type="text/css"></style>
</head>
<body>
<div class="wrapper">
<div class="main">
<!-- intro -->
<section id="intro" class="doffice-intro">
    <div class="intro-container">
        <div class="video-container">
            <video autoplay="autoplay" id="introVideo" loop="loop" muted="muted" poster="/images/doffice/bg-top.jpg" src="/video/video-doffice.mp4"></video>
        </div>
        <div class="title-box">
            <p class="lead">SPACE · COMMUNITY · EVENTS</p>
            <h1><span>D</span>.CAMP</h1>
            <h2 class="title-rotate">GET<br>
                <span>LAUNCHED</span>
                <br>IN GANGNAM</h2>
            <a href="#bookTour" class="moveToBookTour"><button class="btn-submit">BECOME A MEMBER</button></a>
        </div>
    </div>
</section>
<!-- company -->
<section id="company" class="company">
    <div class="company-container">
        <div class="title-box">
            <h2>THEY JUST CAME</h2><br>
            <p>Some of the companies that built their first Korean office at D.CAMP</p>
        </div>
        <div class="logo-box">
            <ul>
                <li><a href="http://supercell.com/en/" target="_blank"><img src="/images/doffice/logo_12.png" alt="SUPERCELL"></a></li>
                <li><a href="https://www.uber.com/" target="_blank"><img src="/images/doffice/logo_07.png" alt="uber"></a></li>
                <li><a href="https://www.oculus.com/en-us/" target="_blank"><img src="/images/doffice/logo_09.png" alt="oculus"></a></li>
                <li><a href="http://formation8.com/" target="_blank"><img src="/images/doffice/logo_23.png" alt="formation8"></a></li>
                <li><a href="http://vungle.com/" target="_blank"><img src="/images/doffice/logo_20.png" alt="vungle"></a></li>
                <li><a href="http://www.septeni.co.jp/en/" target="_blank"><img src="/images/doffice/logo_18.png" alt="septeni"></a></li>
            </ul>
        </div>
    </div>
</section>
<!-- space option -->
<section id="spaceOption" class="space-option">
    <div class="space-container">
        <div class="title-box">
            <h2>SPACE OPTIONS</h2>
        </div>
        <div class="option-box">
            <ul>
                <li id='deskOption'>
                    <a href="#deskInfo" class="link-box moveToDeskInfo">
                        <div class="text-box">
                            <h3>DEDICATED DESK</h3><br>
                            <p>
                                <span class="lead">APPROX.</span><br>
                                <span class="text-price">$250</span>
                                <span class="lead">/MONTH</span>
                            </p>
                            <span class="info-text">Own desk in a shared work space of 19 seats,<br>surrounded by inspiring individuals</span>
                        </div>
                    </a>
                </li>
                <li id='officeOption'>
                    <a href="#officeInfo" class="link-box moveToOfficeInfo">
                        <div class="text-box">
                            <h3>PRIVATE OFFICE</h3><br>
                            <p>
                                <span class="lead">FROM</span><br>
                                <span class="text-price">$1,300</span>
                                <span class="lead">/MONTH</span>
                            </p>
                            <span class="info-text">Grow your business in a private office<br>for teams of all sizes up to 20</span>
                        </div>
                    </a>
                </li>
            </ul>
            <a href="#deskInfo" class="btn-area moveToDeskInfo"><button type="submit" class="btn-learn">Learn More</button></a>
        </div>
    </div>
    <div class="overlay-box"></div>

</section>
<!-- desk info -->
<section id="deskInfo" class="desk-info">
    <!-- price info -->
    <div class="info-header">
        <div class="wrap-header">
            <p>
                <span class="title">DEDICATED DESK</span>
                <span class="lead">&#8212;&nbsp;&nbsp;APPROX.</span>
                <span class="text-price">$250</span>
                <span class="lead">/MONTH</span>
                <a href="#;" class="moveToBookTour"><button type="submit" class="btn-submit">Book a Tour</button></a>
            </p>
        </div>
    </div>
    <!-- Carousel -->
    <div id="deskCarousel" class="carousel slide" data-ride="carousel">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <li data-target="#deskCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#deskCarousel" data-slide-to="1"></li>
            <li data-target="#deskCarousel" data-slide-to="2"></li>
            <li data-target="#deskCarousel" data-slide-to="3"></li>
        </ol>
        <!-- Wrapper for slides -->
        <div class="carousel-inner" role="listbox">
            <div class="item bg bg1 active"></div>
            <div class="item bg bg2"></div>
            <div class="item bg bg3"></div>
            <div class="item bg bg4"></div>
        </div>
        <!-- Left and right controls -->
        <a class="left carousel-control" href="#deskCarousel" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#deskCarousel" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
</section>
<!-- office info -->
<section id="officeInfo" class="office-info">
    <!-- price info -->
    <div class="info-header">
        <div class="wrap-header">
            <p>
                <span class="title">PRIVATE OFFICE</span>
                <span class="lead">&#8212;&nbsp;&nbsp;FROM</span>
                <span class="text-price">$1,300</span>
                <span class="lead">/MONTH</span>
                <a href="#;" class="moveToBookTour"><button type="submit" class="btn-submit">Book a Tour</button></a>
            </p>
        </div>
    </div>
    <!-- Carousel -->
    <div id="officeCarousel" class="carousel slide" data-ride="carousel">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <li data-target="#officeCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#officeCarousel" data-slide-to="1"></li>
            <li data-target="#officeCarousel" data-slide-to="2"></li>
            <li data-target="#officeCarousel" data-slide-to="3"></li>
        </ol>

        <!-- Wrapper for slides -->
        <div class="carousel-inner" role="listbox">
            <div class="item bg bg1 active"></div>
            <div class="item bg bg2"></div>
            <div class="item bg bg3"></div>
            <div class="item bg bg4"></div>
        </div>
        <!-- Left and right controls -->
        <a class="left carousel-control" href="#officeCarousel" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#officeCarousel" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
</section>
<!-- membership -->
<section id="membership" class="membership">
    <div class="membership-box">
        <ul class="membership-list">
            <li class="hover-text-box">
                <div class="bg-workspace"></div>
                <div class="wrap-hover-text-box">
                    <h3>WORKSPACE</h3>
                    <div class="hidden-box">
                        <ul class="including-list">
                            <li>24/7 fingerprint access to a dedicated desk or private office for teams of 1~20.</li>
                            <li>Fully connected with TVs, wireless screen projection, speakerphones, and whiteboards</li>
                            <li>On demand access to conference rooms of all sizes; perfect for 1:1 interviews, small group sessions, and even larger board meetings</li>
                        </ul>
                    </div>
                </div>
            </li>
            <li class="quote-box">
                <p>
                    <img src="/images/doffice/s_logo_supercell.png" alt="logo_supercell"><br>
                    I couldn't imagine a better place for anybody in IT to network. The facilities, staff, and environment at D.CAMP are all top-notch.<br>
                    <span>Jack Liu, Supercell Korea</span>
                </p>
            </li>
            <li class="hover-text-box">
                <div class="bg-network"></div>
                <div class="wrap-hover-text-box">
                    <h3>NETWORK &amp; COMMUNITY</h3>
                    <div class="hidden-box">
                        <ul class="including-list">
                            <li>Connect and collaborate with D.CAMP members across industries</li>
                            <li>Promote your services and find new clients</li>
                            <li>Discounts on meaningful services such as web hosting, gym memberships, travel, and more.</li>
                        </ul>
                    </div>
                </div>
            </li>
            <li class="quote-box">
                <p>
                    <img src="/images/doffice/s_logo_500.png" alt="logo_500"><br>
                    What does it mean to join D.CAMP? I don't spend time on the road anymore to meet VCs and clients. They just come.<br>
                    <span>500 Videos Team</span></p>
            </li>
            <li class="hover-text-box">
                <div class="bg-event"></div>
                <div class="wrap-hover-text-box">
                    <h3>EVENTS</h3>
                    <div class="hidden-box">
                        <ul class="including-list">
                            <li>Learn, network, and get inspired at intimate and large scale events and parties</li>
                            <li>office hours with industry professionals</li>
                            <li>Educational workshops</li>
                        </ul>
                    </div>
                </div>
            </li>
            <li class="quote-box">
                <p>
                    <img src="/images/doffice/s_logo_septeni.png" alt="logo_septeni"><br>
                    People you meet here at D.CAMP are the best players in Korea. <br>D.Office is more than just an office.<br>
                    <span>SeigoMayumi, Head of Korea, SepteniAmefica, Inc.</span></p>
            </li>
        </ul>
    </div>
</section>
<!-- amenity -->
<section id="amenity" class="amenity">
    <div class="amenity-container">
        <div class="title-box">
            <h2>AMENITIES</h2>
        </div>
        <div class="amenity-box">
            <ul>
                <li><img src="/images/doffice/icon-2x-wh_03.png" alt="Secure"><h4>24/7 Secure<br>Fingerprint Access</h4></li>
                <li><img src="/images/doffice/icon-2x-wh_05.png" alt="Wifi"><h4>Free Broadband<br>Wifi</h4></li>
                <li><img src="/images/doffice/icon-2x-wh_07.png" alt="Address"><h4>Address for<br>Business<br>Registration</h4></li>
                <li><img src="/images/doffice/icon-2x-wh_09.png" alt="Mail"><h4>Mail Handling<br>Service</h4></li>
                <li><img src="/images/doffice/icon-2x-wh_11.png" alt="Printing"><h4>Printing Service</h4></li>
            </ul>
        </div>
    </div>
</section>
<!-- communityTeam -->
<section id="communityTeam" class="community-team">
    <div class="community-container">
        <div class="title-box">
            <h2>COMMUNITY TEAM</h2>
        </div>
        <div class="team-box">
            <ul>
                <li><img src="/images/doffice/team-2.png" alt="Sungjun Ji">
                    <h3>Sungjun Ji</h3>
                    <div class="sns-box">
                        {*<a href="#"><img src="/images/doffice/icon_facebook.png" alt="icon-facebook"></a>*}
                        <a href="http://linkedin.com/in/sungjun" target="_blank "><img src="/images/doffice/icon_lkin.png" alt="icon-twitter"></a>
                        {*<a href="linkedin.com/in/sungjun"><img src="/images/doffice/icon_twt.png" alt="icon-Linkedin"></a>*}
                    </div>
                </li>
                <li><img src="/images/doffice/team-1.png" alt="Siwoo Choi">
                    <h3>Siwoo Choi</h3>
                    <div class="sns-box">
                        <a href="https://www.facebook.com/profile.php?id=100002230707088" target="_blank"><img src="/images/doffice/icon_facebook.png" alt="icon-facebook"></a>
                        {*<a href="#"><img src="/images/doffice/icon_lkin.png" alt="icon-twitter"></a>
                        <a href="#"><img src="/images/doffice/icon_twt.png" alt="icon-Linkedin"></a>*}
                    </div>
                </li>

            </ul>
        </div>
    </div>
</section>
<!-- location -->
<section id="location" class="location">
    <div class="title-box">
        <div class="wrap-title">
            <h2>OUR LOCATION</h2>
            <br><p>D.CAMP 2nd Floor, Saerom Building, 551 Seolleung-ro, Gangnam-gu, Seoul, South Korea</p>
        </div>
    </div>
    <div class="googlemap">
        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d12660.021886426552!2d127.0453474!3d37.507789100000004!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca4092d38fe1b%3A0xa6001f7e29217d9e!2s551+Seolleung-ro%2C+Gangnam-gu%2C+Seoul!5e0!3m2!1sen!2skr!4v1441281422022" width="800" height="600" frameborder="0" style="border:0" allowfullscreen></iframe>
    </div>
</section>
<!-- book-a-tour -->
<section id="bookTour" class="book-a-tour">
    <div class="book-container">
        <div class="title-box">
            <h2>BOOK A TOUR</h2>
            <p>Personalized &amp; dedicated space for teams of 1~20 starting at $250 per month.</p>
        </div>
        <form name="book_a_tour" role="form" class="form-book">
            <div class="form-group form-group-lg">
                <input type="name" name="name" class="form-control" id="name" placeholder="Full Name" required="required">
            </div>
            <div class="form-group form-group-lg">
                <input type="email" name="email" class="form-control" id="email" placeholder="Business Email" required="required">
            </div>
            <div class="form-group form-group-lg">
                <input type="phone" name="phone" class="form-control" id="phone" placeholder="Phone" required="required">
            </div>
            <div class="form-group form-group-lg">
                <input type="needs" name="needs" class="form-control" id="needs" placeholder="Business Needs" required="required">
            </div>
            <button type="submit" class="btn-submit book_a_tour_submit_button">Submit</button>
        </form>
    </div>
    <div class="overlay-box"></div>
</section>
</div>
</div>

<script>
    $(document).ready(function(){
        $(".main").onepage_scroll({
            sectionContainer: "section",
            responsiveFallback: 767,
            loop: true,
            afterMove : function(index){
                if(index==2){
                    var listNum = 0;
                    $("#company .logo-box > ul > li img").each(function(index) {

                        $(this).addClass('logo_visible');
                        var delay = (0.1 * (index+1)) + 0.3;
                        $(this).css('transition-delay', delay + 's');
                    });
                }

                else{
                    $("#company .logo-box > ul > li img").removeClass("logo_visible");
                }
            }
        });
    });
    $(document).ready(function(){
        $(".moveToBookTour").click(function(event){
            event.preventDefault();
            $(".main").moveTo(10);
        });

        $(".moveToDeskInfo").click(function(event){
            event.preventDefault();
            $(".main").moveTo(4);
        });

        $(".moveToOfficeInfo").click(function(event){
            event.preventDefault();
            $(".main").moveTo(5);
        });

        $("form[name=book_a_tour]").submit(function(event){
            event.preventDefault();

            var get_url = '/ajax_front/doffice_send_mail/';
            var frm = $('form[name=book_a_tour]');
            var set_data = frm.serialize();
            if(
                $('input[name=name]').length > 0 &&
                $('input[name=email]').length > 0 &&
                $('input[name=phone]').length > 0 &&
                $('input[name=needs]').length > 0
                ){
                $(".book_a_tour_submit_button").prop("disable", true);
                $.ajax({
                    type : 'POST',
                    url : get_url,
                    data : set_data,
                    dataType : 'html',
                    success : function(_data) {
                        $(".main").moveTo(1);
                        $(".book_a_tour_submit_button").prop("disable", false);
                        $("input").val("");
                    }
                });
            }

            /**/
        });
    });

</script>
</body>
</html>
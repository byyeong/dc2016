<!-- rowContent -->
    <div class="rowContent" id="people">
        <div class="page-header">
            <div class="container">
                <h2><a href="/network/people">People</a> <small> 투자자/창업지원 유관기관</small></h2>
            </div>
        </div>
        
        <!-- page-content -->
        <div class="page-content">
            <div class="container">
                <div class="row">
                    <input type="hidden" id="page" value="{page}" />
                    <div class="col-xs-12 col-sm-12 col-md-9 content">
                        <div class="row">
                            {@ res}
                            <div class="vcard card col-xs-12 col-sm-4 col-md-4"> 
                                <div class="inner"> 
                                    <a href="/startup/{.id}">
                                    <div class="vcardimg">
                                        <div class="logo" style="background-image:url({.logo});">
                                            <img src="/img/trans.png">
                                        </div>
                                        <div class="bgimg" data-href="{.logo}" data-sharpness="80"></div>
                                    </div>
                                    <div class="caption"> 
                                        <h3 class="ellipsis">{.name}</h3> 
                                        <p class="mulitple">{=htmlspecialchars(.bio)}</p>
                                    </div> 
                                    </a>
                                </div>
                            </div>
                            <!-- /item -->
                            {/}
                        </div>
                    </div>
                    <!-- /content -->
                    
                    <div class="col-xs-12 col-sm-12 col-md-3 sidebar">
                        <div class="panel category">
                            <h3 class="panel-title">업무분야별 보기</h3>
                            <ul class="list-unstyled">
                                {@ inv}
                                {? .id == 1406}
                                <li><a href="/network/suporter">투자자/창업지원 유관기관</a> <span class="badge">({ucnt})</span></li>
                                <li>{?.cnt}<a href="/network/people/1/{.id}">{._value}</a>{:}{._value}{/} <span class="badge">({.cnt})</span></li>
                                {:}
                                <li>{?.cnt}<a href="/network/people/1/{.id}">{._value}</a>{:}{._value}{/} <span class="badge">({.cnt})</span></li>
                                {/}
                                {/}
                            </ul>
                        </div>
                    </div>
                    <!-- /sidebar -->
                </div>
            </div>
        </div>
        <!-- /page-content --> 
        
    </div>
    <!-- /rowContent --> 

<script src="/js/jquery.blurr.js"></script>
<script>
//<![CDAT
$(document).ready(function() { 
    $('.bgimg').blurr(); 
});

$(window).scroll(function(){
    if ($(window).scrollTop() === $(document).height() - $(window).height()){
            var v = $("#page").val();
            if (v) {
                
                var next = parseInt(v)+1;
                $('#page').val(next);
                var get_url = '/ajax_front/more_network/'+ next + "/{c}/{c_inv}";

                $.ajax({
                    type : 'GET',
                    url : get_url,
                    dataType : 'html',
                    success : function(_data) {

                        if (_data) {

                            $('.content .row').append(_data);                            

                            $('.ellipsis').ellipsis({
                                row: 1
                            }); 
                            $('.mulitple').ellipsis({
                                row: 2
                            }); 

                            $('.bgimg').blurr();
                        }
                        else {
                            alert('마지막 페이지 입니다.');
                            $('#page').val('');
                        }
                    }
                });
            }
                
    }
});
//]]>
</script>
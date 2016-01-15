
            <div class="main">    
                <div class="row">
                    <!--  #content -->
                    <div id="contents" class="col-xs-12 col-sm-12 col-md-8">

                        <form id="timeline-form" role="form" method="post" name="p_form" onsubmit="submit_p_form('{res.id}', '{s.fb.public}'); return false">
                            <div id="event-summary">
                                <h3><a href="/event/apply/{res.id}">{res.title}</a></h3> 
                                <div class="pull-left">
                                {?res.date}{res.date} ({=date_to_day_only(res.date)}) {? res.start}{res.start}{/}{/} {?res.date_e}~ {res.date_e} ({=date_to_day_only(res.date_e)}) {? res.end}{res.end}{/}{/}<br>
                                {? res.space_etc || res.space_id > 0}
                                {? res.space_id == 0}{res.space_etc}{:}{res.opt}F {=explode_ext(res.sname, '(')}{/}
                                {/}
                                </div>
                                <a href="/event/apply/{res.id}" class="btn btn-default pull-right" target="_blank">자세히 보기</a> 
                                <div class="clearfix"></div>   
                            </div>
                        
                            <fieldset>
                                <legend class="sr-only">
                                    타임라인 쓰기
                                </legend>
                                <div class="media media-form">
                                    <a href="#" class="pull-left media-object">
                                        <img src="{? s}{s.picture}{:}/img/default-img-member.png{/}" alt="{s.name}" class="avatar img-circle">
                                    </a>
                                    <div class="media-body">
                                        <div class="row">
                                            <div class="form-group col-xs-12 col-sm-10 col-md-10 left">    
                                                {? !s}
                                                <label class="sr-only">행사에 대한 질문이나 의견을 남기기 위해서 로그인이 필요합니다.</label>
                                                <textarea rows="4" class="form-control" placeholder="행사에 대한 질문이나 의견을 남기기 위해서 로그인이 필요합니다." name="cont" disabled></textarea>
                                                {:}
                                                {? datetimeDiff(res.date_e, res.end, date('y.m.d H:i'), '.') < 0}                                
                                                <label class="sr-only">행사 어떠셨나요? 만족도와 후기를 남겨주세요.</label>
                                                <textarea rows="4" class="form-control" placeholder="행사 어떠셨나요? 만족도와 후기를 남겨주세요." name="cont"></textarea>
                                                {:}
                                                <label class="sr-only">행사에 대한 질문이나 의견을 남겨주세요.</label>
                                                <textarea rows="4" class="form-control" placeholder="행사에 대한 질문이나 의견을 남겨주세요." name="cont"></textarea>
                                                {/}
                                                {/}
                                            </div>

                                            <div class="form-group col-xs-12 col-sm-2 col-md-2 right">                                    
                                                <label for="inputPic" title="이미지 업로드" data-toggle="tooltip">
                                                    <img class="img-thumbnail img-responsive" src="/img/default-img-pic.png">
                                                    <input type="file" style="display: none;" id="inputPic" onchange="img_up(this); return false;">
                                                </label>
                                            </div>
                                        </div>

                                        <div class="form-group form-submit"> 
                                            <label class="checkbox-inline" >
                                              <input type="checkbox" data-toggle="checkbox" name="fb" value="1" {? ! fb}disabled="disabled"{:}checked="checked"{/}>
                                              Facebook
                                            </label>
                                            <label class="checkbox-inline">
                                              <input type="checkbox" data-toggle="checkbox" checked="checked" name="tw" value="1" {? ! fb}disabled="disabled"{:}checked="checked"{/}>
                                              Twitter
                                            </label>
                                            &nbsp;&nbsp;
                                            {? s.id}
                                            <button type="submit" class="btn btn-primary" id="submit_f">업데이트</button>
                                            {:}
                                            <button class="btn btn-primary" disabled>로그인 해주세요</button>
                                            {/}
                                        </div>
                                    </div>
                                </div>
                                <!-- /media-form -->
                                <input type="hidden" name="id" value="{res.id}" />
                                <input type="hidden" name="image" value="" />
                            </fieldset>
                        </form>
                        <!-- /#timeline-form -->

                        <!-- #timeline-media -->
                        <section id="timeline-media">
                            <div class="page-header">
                                <h3><span class="glyphicon glyphicon-comment"></span>&nbsp; Timeline</h3>
                                {? datetimeDiff(res.date_e, res.end, date('y.m.d H:i'), '.') < 0}
                                <div class="pull-right point-star">
                                    <dl class="dl-horizontal">
                                        <dt>행사별점</dt>
                                        <dd>
                                            <div class="rating">
                                                <span {? star.star > 0}class="selected"{/}><i class="fa fa-star"></i></span>
                                                <span {? star.star > 1}class="selected"{/}><i class="fa fa-star"></i></span>
                                                <span {? star.star > 2}class="selected"{/}><i class="fa fa-star"></i></span>
                                                <span {? star.star > 3}class="selected"{/}><i class="fa fa-star"></i></span>
                                                <span {? star.star > 4}class="selected"{/}><i class="fa fa-star"></i></span>
                                            </div>
                                            <span class="sr-only">평점 : {star.star}</span>
                                            <small>({star.cnt}명 참여)</small>
                                            {? check}
                                            <button class="btn btn-default btn-sm rateToggle" disabled="disabled">참여했어요</button>
                                            {:}
                                            <button class="btn btn-default btn-sm rateToggle">별점주기</button>
                                            {/}
                                        </dd>
                                    </dl>
                                    <script type="text/javascript">
                                        $(document).ready(function(){  
                                            $('.rateToggle').click(function(){  
                                                var state = $('.ratinglayer').css('display');  
                                                if(state == 'none'){  
                                                    $('.ratinglayer').show();  
                                                }else{  
                                                    $('.ratinglayer').hide();       
                                                }
                                            });

                                            $('.close').click(function(){    
                                                $('.ratinglayer').hide();   
                                            });
                                        });
                                    </script> 
                                    <div class="ratinglayer" style="display:none;">
                                        <form role="form">
                                            <fieldset>
                                                <button type="button" class="close">
                                                    <span aria-hidden="true">&times;</span>
                                                    <span class="sr-only">Close</span>
                                                </button>

                                                <h4>행사 별점주기 </h4>                                            
                                                <script src="/js/jquery.barrating.js"></script>
                                                <script type="text/javascript">
                                                    $(function () {
                                                        $('#star-rating').barrating({ showSelectedRating:false });
                                                        $('.rating-enable').trigger('click');
                                                    });
                                                </script>  
                                                <div class="input select rating-f">
                                                    <select id="star-rating" name="rating">
                                                        <option value="1">1</option>
                                                        <option value="2">2</option>
                                                        <option value="3">3</option>
                                                        <option value="4">4</option>
                                                        <option value="5">5</option>
                                                    </select>
                                                </div>
                                                <button class="btn btn-default" onclick="add_star('{res.id}'); return false;">확인</button>                                            
                                            </fieldset>
                                        </form> 
                                    </div>
                                </div>
                                {/}
                            </div>

                            <!-- media -->
                            <ul class="media-list" id="timeline">
                                {@ comments}
                                <li class="media">
                                    <a class="media-left" href="/member/{.ids}">
                                        <img src="{.picture}" alt="{.name}" class="avatar img-circle">
                                    </a>
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/member/{.ids}">{.name}</a> <small><a href="/lounge/comment/{.id}">{=substr(.date_created, 0, -3)}</a></small></h4>
                                        <div class="media-content"> 
                                            {? .image}
                                            <div class="pull-right">
                                                <a rel="prettyPhoto" style="background:url({.image}) center center no-repeat #000; background-size: 180px auto;" class="img-thumbnail" href="{.image}"><img src="/img/trans.png"></a>
                                            </div>
                                            {/}
                                            <p>{=trans_url(add_brs(.contents))}</p>
                                        </div>
                                        {? .p_name}
                                        <div class="media-footer">
                                            <small>
                                            <a href="/lounge/event/{.p_id}">{.p_name} </a>
                                            </small>
                                        </div>
                                        {/}
                                        <div class="media-meta">
                                            <div class="meta-actions">
                                                <div class="btn-group btn-like {? .is_like}active{/}">
                                                    <button type="button" class="btn btn-default btn-sm" onclick="comment_like(this, '{.id}', '{.is_like}'); return false;">
                                                        <span class="glyphicon glyphicon-heart"></span> 
                                                        <span class="sr-only">좋아요 </span>{? .like}<span id="li_cnt{.id}">{.like}</span> {/}
                                                    </button>
                                                    <button aria-controls="like-media" aria-expanded="true" data-target="#like-media{.id}" data-toggle="collapse" class="btn btn-default btn-sm" type="button" {? ! .like}style="display: none;"{/} onclick="get_like('{.id}'); return false;">
                                                        <span class="caret"></span>
                                                    </button>
                                                </div>
                                                <button type="button" class="btn btn-default btn-sm" data-toggle="collapse" data-target="#re-media{.id}" aria-expanded="true" aria-controls="re-media">
                                                    <span class="glyphicon glyphicon-comment"></span> <span class="sr-only">댓글 </span>  <span id="re_cnt{.id}">{=sizeof(.comm)}</span>
                                                </button> 
                                            </div>
                                        </div>
                                        <div id="like-media{.id}" class="collapse"></div>
                                        
                                        <ul id="re-media{.id}" class="media-list collapse">
                                            {@ .comm}
                                            <li class="media">
                                                <a href="/member/{..ids}" class="media-left">
                                                    <img src="{..picture}" alt="{..name}" class="avatar img-circle">
                                                </a>
                                                <div class="media-body">
                                                    <h4 class="media-heading">{..name} <small>{=substr(..date_created, 0, -3)}</small></h4>
                                                    <p>{..contents}</p>
                                                </div>
                                            </li>
                                            {/}
                                            
                                            {? s.id}
                                            <li class="media media-form" style="margin: 15px 0 0">
                                                <a href="#" class="media-left">
                                                    {? s.id}
                                                    <img src="{s.picture}" alt="{s.name}" class="avatar img-circle">
                                                    {:}
                                                    <img src="/img/default-img-member.png" alt="name" class="avatar img-circle">
                                                    {/}
                                                </a>
                                                <div class="media-body">
                                                    <form role="form" name="lo_comm_form{.id}"> 
                                                        <fieldset>
                                                        <input type="hidden" name="p_type" value="3" />
                                                        <input type="hidden" name="depth" value="1" />
                                                        <input type="hidden" name="parent" value="{.id}" />
                                                        <input type="hidden" name="p_id" value="{.p_id}" />
                                                        <input type="hidden" name="user_id" value="{s.id}" />
                                                            <div class="form-group">                        
                                                                <textarea rows="2" class="form-control" placeholder="댓글을 남겨주세요." name="contents"></textarea>
                                                            </div> 
                                                            {? s.id}
                                                            <button class="btn btn-primary" onclick="submit_lo_comm(this, '{.id}'); return false;">업데이트</button>
                                                            {:}
                                                            <button class="btn btn-primary" disabled>로그인 해주세요</button>
                                                            {/}
                                                        </fieldset>
                                                    </form>
                                                </div>
                                            </li>
                                            {/}
                                        </ul>
                                    </div>
                                </li>
                                {/}
                            </ul>
                            <!-- /media -->

                            <!-- pagination --> 
                            <nav class="paging text-center row" {? sizeof(comments) < 10}style="display: none;"{/}> 
                                <div class="col-xs-8 col-xs-offset-2 col-sm-6 col-sm-offset-3 col-md-6 col-md-offset-3">
                                    <input type="hidden" id="t_page" value="2" />
                                    <a href="#" class="btn btn-default btn-block" onclick="timeline_call('{res.id}'); return false;" id="m_t_btn">더보기</a>  
                                </div>
                            </nav> 
                            <!-- /pagination -->

                        </section>
                        <!-- /#timeline-media -->

                        <!-- #now-user -->
                        <section id="now-user">
                            <div class="page-header">
                                <h3><span class="fui-user"></span>&nbsp; D.CAMP {? datetimeDiff(res.date_e, res.end, date('y.m.d H:i'), '.') < 0}With{:}Now{/}</h3>
                            </div>

                            <p class="lead">
                                {? datetimeDiff(res.date_e, res.end, date('y.m.d H:i'), '.') < 0}{=sizeof(users)}+명이 함께 했습니다.{:}지금 D.CAMP에서는 {=sizeof(users)}+명이 함께하고 있습니다.{/}</p>

                            <ul class="list-inline">
                                {@ users}
                                <li>
                                    <a href="/member/{.ids}" data-toggle="" data-placement="top" title="{.name}">
                                      <img src="{.picture}" alt="{.name}" class="img-responsive avatar img-circle">
                                    </a>
                                </li>
                                {/}
                            </ul>
                        </section>
                        <!-- /#now-user -->

                    </div>
                    <!-- / #content -->

                    <!-- #sidebar -->
                    <div id="sidebar" class="col-xs-12 col-sm-12 col-md-4">
                        <section id="today-event">
                            <div class="page-header">
                                <h3><span class="fui-calendar"></span>&nbsp; 오늘의 D.CAMP</h3>
                            </div>
                            
                            <ul class="media-list">
                                {@ event}
                                <li class="media">
                                    {? .picture}
                                    <a class="media-left" href="/lounge/event/{.id}">
                                      <img src="{.picture}">
                                    </a>
                                    {/}
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/lounge/event/{.id}">{.title}</a> </h4>
                                        <p>{?.date}{.date} ({=date_to_day_only(.date)}) {? .start}{.start}{/}{/} {?.date_e}~ {.date_e} ({=date_to_day_only(.date_e)}) {? .end}{.end}{/}{/} </p>
                                    </div>
                                </li>
                                {/}
                            </ul>
                        </section>

                    </div>
                    <!-- /#sidebar -->
                </div>
            </div>
            <!-- /main -->
            <!-- /End Contents -->
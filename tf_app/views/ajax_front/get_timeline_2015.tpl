{? type != 9}
<link rel="stylesheet" href="/css/prettyPhoto.css" type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8" />
<script src="/js/jquery.prettyPhoto.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
//<![CDAT
$(document).ready(function(){
    $("a[rel^='prettyPhoto']").prettyPhoto({social_tools: false});
});
//]]>
</script> 
{/}
                        <header>
                            <h3><i class="fa fa-comments"></i> {? type == 9}Timeline{:}댓글{/}</h3>
                        </header>
                        <form id="timeline-form" role="form" method="post" name="p_form" onsubmit="submit_p_form('{res.id}', '{s.fb.public}'); return false">
                        
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
                                                <label class="sr-only">행사에 대한 질문이나 의견을 남겨주세요.</label>
                                                <textarea rows="4" class="form-control" placeholder="행사에 대한 질문이나 의견을 남겨주세요." name="cont"></textarea>
                                                {/}
                                            </div>

                                            <div class="form-group col-xs-12 col-sm-2 col-md-2 right">                                    
                                                <label for="inputPic" title="이미지 업로드" data-toggle="tooltip">
                                                    <img class="img-thumbnail img-responsive" src="/images/img-default.png">
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
                                              <input type="checkbox" data-toggle="checkbox" name="tw" value="1" {? ! fb}disabled="disabled"{:}checked="checked"{/}>
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
                                <input type="hidden" name="id" value="{id}" />
                                <input type="hidden" name="type" value="{type}" />
                                <input type="hidden" name="image" value="" />
                            </fieldset>
                        </form>
                        <!-- /#timeline-form -->

                        <!-- #timeline-media -->
                        <section id="timeline-media">
                            <!-- media -->
                            <ul class="media-list" id="timeline">
                                {@ comments}
                                <li class="media" id="com{.id}">
                                    <button type="button" class="close" aria-hidden="true" onclick="del_comm('{.id}', 0); return false;">×</button>
                                    <a class="media-left" href="/member/{.ids}">
                                        <img src="{.picture}" alt="{.name}" class="avatar img-circle">
                                    </a>
                                    <div class="media-body">
                                        <h4 class="media-heading">{.name} <small><a href="/lounge/comment/{.id}">{=substr(.date_created, 0, -3)}</a></small></h4>
                                        <div class="media-content"> 
                                            {? .image}
                                            <div class="pull-right">
                                                <a rel="prettyPhoto" style="background:url({.image}) center center no-repeat #000; background-size: 180px auto;" class="img-thumbnail" href="{.image}"><img src="/img/trans.png"></a>
                                            </div>
                                            {/}
                                            <p>{=trans_url(add_brs(.contents))}</p>
                                        </div>
                                        {? type == 3 && .p_name}
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
                                            <li class="media" id="com{..id}">
                                                <button type="button" class="close" aria-hidden="true" onclick="del_comm('{..id}', '{..parent}'); return false;">×</button>
                                                <a href="/member/{..ids}" class="media-left">
                                                    <img src="{..picture}" alt="{..name}" class="avatar img-circle">
                                                </a>
                                                <div class="media-body">
                                                    <h4 class="media-heading">{..name} <small>{=substr(..date_created, 0, -3)}</small></h4>
                                                    <p>{..contents}</p>
                                                </div>
                                            </li>
                                            {/}
                                            
                                            <li class="media media-form">
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
                                                        <input type="hidden" name="p_type" value="{type}" />
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
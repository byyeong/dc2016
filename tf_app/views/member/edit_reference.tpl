
                <div class="col-xs-12 col-sm-12 col-md-9 content">                
                     
                     <div class="content-header">
                        <h3 class="content-heading"><span class="icon-location-arrow"></span> 레퍼런스 내역 </h3>
                    </div>                      

                    <input type="hidden" id="page" value="1" />                
                    
                    {? !res}
                    <!-- todo: 액티비티가 없을 경우 출력 -->
                    <div class="media-none alert alert-info">
                        <strong>Oops!</strong> 
                        아직 레퍼런스 내역이 없습니다. <br>
                        레퍼런스 요청, 작성 등 회원님의 다양한 활동을 기다리고 있습니다.
                    </div>
                    {:}                   
                    
                    
                    <!-- media-list -->
                    <ul class="media-list feed-list">
                        {@ res}
                        {? .target_type == 12}
                        <li class="media"> 
                            {? .act_type == 1}
                            <a class="pull-left media-object" href="/member/{.ow_ids}"> <img src="{? .ow_picture}{.ow_picture}{:}/img/default-img-member.png{/}" class="img-circle" data-toggle="tooltip" title="{.ow_name}"> </a>
                            <div class="media-body">
                                <h4 class="media-heading"><a href="/member/{.ow_ids}">{.ow_name}</a></h4>
                                <div class="media-content">{.msg}</div>
                            </div>
                            {/}
                            {? .act_type == 2}
                            <a class="pull-left media-object " href="/startup/{.ow_id}"> <img src="{?.ow_logo}{.ow_logo}{:}/img/default-img-company.png{/}" class="img-circle"  data-toggle="tooltip" title="{.ow_name}"> </a>
                            <div class="media-body">
                                <h4 class="media-heading"><a href="/startup/{.ow_id}">{.ow_name}</a></h4>
                                <div class="media-content">{.msg}</div>
                            </div>
                            {/}
                        </li>
                        {/}
                        {/}
                    </ul>
                    {? sizeof(res) > 4}
                    
                    <div class="pager"> <a href="#" class="btn btn-default" onclick="more_act(this); return false;"> &darr;  더보기</a> </div>
                    {/}
                    {/} 
                    <!-- /media-list -->
                    
                </div>
                <!-- /content --> 

<script type="text/javascript">
//<![CDATA[

    function more_act(_this) {
        var p = $('#page').val();
        var next = parseInt(p) + 1;
        var get_url = "/ajax_front/more_act/1/{s.id}/"+next+"/12";

        $.post(get_url, function(_data) {
            if (_data !== '') {
                $('#page').val(next);
                $('.media-list').append(_data);
            } else {
                $(_this).parent().remove();
                alert("마지막 페이지입니다.");
            }
        });
    }

//]]>
</script>    
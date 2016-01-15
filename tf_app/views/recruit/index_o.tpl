<!-- rowContent -->
<div class="rowContent" id="recruit">

<!-- page-header -->
<div class="page-header">
    <div class="container">
        <h1>채용정보 <small>Recruit</small></h1>
    </div>
</div>
<!-- /page-header --> 

<!-- page-content -->
<div class="page-content" id="recruit-list"> 
    <!-- container -->
    <div class="container"> 
        <!-- content -->
        <div class="content">
            <div class="panel panel-default filter-box">
                <div class="panel-body"> 
                    <form name="rec_form" action="/recruit" method="post" >
                    <!-- row -->
                    <div class="row">
                        <div class="col-lg-4">
                            <label>구인분야</label>
                            <select class="selectpicker show-tick" name="job" onchange="submit_rec();">
                                <option value="0" {?! c_job}selected{/}> 전체 </option>
                                {@ job}
                                <option value="{.id}" {? c_job == .id}selected{/}> {._value} </option>
                                {/}
                            </select>
                        </div>
                        <!-- / -->
                        
                        <div class="col-lg-4">
                            <label >지역</label>
                            <select class="selectpicker show-tick" name="local" onchange="submit_rec();">
                                <option value="0" {?! c_local}selected{/}> 전체 </option>
                                {@ local}
                                <option value="{.id}" {? c_local == .id}selected{/}> {._value} </option>
                                {/}
                            </select>
                        </div>
                        <!-- / -->
                        
                        <div class="col-lg-4">
                            <label>경력</label>
                            <select class="selectpicker show-tick" name="career" onchange="submit_rec();">
                                <option value="0" {?! c_career}selected{/}> 전체 </option>
                                {@ career}
                                <option value="{.id}" {? c_career == .id}selected{/}> {._value} </option>
                                {/}
                            </select>
                        </div>
                        <!-- / --> 
                        
                    </div>
                    <!-- /row --> 
                    <!-- row -->
                    <div class="row">
                        <div class="col-lg-4">
                            <label>개발분야</label>
                            <select class="selectpicker show-tick" name="field" onchange="submit_rec();">
                                <option value="0" {?! c_field}selected{/}> 전체 </option>
                                {@ field}
                                <option value="{.id}" {? c_field == .id}selected{/}> {._value} </option>
                                {/}
                            </select>
                        </div>
                        <!-- / -->
                        <div class="col-lg-4">
                            <label>채용기간</label>
                            <select class="selectpicker show-tick" name="period" onchange="submit_rec();">
                                <option value="0" {?! c_period}selected{/}> 전체 </option>
                                {@ period}
                                <option value="{.id}" {? c_period == .id}selected{/}> {._value} </option>
                                {/}
                            </select>
                        </div>
                        <!-- / -->
                        <div class="col-lg-4">
                            <label>언어</label>
                            <select class="selectpicker show-tick" name="lang" onchange="submit_rec();">
                                <option value="0" {?! c_lang}selected{/}> 전체 </option>
                                {@ lang}
                                <option value="{.id}" {? c_lang == .id}selected{/}> {._value} </option>
                                {/}
                            </select>
                        </div>
                        <!-- / --> 
                    </div>
                    <!-- /row --> 
                    </form>
                </div>
            </div>
            <!-- /filter-box --> 
            
            <!-- row -->
            <div class="row">
                {@ res}
                <div class="col-md-4">
                    <div class="thumbnail">
                        <div class="caption">
                            <div class="thumb pull-left"> <img src="{.logo}"  data-src="holder.js/80x80" class="img-responsive" > </div>
                            <h3><a href="/recruit/views/{.rid}">{.bio}</a></h3> 
                            <p>{.contents}</p>
                            <dl class="dl-horizontal  item-status">
                                <dt>모집기간</dt>
                                <dd><span class="icon icon-calendar"></span> {.start}~{.end}</dd>
                                <dt>모집분야</dt>
                                <dd><span class="icon icon-tasks"></span> {._value}</dd>
                            </dl>
                        </div>
                    </div>
                    <!-- /thumbnail --> 
                </div>
                {/}
                </div>
                <!-- /row -->
                
                <div class="paging text-center">
                    <ul class="pagination">
                        {?page == 1}
                        <li class="disabled"><a href="#">&laquo;</a></li>
                        {:}
                        <li><a href="/recruit/{page - 1}">&laquo;</a></li>
                        {/}

                        {@paging.pages}
                        {?.type == "dot"}
                        <li class="disabled"><a href="#">...</a></li>
                        {:}
                        <li {?.type == "current"}class="active"{/}><a href="/recruit/{.page}">{.page}</a></li>
                        {/}
                        {/}

                        {?page == paging.tot_page}
                        <li class="disabled"><a href="#">&raquo;</a></li>
                        {:}
                        <li><a href="/recruit/{page + 1}" >&raquo;</a></li>
                        {/}
                    </ul>
                </div>
                <!-- /paging --> 
                
            </div>
            <!-- /content --> 
        </div>
        <!-- /container --> 
    </div>
    <!-- /page-content --> 
    
</div>
<!-- /rowContent --> 


<script type="text/javascript">
//<![CDAT

function submit_rec(){
    document.rec_form.submit();
}

//]]>
</script> 
<!-- rowContent -->
    <div class="rowContent" id="startup">
        <div class="page-header">
            <div class="container">
                <h2><a href="/network/startup">Startup</a></h2>
                <div class="pull-right">
                    <button class="btn btn-primary find-com"> 우리회사 등록하기</button>
                </div>


                </div>
            </div>
        </div>
        
        <!-- page-content -->
        <div class="page-content">
            <input type="hidden" id="page" value="{page}" />
            <div class="container">
                <div class="row">
                    {@ res}
                    <div class="vcard card col-xs-12 col-sm-4 col-md-3"> 
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
        </div>
        <!-- /page-content --> 
        
    </div>
    <!-- /rowContent -->

<!-- modal #searchStartup -->
<div class="modal fade" id="md-searchStartup" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div>
<!-- modal #md-compEditor -->
<div class="modal fade" id="md-compEditor" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3 class="modal-title"><span class="icon-building"></span> <span class="break"></span> 스타트업 등록하기</h3>
            </div>
            <!-- /modal-header -->
            <div class="modal-body">
                <form class="form-horizontal" role="form" name="add_st_form" >
                    <input type="hidden" name="user_id" value="{s.id}" />
                    <input type="hidden" id="form_t" name="form_t" value="" />
                    <fieldset>
                        <div class="form-group">
                            <div  class="col-lg-3 control-label">회사명</div>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" placeholder="회사명" id="md-compEditor_com" name="name">
                            </div>
                        </div>
                        <!-- /form-group -->

                        <div class="form-group">
                            <div  class="col-lg-3 control-label">한 줄 설명</div>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" placeholder="한 줄 설명" name="bio">
                            </div>
                        </div>
                        <!-- /form-group -->

                        <div class="form-group">
                            <div class="col-lg-3 control-label">로고</div>
                            <div class="col-lg-9">
                                <input type="hidden" name="img" id="img" value="">
                                <!--<iframe width="100%" scrolling="no" height="160px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/img/160x160?old=" allowtransparency="true"></iframe>//-->
                                <img class="img-thumbnail" src="/img/default-img-company.png" id="img_img" onclick="toggle_img();return false;">
                                <div id="div_img_change" style="display: none;">
                                    <iframe  height="500" frameborder="0" width="100%" scrolling="no" id="frm" allowTransparency="true" src="/ajax_front/form_file?which=img" ></iframe>
                                </div>
                            </div>
                        </div>
                        <!-- /form-group -->

                        <div class="form-group">
                            <div class="col-lg-3 control-label"> 설립일 </div>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" name="founded" placeholder="2013.10.01">
                            </div>
                        </div>
                        <!-- /form-group -->

                        <div class="form-group">
                            <div class="col-lg-3 control-label">임직원수</div>
                            <div class="col-lg-9">
                                <div class="input-group"> <span class="input-group-addon"><span class="icon-group"></span></span>
                                    <input type="number" class="form-control" name="number">
                                    <span class="input-group-addon">명</span> </div>
                                <!-- /input-group -->
                            </div>
                        </div>
                        <!-- /form-group -->

                        <div class="form-group">
                            <div class="col-lg-3 control-label">사업분야</div>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" name="bussiness" >
                                <span class="help-block">콤마(,)를 사용해서 구분해주세요</span> </div>
                        </div>
                        <!-- /form-group -->

                        <div class="form-group">
                            <div class="col-lg-3 control-label">핵심기술</div>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" name="tech" >
                                <span class="help-block">콤마(,)를 사용해서 구분해주세요</span> </div>
                        </div>
                        <!-- /form-group -->

                        <div class="form-group">
                            <div class="col-lg-3 control-label">웹사이트</div>
                            <div class="col-lg-9">
                                <input type="url" class="form-control" value="http://" name="website">
                                <!-- alert -->
                                <div class="alert alert-dismissable web_err" style="display: none;">
                                    <p class="text-danger"><strong>Oops!</strong> 웹사이트의 형식이 맞지 않습니다.</p>
                                </div>
                                <!-- /alert -->
                            </div>
                        </div>
                        <!-- /form-group -->

                        <div class="form-group">
                            <div class="col-lg-3 control-label">블로그</div>
                            <div class="col-lg-9">
                                <input type="url" class="form-control" value="http://" name="blog">
                                <!-- alert -->
                                <div class="alert alert-dismissable blog_err" style="display: none;">
                                    <p class="text-danger"><strong>Oops!</strong> 블로그의 형식이 맞지 않습니다.</p>
                                </div>
                                <!-- /alert -->
                            </div>
                        </div>
                        <!-- /form-group -->

                        <div class="form-group">
                            <div class="col-lg-3 control-label">SNS</div>
                            <div class="col-lg-9">
                                <p class="input-group"> <span class="input-group-addon"><span class="icon-twitter"></span> &nbsp;  Twitter</span>
                                    <input type="text" placeholder="twitter url" class="form-control" name="twitter" >
                                </p>
                                <!-- /input-group -->
                                <p class="input-group"> <span class="input-group-addon"><span class="icon-facebook"></span> &nbsp;  Facebook</span>
                                    <input type="text" placeholder="facebook url" class="form-control" name="facebook">
                                </p>
                                <!-- /input-group -->
                            </div>
                        </div>
                        <!-- /form-group -->

                        <div class="form-group">
                            <div class="col-lg-3 control-label">메일주소</div>
                            <div class="col-lg-9">
                                <input type="email" class="form-control" placeholder="" name="email">
                                <!-- alert -->
                                <div class="alert alert-dismissable email_err" style="display: none;">
                                    <p class="text-danger"><strong>Oops!</strong> 이메일의 형식이 맞지 않습니다. </p>
                                </div>
                                <!-- /alert -->
                            </div>
                        </div>
                        <!-- /form-group -->

                        <div class="form-group">
                            <div class="col-lg-3 control-label">주소</div>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" placeholder="" name="addr">
                            </div>
                        </div>
                        <!-- /form-group -->

                        <div class="form-group">
                            <div class="col-lg-3 control-label">연락처</div>
                            <div class="col-lg-9">
                                <input type="tel" class="form-control" placeholder="" name="tel">
                            </div>
                        </div>
                        <!-- /form-group -->
                    </fieldset>
                </form>
            </div>
            <!-- /modal-body -->

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" onclick="st_submit(this); return false;">확인</button>
            </div>
            <!-- /modal-footer -->
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /modal #md-compEditor -->
<script src="/js/jquery.blurr.js"></script>
<script>
//<![CDAT
$(document).ready(function() { 
    $('.bgimg').blurr();

    /*company search*/
    $('.find-com').click(function(){

        find_com($(this), 1);
    });
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

                            $('.row').append(_data);                            

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

function find_com(_this, _type){
    var key = "";
    var form =  $(_this).parent().parent().parent().parent().parent().parent().parent().attr('id');
    var get_url = '/ajax_front/get_search_startup2/'+_type +'/1';
    var set_data ={
        "data" 		: key,
        "v" 		: 1,
        "form"          : form,
    };

    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'html',
        success : function(_data) {

            $('#md-searchStartup').html(_data);
            $('#md-searchStartup').modal('show');
        }
    });
}

function enter_startup(_form, _type){
    var tt = $('#search_in').val();
    tt = tt.replace(/(^\s*)|(\s*$)/gi, "");
    $('.modal').modal('hide');
    if (_type === '1') {
        $('#md-compEditor_com').val(tt);
        $('#form_t').val(_form);
        $('#md-compEditor').modal('show');

        var win_height = $(window).height();
        $('#md-compEditor .modal-body').height(win_height*0.8).css("overflow", "auto");
    }
    else {

        var get_url = '/ajax_front/get_add_investment/';
        var set_data ={
            "data" 		: tt,
            "v" 		: 1,
            "form"          : _form,
        };

        $.ajax({
            type : 'POST',
            url : get_url,
            data : set_data,
            dataType : 'html',
            success : function(_data) {
                $('#md-invEditor').html(_data);
                $('#md-invEditor').modal('show');
            }
        });
    }
}


function st_submit(_this) {
    $('.alert-dismissable').hide();

    if ($('input[name=website]').val().length > 7) {
        var t = valid_url($('input[name=website]').val());
        if (t === false) {
            $('.web_err').show();
            document.add_st_form.website.focus();
            return false;
        }
    }
    if ($('input[name=blog]').val().length > 7) {
        var t = valid_url($('input[name=blog]').val());
        if (t === false) {
            $('.blog_err').show();
            document.add_st_form.blog.focus();
            return false;
        }
    }
    if ($('input[name=email]').val().length > 0) {
        var t = valid_email(document.add_st_form.email);
        if (t === false) {
            $('.email_err').show();
            document.add_st_form.email.focus();
            return false;
        }
    }
    var get_url = '/ajax_front/add_startup/';

    var frm = $('form[name=add_st_form]');
    var set_data = frm.serialize();;
    var _form = $('#form_t').val();
    $(_this).hide();
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {
            //$('#'+_form+' [name=company]').val($('#md-compEditor_com').val());
            //$('#'+_form+' [name=company]').attr('readonly', 'readonly');
            $(_this).show();
            $('.modal').modal('hide');
            location.reload();
        }
    });
}
</script>
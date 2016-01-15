
      <!-- contentwrap -->
      <div class="col-md-10 contentswrap"> 
        <!-- section -->
        <section> 
          
          <!-- panel #pane-eventType-edit -->
          <div id="pane-eventType-edit" class="panel panel-default"> 
            <!-- panel-heading -->
            <div class="panel-heading">
              <h2><span class="glyphicon  glyphicon-cog"></span><span class="break"></span>이벤트 종류 설정</h2>
              <div class="actions"> <span class="break"></span> <a href="/admin_event/type" data-toggle="tooltip" title="목록보기"><span class="glyphicon  glyphicon-align-justify"></span></a> </div>
            </div>
            <!-- /panel-heading -->
            
            <form class=" form-horizontal" method="post" name="e_type_f" onsubmit="return false;">
                <input type="hidden" name="id" value="{res.id}" />
              <!-- panel-body -->
              <div class="panel-body">
                <fieldset>
                  <div class="form-group error"> 
                    <div class="col-xs-12 col-sm-2 col-md-2 control-label" >이벤트 종류 명</div>
                    <div class="col-xs-12 col-sm-10 col-md-10">
                        <input type="hidden" name="check" value="{? res}1{/}" />
                      <div class="input-group">                          
                          <input type="text" class="form-control"  name="name" value="{res.name}" onfocus="check_(); return false;" >
                            <span class="input-group-btn">
                                <button type="button" class="btn btn-default" onclick="check_type(); return false;" data-toggle="tooltip" title="중복체크">
                                    <span class="glyphicon glyphicon-ok"></span><span class="sr-only">중복체크</span>
                                </button>
                            </span> 
                        </div>
                       
                      <p class="text-danger" style="display: none;"> <span class="label label-danger"><span class="glyphicon  glyphicon-remove glyphicon-white"></span></span> 사용할 수 없어요! 다시 입력해 주세요 </p>
                        
                    </div>
                  </div>
                  <!-- /form-group -->
                  
                  <div class="form-group"> 
                    <div class="col-xs-12 col-sm-2 col-md-2 control-label" >종류 설명</div>
                    <div class="col-xs-12 col-sm-10 col-md-10">
                      <input type="text" class="form-control" name="description" value="{res.description}">
                    </div>
                  </div>
                  <!-- /form-group -->
                  
                  <div class="form-group"> 
                    <div class="col-xs-12 col-sm-2 col-md-2 control-label" >종류 선택 목록 노출</div>
                    <div class="col-xs-12 col-sm-10 col-md-10">
                      <label class="radio-inline">
                          <input type="radio" name="visible" value="1" {? res.visible == 1}checked{/}>
                        보임 </label>
                      <label class="radio-inline">
                          <input type="radio" name="visible" value="0" {? res.visible == 0}checked{/}>
                        숨김 </label>
                    </div>
                  </div>
                  <!-- /form-group -->
                </fieldset>
              </div>
              <!-- /panel-body --> 
              <!-- panel-footer -->
              <div class="panel-footer">
                <div class="form-group">
                    <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10">
                    <a href="javascript:window.location.reload();" class="btn btn-default" >취소</a>
                    <button type="submit" class="btn btn-primary" onclick="submit_type(); return false;">등록</button>
                    </div>
                </div>
              </div>
              <!-- /panel-footer -->
            </form>
          </div>
          <!-- /panel #pane-eventType-edit --> 
          
        </section>
        <!-- /section --> 
      </div>
      <!-- /contentwrap --> 
      
      <script type="text/javascript">
//<![CDATA[

{? msg}
    alert('{msg}');
{/}
    
function check_type()
{
    var check = $('input[name=name]').val();
    if (check.length < 1) {
        alert("이벤트 종류명을 입력해주세요.");
        return false;
    }
    var get_url = '/ajax/check_event_type/';
    var set_data ={
        "data"      : check,
    };
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {

            if (!_data.check) {
                $('input[name=check]').val(1);
                $('.text-danger').slideUp();
                alert("사용할 수 있어요.");
            } else {
                $('.text-danger').slideToggle();
            }
        }
    });
}

function submit_type()
{
    if ($('input[name=check]').val() !== "1") {
        alert("이벤트 종류명 중복체크 해주세요.");
        return false;
    }
    
    document.e_type_f.submit();
}

function check_()
{
    $('input[name=check]').val(0);
}
//]]>
</script>
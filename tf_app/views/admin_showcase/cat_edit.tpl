
      <!-- contentwrap -->
      <div class="col-md-10 contentswrap"> 
        <!-- section -->
        <section> 
          
          <!-- panel #pane-eventType-edit -->
          <div id="pane-eventType-edit" class="panel panel-default"> 
            <!-- panel-heading -->
            <div class="panel-heading">
              <h2><span class="glyphicon  glyphicon-cog"></span><span class="break"></span>시장정보 추가</h2>
              <div class="actions"> <span class="break"></span> <a href="/admin_showcase" data-toggle="tooltip" title="목록보기"><span class="glyphicon  glyphicon-align-justify"></span></a> </div>
            </div>
            <!-- /panel-heading -->
            
            <form class=" form-horizontal" method="post" name="e_type_f" action="/admin_showcase/cat_edit/{res.id}">
              <!-- panel-body -->
              <div class="panel-body">
                <fieldset>
                  <div class="form-group"> 
                    <div class="col-xs-12 col-sm-2 col-md-2 control-label" >시장 명</div>
                    <div class="col-xs-12 col-sm-10 col-md-10">
                      <input type="text" class="form-control" name="_value" value="{res._value}">
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
                    <a href="javascript:location.href='/admin_showcase/cat_index'" class="btn btn-default" >취소</a>
                    <button type="submit" class="btn btn-primary">등록</button>
                    </div>
                </div>
              </div>
              <!-- /panel-footer -->
              <input type="hidden" name="_key" value="bz_market" >
              <input type="hidden" name="id" value="{res.id}" >
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
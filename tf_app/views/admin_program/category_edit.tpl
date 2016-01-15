
      <!-- contentwrap -->
      <div class="col-md-10 contentswrap"> 
        <!-- section -->
        <section> 
          
          <!-- panel #pane-eventType-edit -->
          <div id="pane-eventType-edit" class="panel panel-default"> 
            <!-- panel-heading -->
            <div class="panel-heading">
              <h2><span class="glyphicon  glyphicon-cog"></span><span class="break"></span>Benefits 성격 설정</h2>
              <div class="actions"> <span class="break"></span> <a href="/admin_event/type" data-toggle="tooltip" title="목록보기"><span class="glyphicon  glyphicon-align-justify"></span></a> </div>
            </div>
            <!-- /panel-heading -->
            
            <form class=" form-horizontal" method="post" name="e_type_f" onsubmit="return false;">
                <input type="hidden" name="id" value="{res.id}" />
              <!-- panel-body -->
              <div class="panel-body">
                <fieldset>
                  <div class="form-group error"> 
                    <div class="col-xs-12 col-sm-2 col-md-2 control-label" >Benefits 성격 명</div>
                    <div class="col-xs-12 col-sm-10 col-md-10">
                        <input type="text" class="form-control"  name="category" value="{res.category}" >
                    </div>
                  </div>
                  <!-- /form-group -->
                  
                  <div class="form-group"> 
                    <div class="col-xs-12 col-sm-2 col-md-2 control-label" >목록 노출</div>
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

function submit_type()
{
    if ( ! $('input[name=name]') ) {
        alert("Program 성격명을 입력 해주세요.");
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
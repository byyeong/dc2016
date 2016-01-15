            <!-- modal content -->
                <ul class="row">
                    {? res}
                    {@ res}
                    <li class="col-xs-12 col-sm-6 col-md-4">
                        <label class="radio-inline" id="sp">
                            <input type="radio" name="mento" value="{.id}">
                            {.name} 
                            <small>{.department} {.position}</small>
                        </label>
                    </li>
                    {/}
                    {:}
                    <li  class="col-xs-12 col-sm-6 col-md-4">
                        <label class="radio-inline">
                            <small>등록된 멘토가 없습니다. 멘토를 먼저 등록해주세요.</small>
                        </label>
                    </li>
                    {/}
                </ul>
            <!-- /modal content -->
<script>
// $(document).ready(function() {
    $("input:radio[name=mento]").change(function () {
        _id = $("input:radio[name=mento]:checked").val();
        window.location.href = "/admin_office/edit_oh?m=" + _id;
    });
// }
</script>
<br />
UltraEdit project 파일 자동 생성<br />
<br />
울트라에디트용 프로젝트 파일을 자동 생성합니다.<br />
자동으로 생성한 프로젝트 파일(.prj)을 다운로드 하거나,<br />
프로젝트 최 상단 폴더로 export 할 수 있습니다.<br />

{?filename}
<font color="red"><b>{cwd}\{filename}.prj 파일로 저장되었습니다.</b></font><br />
{/}

<br />
<form action="/tf/make_ultra_project_write" method="post" name="form_main">
* 프로젝트에 포함할 하위폴더를 선택하여 주십시오<br />
* 탬플릿 관련 소스, 탬플릿 캐시 폴더 및 사용되지 않는 것으로 추정되는 컴포넌트는<br />
  자동으로 제외되었습니다만, 필요에 따라 추가하실 수도 있습니다.<br />
  <br />

{@files}
    <input type="checkbox" name="files" id="ret_{.name}" {?!.pass}checked="true"{/} onclick="affect_siblings('{.name}');"/>
    {.spacing}{.name}<br />
{/}
<input type="hidden" name="skips" value="" />

<br /><br />
- <a href="/tf/make_ultra_project_download" onclick="download_file();return false;">.prj 파일 다운로드</a><br />
- {cwd}\<input type="text" name="filename" value="trail" size="8"/>.prj <a href="/tf/make_ultra_project_write" onclick="write_file();return false;">파일로 직접 쓰기</a><br />
</form>
<br />

<script>

    function get_skips()
    {
        var rs = "";
        var ret = document.getElementsByName("files");
        for (i=0;i<ret.length;i++)
        {
            r = ret[i];
            if (!r.checked)
            {
                rs = rs + r.id.substring(4) + "|";
            }
        }
        return rs;
    }
    
    function download_file()
    {
        var a = get_skips();
        document.form_main.skips.value = a;

        document.form_main.action = "/tf/make_ultra_project_download";
        document.form_main.submit();
    }
    
    function write_file()
    {
        var a = get_skips();
        document.form_main.skips.value = a;

        document.form_main.action = "/tf/make_ultra_project_write";
        document.form_main.submit();
    }
    
    function affect_siblings(ids)
    {
        var org = document.getElementById("ret_" + ids);
        var chkd = org.checked;
        var ret = document.getElementsByName("files");
        for (i=0;i<ret.length;i++)
        {
            r = ret[i];
            if (r.id.substring(4, ids.length + 4) == ids)
            {
                r.checked = chkd;
            }
        }
    }
    
</script>


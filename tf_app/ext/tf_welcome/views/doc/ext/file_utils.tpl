<a name="0" />
<h3>문서 &gt; 확장 기능 &gt; File Utils</h3>
<br /><br />
이 절에서는 파일 유틸 기능을 설명합니다. <br />
적용 버전: 0.8 이상의 버전에 설치할 수 있습니다. 0.7 버전에 제한적으로 적용됩니다(<a href="#4">?</a>)<br /><br />
<a href="#1">1. DB 설정</a><br />
<a href="#2">2. settings.php 의 설정</a><br />
<a href="#4">3. 사용 방법</a><br />
<a href="#5">4. TF 0.6 에서의 사용</a><br />
<a href="#6">5. 문제 해결</a><br />

<br />
<a name="1" />
<h4>1. DB 설정</h3>
싱크에 실패한 기록을 남기기 위해 default db 에 다음의 테이블을 추가합니다.
{=cst()}
    CREATE TABLE `tf_image_sync` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `path` varchar(512) DEFAULT NULL,
      `org` varchar(64) DEFAULT NULL,
      `action` varchar(16) DEFAULT NULL,
      `error_cnt` int(11) DEFAULT '1',
      `date_created` datetime DEFAULT NULL,
      PRIMARY KEY (`id`),
      KEY `error_cnt` (`error_cnt`,`id`)
    ) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1
{=ced()}
<br />
<br />
<a href="#0">문서의 최상단으로</a><br /><br />

<br />
<a name="2" />
<h4>2. settings.php의 설정</h3>
* 확장 기능의 사용을 위해 먼저 bootstrap_apps 에 "file_control" 를 다음과 같이 포함합니다.<br /><br />
{=cst()}
var $bootstrap_apps = array(
&nbsp; &nbsp; &nbsp; &nbsp; "tf_utils",
&nbsp; &nbsp; &nbsp; &nbsp; "globals",
&nbsp; &nbsp; &nbsp; &nbsp; <font color="red"><b>"file_control/info",  // 이 부분이 새로 추가된 부분입니다.</b></font>
&nbsp; &nbsp;);
{=ced()}
<br />
순서는 상관이 없습니다.<br /><br />
* 세팅 파일의 아무 곳에나 다음의 코드를 입력하여 싱크 서버를 세팅합니다.<br /><br />
{=cst()}
        var $ext_file_control_server = array(
                    'current'=>'http://192.168.1.203:96',    // <- 현재 서버
                    'server2'=>'http://192.168.1.203:81034', // <- 기타 서버
                );
{=ced()}
<br /><br />
싱크할 서버는 "현재 서버를 포함하여" 배열 형태로 적되,<br />
현재 서버는 "current" 라는 키를 가져야 합니다.<br />
모든 서버는 끝에 "/" 를 제외하고 적습니다.<br />
* current 표시를 하지 않더라도, 확장 기능은 자동으로 현재 서버를 확인하지만,<br />
well-known port 문제나 ssl 문제 등에 따라서 비 정상적으로 작동되어질 수 있으므로<br />
current 로 표시하는 것을 추천합니다.<br />
<br />
<a href="#0">문서의 최상단으로</a><br /><br />


<a name="3" />
<h4>3. 사용 방법</h3>
Tf_file 클래스의 인스턴스를 만드는 것으로 파일 업로드가 완료 됩니다.<br />
<br />
1. 파일 이름을 지정하지 않고 업로드 하여 초기화 하는 경우 (일반적인 업로드)<br />
{=cst()}
    $image = Tf_image('file1', '/media/users/');
{=ced()}
첫번째 인수는, 이전 form 에서 받은 file input 의 name 입니다.<br />
두번째 인수는, 업로드 할 주소입니다. web 아래의 주소로, / 로 시작되어야 합니다.<br />
사용자가 올린 파일 이름을 기본으로, 중복이 없도록 안전한 파일 명으로 변환될 수 있습니다.<br />
<br />
2. 파일 이름을 지정하여 업로드 하여 초기화 하는 경우.<br />
{=cst()}
    $image = Tf_image('file1', '/media/users/', '1.jpg');
{=ced()}
첫번째, 두번째 인수는 위와 같고, 마지막 인수에 저장할 파일 이름을 적으면,<br />
해당 이름으로 강제하여 저장합니다.<br />
<br />
3. 서버 이내에 이미 존재하는 파일을 이용하여 초기화 하는 경우.<br />
{=cst()}
    $image = Tf_image('/media/users/1.jpg');
{=ced()}
web 아래의 주소를 기준으로 / 를 포함하여 서버에 있는 파일을 가지고 초기화 합니다.<br />
<br />
4. 파일 정보<br />
$image 는 다음의 멤버들로 파일 정보를 가지고 있습니다<br />
file_full_path: 서버 내의 전체 경로 (파일 이름 포함)<br />
file_web_path: web 이하의 경로 (/ 로 시작, 파일 이름 포함)<br />
file_name_safe: 업로드 된 파일명<br />
<br />
* 초기화하면서 업로드 한 경우가 아니라,<br />
서버 이내에 존재하는 파일을 이용하여 초기화 한 경우 file_full_path, file_target_path 만<br />
제공됩니다.<br />
<br />
5. 싱크하기<br />
위 초기화 된 Tf_image 의 인스턴스의 sync(); 메서드를 이용하여 싱크합니다<br />
{=cst()}
    $image->sync();
{=ced()}
<br />
6. 삭제 싱크<br />
썸네일 작업등으로 인해 삭제해야 할 경우가 있을 수 있습니다.<br />
삭제는 remove_and_sync 메서드를 이용합니다<br />
{=cst()}
    $image->remove_and_sync('/web/users/20_20/1.jpg');
{=ced()}
로컬의 파일도 삭제하며, 등록된 서버들과 싱크합니다.<br />
<br />
7. 실패 한 싱크.<br />
실패하였을 경우, DB 에 기록이 남게 됩니다.<br />
웹 서버에서 /tf/file_control/retry/ 를 호출하면 실패한 그간의 싱크 내역을 (기본 100건) 처리합니다.<br />
crontab 등을 이용하여 작업하기를 권합니다.<br />
일괄 처리시 등록된 서버에서 호출하지 않는 경우, 보안을 위해 작업되지 않습니다<br />
주소 뒤에 숫자를 붙이면 해당 숫자만큼 처리합니다.<br />
<br /><br />
업로드에 대한 예제는 <a href="/samples/upload/">여기</a> 에서 확인하시기 바랍니다.
<br /><br />


<a name="4" />
<h4>5. TF 0.7 에서의 사용</h3>
* TF 0.7 보다 낮은 버전에서는 익스텐션 기능을 지원하지 않기 때문에 사용이 불가능합니다.<br />
* TF 0.7.x 버전의 경우, 컴포넌트의 URL ROUTING 등록이 자동으로 이루어지지 않기 때문에,
tf_app/settings/settings.php 의 라우팅 설정을 추가로 할 필요가 있습니다.
{=cst()}
var $route = array(
        ...
        <font color="red">"tf/file_control/sync" => "*component*/file_control/sync",</font>
        <font color="red">"tf/file_control/retry" => "*component*/file_control/retry/100",</font>
        <font color="red">"tf/file_control/retry/%retry_count" => "*component*/file_control/retry/%retry_count",</font>
        );
{=ced()}
<br /><br />


<br /><br /><br /><br />
<font size="1">
문서의 끝.<br />
최초 작성일: 2011/08/08, 고빈섭<br />
최종 수정일: 2011/08/08, 고빈섭<br />
</font>

<a name="0" />
<h3>문서 &gt; 0.8 소개 &gt; 모델과 관련된 새로운 기능</h3>
<br /><br />
이 절에서는 0.8버전에서 새로워진 모델과 관련된 기능을 담습니다. <br />
<a href="#1">1. 모델 파일에서 선언 삭제</a><br />
<a href="#2">2. 모델 파일이 없는 모델</a><br />
<a href="#3">3. 여러개의 form data를 편하게, value() 를 확장한 values()</a><br />
<a href="#4">4. delete 와 delete_cond 의 병합</a><br />
<a href="#5">5. 한번에 여러 절의 insert 하기</a><br />
<a href="#6">6. 기타 수정된 사항</a><br />

<br /><br />
<a name="1" />
<h4>1. 모델 파일에서 선언 삭제</h3>
기존에 각 모델 파일에서 클래스 바깥에 모델의 instance 를 생성하는 부분을<br />
Trail 에서 작업하도록 변경하여, 모델 파일 작성의 편의를 도모하였습니다<br />
이제는 모델을 작성할때 model class 를 상속받는 각 모델 클래스만 만들면 됩니다.<br /><br/>
<b><font color="red">주의! read DB 가 별도이거나(리플리케이션) 2개 이상의 DB 를 사용하는 경우</b></font><br/>
DEFAULT 모델이 아닌 모델의 세팅을 사용할 경우, <br />
모델 멤버 변수로 $_db_master 를 지정하여야 합니다.<br />
읽기 DB가 별도인 경우에는 $_db_read 를 지정하셔야 합니다.<br />
{=cst()}
    class TM_Synonymous_links_model extends Model
    {
        var $tablename = "synonymous_links";
        <b><font color="red">var $_db_master = "TWEETMIX_DB1";</b></font> // master 지정
        <b><font color="red">var $_db_read = "TWEETMIX_DB1_READ";</b></font> // read DB 지정
        
        ...
{=ced()}

<a href="#0">문서의 최상단으로</a><br /><br />

<a name="2" />
<h4>2. 모델 파일이 없는 모델</h3>
간혹, 모델로서의 기능은 없지만, 테이블이 존재하기 때문에<br />
빈 클래스의 모델이 필요한 경우가 있었습니다<br />
이 경우 모델 파일을 굳이 만들지 않아도 되도록 바뀌었습니다<br />
<br />
트레일의 부트스트랩은 요청한 모델의 파일이 발견되지 않았을 경우<br />
알아서 model 클래스의 인스턴스로 해당 모델을 로드합니다.<br />
테이블명은 요청한 모델을 소문자로 변환한 것이 기본이 됩니다.<br />
<br />
<a href="#0">문서의 최상단으로</a><br /><br />

<a name="2" />
<h4>3. 여러개의 form data를 편하게, value()를 확장한 values()</h3>
웹 작업에서 대부분의 insert/update 구문은 form 으로 입력된 데이터를 특별한 정제 없이<br />
입력한다는 점에서 착안하여, 복수의 from data를 편하게 assign 할 수 있도록<br />
value() 를 확장한 values() 기능이 새로 추가되었습니다.<br />
<br />
메써드의 형태는 values($keys) 이며, $keys 부분에는<br />
form data의 키를 나열하면 됩니다.<br />
<br />
key가 겹치지 않는다면, value 와 values 는 하나의 쿼리에서 동시에 사용될 수 있습니다.<br />
간단한 입력은 values 로, 추가적인 처리는 value 로 나누어서 작업할 수 있습니다.<br />
<br />
{=cst()}
// values 를 이용하여 몇개의 데이터를 간편하게 넣어보았습니다.
$c = new Query();
$c->values("user_id, name, tel, addr");
$c->value("email", $email);

//위의 구문은 아래와 동일한 효과를 가져옵니다.
$c = new Query();
$c->value("user_id",$_REQUEST["user_id"]);
$c->value("name",   $_REQUEST["name"]);
$c->value("tel",    $_REQUEST["tel"]);
$c->value("addr",   $_REQUEST["addr"]);
$c->value("email",  $email);

{=ced()}

<br />
<a href="#0">문서의 최상단으로</a><br /><br />


<a name="4" />
<h4>4. delete 와 delete_cond 의 병합</h3>
기존에 delete($id) 는 해당 id 값을 삭제,<br />
delete_cond($query)는 해당 조건의 값을 모두 삭제하는 것으로,<br />
혼동의 여지가 있었습니다만, 0.8 버전부터 delete($id) 메쏘드 가<br />
두 가지의 기능을 모두 할 수 있도록 하였습니다.<br />
<br />
호환성을 위해 delete_cond($query) 도 아직 사용가능하지만,<br />
추후에 지원을 중단할 계획이 있으므로 사용을 피하기를 권합니다.<br />
{=cst()}
// Query instance 의 작성
$c = new Query();
$c->where("id = 15");

// 이전 방식, Query instance 를 이용하여 삭제 (권장하지 않음)
$this->delete_cond($c);

// ID 를 이용한 삭제. 이 경우 Query instance 는 필요치 않음
$c->delete(15);

// 새 방식, Query instance 를 이용하여 삭제
$this->delete($c);

//위의 세 구문은 모두 동일한 효과를 가져옵니다.
{=ced()}
<br />
<a href="#0">문서의 최상단으로</a><br /><br />

<a name="5" />
<h4>6. 한번에 여러 절의 insert 하기</h3>
- 동시에 여러 건의 insert 가 이루어지는 경우, 하나의 쿼리로 보내는 것이<br />
  성능상 큰 이점이 있습니다. 0.8 부터 이를 지원합니다.<br />
- VALUE 값을 지정할 때, 값을 array 로 주면, 여러 건의 insert 로 인식하여 수행합니다.<br />
<br />
이런 방식으로 가능합니다.<br />
{=cst()}
$c = new Query();
$c->value("id", array(1,2,3));
$c->value("name", array('홍길동','홍길순','홍홍홍'));
$this->insert($c);

// 이는 다음의 SQL 문과 같습니다.
// insert into [tablename] (id, name) values (1,'홍길동'),(2,'홍길순'),(3,'홍홍홍');
{=ced()}
<br />
일반적으로는 이런 식으로 처리되겠지요.<br />
{=cst()}
$id = array();
$name = array();
for($i=0; $i<$maxid; $i++)
{
    $id[] = $_REQUEST["id_" . $i];
    $name[] = $_REQUEST["name_" . $i];
}
$c = new Query();
$c->value("id", $id);
$c->value("name", $name);
$this->insert($c);

{=ced()}
<b><font color="red">주의! 트레일 모델은 데이터의 갯수를 확인하지 않습니다. 각 밸류값은 모두 같은 사이즈의 어레이여야 합니다.</b></font><br/>

<br />
<a href="#0">문서의 최상단으로</a><br /><br />


<a name="6" />
<h4>6. 기타 수정된 사항</h3>
- 일부 버전에 반영되었던, 조인 관련 버그가 수정된 소스로 통일되었습니다.<br />
- 일부 버전에 반영되었던, execute(insert/update) 후 결과값 리턴이 제대로<br />
&nbsp; 되지 않았던 버그가 수정된 소스로 통일되었습니다.<br />
- 해당 커넥션에서 가장 최근에 업데이트 된 auto_increase 값을 반환하는<br />
&nbsp; last_id() method 가 새로 추가되었습니다.<br />
<br />
<a href="#0">문서의 최상단으로</a><br /><br />

<br /><br /><br /><br />
<font size="1">
문서의 끝.<br />
최초 작성일: 2011/06/24, 고빈섭<br />
최종 수정일: 2010/07/21, 고빈섭<br />
</font>

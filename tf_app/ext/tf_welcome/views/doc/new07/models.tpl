<a name="0" />
<h3>문서 &gt; 0.7 소개 &gt; 모델과 관련된 새로운 기능</h3>
<br /><br />
이 절에서는 0.7버전에서 새로워진 모델과 관련된 기능을 담습니다. <br />
<a href="#1">1. 쿼리문 단위 디버그 기능</a><br />
<a href="#2">2. inner join 제공</a><br />
<a href="#3">3. 컴포넌트에서 사용된 모델의 사용</a><br />
<br /><br />
<a name="1" />
<h4>1. 쿼리문 단위 디버그 기능</h3>
기존 모델에서 $this->Foo->debug(); 라는의 명령을 이용하여 모델 전역에<br />
sql 문을 표시하는 디버그 편의를 제공하였습니다만,<br />
이것이 모든 쿼리문을 표시하기 때문에 디버그에 불편함이 있었습니다<br />
이 기능은 그대로 유지한 채로, Query 인스턴트에 동일한 debug() 기능을 넣었습니다<br />
이것은 해당 쿼리가 수행되는 시점에 해당 쿼리를 보여줍니다.<br />
{=cst()}
$c = new Query();
<font color="red"><b>$c->debug();</b></font>
$this->fetch("*", $c);
{=ced()}
<a href="#0">문서의 최상단으로</a><br /><br />

<a name="2" />
<h4>2. inner join 제공</h3>
명시적으로 조인을 제공하지 않았기 때문에, 기존에 from 멤버를 사용하여<br />
조인을 사용할 수 밖에 없었으나, 0.7부터 join 기능을 정식으로 제공합니다.<br />
조인을 할 테이블에 대한 각각의 Query instance 를 만들고 inner_join 멤버를 이용해<br />
두 쿼리를 하나로 묶습니다.<br />
{=cst()}

$c1 = new Query();
$c1->from = "foo"   // 현재 모델과 같다면 굳이 필요치는 않은 구문입니다.
$c2 = new Query();
$c2->from = "bar";

$c1->inner_join($c2)
$c1->on("foo.id = bar.f_id");

$this->fetch("foo.id, bar.name", $c1);
{=ced()}
<a href="#0">문서의 최상단으로</a><br /><br />


<a name="3" />
<h4>3. 컴포넌트에서 사용된 모델의 사용</h3>
0.7에서 새로 제공되는 컴포넌트 기능은 모델을 포함할 수 있습니다<br />
컴포넌트에서 사용된 모델을 프로젝트 내에서 별도로 사용할 필요가 있는 경우<br />
로딩시 "*" 표식을 이용해 그대로 사용할 수 있습니다. 사용시에는 * 표시가 빠집니다.<br />
{=cst()}
    class Foo extends Controller
    {
        var $use_models = array("Boards", <font color="red"><b>"*Foo"</b></font>);
        
        ...
        
        function index()
        {
            $bar = <font color="red"><b>$this->Foo->fetch_all()</b></font>
        }
        
        ...
        
{=ced()}
<a href="#0">문서의 최상단으로</a><br /><br />



<br /><br /><br /><br />
<font size="1">
문서의 끝.<br />
최초 작성일: 2010/07/15, 고빈섭<br />
최종 수정일: 2010/07/15, 고빈섭<br />
</font>

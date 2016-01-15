<?php /* Template_ 2.2.4 2011/06/16 16:46:14 C:\tf8\tf_app\ext\tf_welcome\views\diagnotics.tpl 000004192 */ 
$TPL_result_1=empty($TPL_VAR["result"])||!is_array($TPL_VAR["result"])?0:count($TPL_VAR["result"]);
$TPL_result_core_1=empty($TPL_VAR["result_core"])||!is_array($TPL_VAR["result_core"])?0:count($TPL_VAR["result_core"]);
$TPL_result_bs_1=empty($TPL_VAR["result_bs"])||!is_array($TPL_VAR["result_bs"])?0:count($TPL_VAR["result_bs"]);
$TPL_result_con_1=empty($TPL_VAR["result_con"])||!is_array($TPL_VAR["result_con"])?0:count($TPL_VAR["result_con"]);
$TPL_result_model_1=empty($TPL_VAR["result_model"])||!is_array($TPL_VAR["result_model"])?0:count($TPL_VAR["result_model"]);?>
DB 및 세팅 검사<br />
이 항목은 트레일 세팅과 주요한 php 세팅을 검사합니다.<br />
이 항목에 문제가 있는 경우 trail 이 정상동작할 수 없습니다.<br />
<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <td>항목</td>
        <td>검사 결과</td>
        <td>설명 및 조치법</td>
    </tr>
<?php if($TPL_result_1){foreach($TPL_VAR["result"] as $TPL_V1){?>
    <tr>
        <td><?php echo $TPL_V1["title"]?></td>
        <td><?php echo $TPL_V1["result"]?></td>
        <td><?php echo $TPL_V1["remedy"]?></td>
    </tr>
<?php }}?>
</table>
<br /><br /><br />
Trail core 정보<br />
이 항목은 설치된 Trail core 파일의 정보를 확인합니다.<br />
<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <td>파일명</td>
        <td>이름</td>
        <td>버전</td>
        <td>검사 결과</td>
        <td>설명 및 조치법</td>
    </tr>
<?php if($TPL_result_core_1){foreach($TPL_VAR["result_core"] as $TPL_V1){?>
    <tr>
        <td><?php echo $TPL_V1["file"]?></td>
        <td><?php echo $TPL_V1["name"]?></td>
        <td><?php echo $TPL_V1["version"]?></td>
        <td><?php echo $TPL_V1["result"]?></td>
        <td><?php echo $TPL_V1["remedy"]?></td>
    </tr>
<?php }}?>
</table>
<br /><br /><br />
사용중인 외부 컴포넌트 정보<br />
사용중인 외부 컴포넌트를 검사합니다.<br />
호환 여부등이 불명확한 경우에는 확인을 거쳐 사용하시기를 권장합니다.<br />
<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <td>파일명</td>
        <td>이름</td>
        <td>버전</td>
        <td>호환여부</td>
        <td>설명 및 조치법</td>
    </tr>
<?php if($TPL_result_bs_1){foreach($TPL_VAR["result_bs"] as $TPL_V1){?>
    <tr>
        <td><?php echo $TPL_V1["file"]?></td>
<?php if($TPL_V1["name"]){?>
        <td><?php echo $TPL_V1["name"]?></td>
        <td><?php echo $TPL_V1["version"]?></td>
<?php if($TPL_V1["approved"]== 1){?>
        <td>호환됨</td>
<?php }else{?>
<?php if($TPL_V1["approved"]== 2){?>
        <td>알 수 없음</td>
<?php }else{?>
        <td>호환불가</td>
<?php }?>
<?php }?>
<?php }else{?>
        <td colspan="2">상세 정보 없음</td>
        <td>알 수 없음</td>
<?php }?>
        <td><?php echo $TPL_V1["remedy"]?></td>
    </tr>
<?php }}?>
</table>

<br /><br /><br />
컨트롤러 정보<br />
컨트롤러 파일을 검사합니다.<br />
<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <td>파일명</td>
        <td>검사 결과</td>
        <td>설명 및 조치법</td>
    </tr>
<?php if($TPL_result_con_1){foreach($TPL_VAR["result_con"] as $TPL_V1){?>
    <tr>
        <td><?php echo $TPL_V1["file"]?></td>
        <td><?php echo $TPL_V1["result"]?></td>
        <td><?php echo $TPL_V1["remedy"]?></td>
    </tr>
<?php }}?>
</table>

<br /><br /><br />
모델 정보<br />
모델 파일을 검사합니다
<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <td>파일명</td>
        <td>검사 결과</td>
        <td>설명 및 조치법</td>
    </tr>
<?php if($TPL_result_model_1){foreach($TPL_VAR["result_model"] as $TPL_V1){?>
    <tr>
        <td><?php echo $TPL_V1["file"]?></td>
        <td><?php echo $TPL_V1["result"]?></td>
        <td><?php echo $TPL_V1["remedy"]?></td>
    </tr>
<?php }}?>
</table>
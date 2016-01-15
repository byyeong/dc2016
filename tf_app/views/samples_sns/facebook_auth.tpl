SNS 샘플 - facebook 연동<br />
<br />
/tf_sns_utils/facebook_auth/ 를 링크하는 것으로 연동이 시작됩니다.<br /><br />
다만,<br />
tf_app/ext/tf_sns_utils/settings.php 파일에<br />
facebook에서 발급받은 cunsumer_key, cunsumer_secret, 그리고<br />
받은 인증 데이터를 처리할 콜백 url 을 설정하여야 합니다.<br />
<br />
tf_app/ext/tf_sns_utils/settings.php 세팅법은<br />
<a href="/tf/doc/ext/sns/#settings">여기</a>를 참고하시기 바랍니다.<br />
(*컴포넌트에서 트레일 웰컴팩을 제거한 경우, 위 매뉴얼이 나오지 않을 수 있습니다)<br /><br />
설정이 옳은 것이 확실하다면,
<a href="/tf_sns_utils/facebook_auth/">/tf_sns_utils/facebook_auth/</a> 로 이동합니다.
<br />

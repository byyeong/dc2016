<a name="0" />
<h3>문서 &gt; 개요</h3>
<br /><br />
이 절에서는 Trail Framework 의 개요를 설명합니다. <br />

<a href="#1">1. 개요 및 디자인 원칙</a><br />
<a href="#2">2. features</a><br />
<a href="#3">3. 버전 기록</a><br />
<a href="#4">4. Requirement</a><br />
<a href="#5">5. 설치</a><br />


<br />
<a name="1" />
<h4>1. 개요 및 디자인 원칙</h3>
- Trail은 PHP 기반으로 동작하는 소형 프레임워크입니다. <br />
- ㈜ 유저스토리랩 사내 개발용으로 2009년 봄에 처음 만들어졌습니다.<br />
- 프레임워크 자체의 기능은 최소한으로 유지하고 필요한 부가기능은 apps에 설치하도록 합니다.<br />

<br />
<a name="2" />
<h4>2. Features</h3>
- MVC Architecture 적용<br />
- CRUD 편의성 제공<br />
- Memcache 기반의 cache system 제공<br />
- Replication 기반의 DB scalability 제공<br />
<br />
<a name="3" />
<h4>3. 버전 기록</h3>

1.3.1. 0.5 버전<br />
- 지리산길 프로젝트의 일환으로 제작되었습니다.<br />
- MVC 아키텍쳐를 적용하고 모델 사용 편의성을 제공하는 것이 목표입니다.<br />
<br />
1.3.2. 0.6 버전<br />
- (중요사항) 0.5로의 하위호환성은 지원되지 않습니다. 0.5 버전의 사용을 위하여 bootstrap.php 하단의 invoke 섹션을 적절히 커멘트 아웃할 수 있습니다. 해당 내용에 대하여 소스에 기술되어 있습니다. 다만 이 경우에도 완전한 동작을 보장하는 것은 아닙니다.<br />
- 각 프로젝트별 branch에서 향상된 부분을 취합하여 모델 편의성을 더욱 높였습니다<br />
- cache system 과 replication을 프레임워크단에서 지원합니다.<br />
- method invoke 관련 코드가 전면 개정되었습니다. 이로 인하여 하위호환성 보장이 되지 않습니다.<br />
<br />
1.3.3. 0.6.1 버전<br />
- 사용자 정의 라우팅 기능이 적용되었습니다.<br />
- 하위호환성은 문제없으며, 0.6.1 버전에서 작성된 프로젝트를 0.6 에서 작동하는 경우에도 사용자 정의 라우팅 부분이 무시되는 것 이외의 특별한 문제는 발견되지 않았습니다.<br />
<br />
1.3.4. 0.7.0 버전<br />
- 공식적으로 inner join 을 지원합니다.<br />
- 컴포넌트 기능을 지원합니다.<br />
- 0.6.x 버전과의 알려진 하위호환성 문제는 없습니다.<br />

<br />
<a name="4" />
<h4>4. Requirement</h3>
- PHP 4.0 이상<br />
- MySQL<br />
- Apache HTTPD<br />
- Apache rewrite module<br />
- PHP memcache module (* tf_cache app을 사용할 경우에만 필요)<br />

<br />
<a name="5" />
<h4>5. 설치</h3>

1.5.1. 설치 파일 복사<br />
- <a href="/downloads/">여기</a> 에서 최신 소스 파일을 내려받아 소스 파일을 작업 폴더에 위치시킵니다<br />
- 설치가 완료된 폴더 구조는 다음과 같습니다<br />
 <br />
<br />
1.5.2. Apache httpd.conf 설정<br />
- 아파치 설정의 DocumentRoot를 작업 폴더 내 web 로 위치시킵니다<br />
- rewrite module 을 로드합니다<br />
LoadModule rewrite_module modules/mod_rewrite.so<br />
- AllowOverride All 로 설정합니다.<br /><br />

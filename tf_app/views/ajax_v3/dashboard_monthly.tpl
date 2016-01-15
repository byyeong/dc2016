
<h3><span class="glyphicon glyphicon-play-circle"></span> 가입 및 등록 현황</h3>
<table class="table table-bordered">
    <thead>
    <tr>
        <th>#</th>
        <th>전체</th>
        <th>신규등록</th>
        <th>이전 기간 등록</th>
        <th>정리 및 탈퇴</th>
        <th>증감률(%)</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <th>전체회원</th>
        <td>{ user.authorized}</td>
        <td>{ user.new }</td>
        <td>{ user.prev_new }</td>
        <td>{ user.withdraw }</td>
        <td>{ ?user.growth } { user.growth }% { : } - { / }</td>
    </tr>
    <tr>
        <th>멤버십 회원</th>
        <td>{ member.authorized }</td>
        <td>{ member.new }</td>
        <td>{ member.prev_new }</td>
        <td>{ member.withdraw }</td>
        <td>{ ?member.growth } { member.growth }% { : } - { / }</td>
    </tr>
    <tr>
        <th>스타트업 프로필</th>
        <td>{ startup.authorized}</td>
        <td>{ startup.new }</td>
        <td>{ startup.prev_new }</td>
        <td> - </td>
        <td>{ ?startup.growth } { startup.growth }% { : } - { / }</td>
    </tr>
    </tbody>
</table>
<!-- /table -->

<h3><span class="glyphicon glyphicon-play-circle"></span> 운영 및 콘텐츠 현황</h3>
<table class="table table-bordered">
    <thead>
    <tr>
        <th>#</th>
        <th>전체</th>
        <th>신규 등록</th>
        <th>이전 기간 등록</th>
        <th>증감률(%)</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <th>이벤트</th>
        <td>{ event.authorized }</td>
        <td>{ event.new }</td>
        <td>{ event.prev_new }</td>
        <td>{ ?event.growth } { event.growth }% { : } - { / }</td>
    </tr>
    <tr>
        <th>Blog</th>
        <td>{ blog.authorized }</td>
        <td>{ blog.new }</td>
        <td>{ blog.prev_new }</td>
        <td>{ ?blog.growth } { blog.growth }% { : } - { / }</td>
    </tr>
    <tr>
        <th>채용정보</th>
        <td>{ recruit.authorized }</td>
        <td>{ recruit.new }</td>
        <td>{ recruit.prev_new }</td>
        <td>{ ?recruit.growth } { recruit.growth }% { : } - { / }</td>
    </tr>
    <tr>
        <th>공간공유</th>
        <td>{ space.authorized }</td>
        <td>{ space.new }</td>
        <td>{ space.prev_new }</td>
        <td>{ ?space.growth } { space.growth }% { : } - { / }</td>
    </tr>
    </tbody>
</table>
<!-- /table -->

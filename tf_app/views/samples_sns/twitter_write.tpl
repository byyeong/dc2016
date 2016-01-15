SNS 샘플 - 트위터 글 쓰기<br />
<br />
{?writed}
<b>글을 작성하였습니다.</b><br />
작성 글 확인하기: <a href="http://twitter.com/{screen_name}/{writed}">http://twitter.com/{screen_name}/{writed}</a><br />
<br/><br/>
{/}
연동된 데이터로 글을 써 봅시다.<br /><br />
<form action="/samples_sns/twitter_write" method="post">
트위터에 쓸 내용: <input type="text" size="60" name="cont" value="test..." />
<input type="submit" value="글 쓰기" /><br />
% 주의: 정말로 글이 써집니다. 테스트 계정이 아닌 경우 주의하시기 바랍니다.<br />
</form>
<br />


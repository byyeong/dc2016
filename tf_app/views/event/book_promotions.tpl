<link rel="stylesheet" href="/css/style_event_0401.css"><!-- 가능하면 <head> 안에서 부르면 좋지만 그냥 여기서 부르기 -->

<div class="bookPromotionEvent">

    <!-- mastHead -->
    <div class="bMastHead">
        <div class="b_e_container">
            <h2>
                스타트업 멘토가 선정한 창업자 필독서
                <small>4.1 ~ 4.30</small>
            </h2>

            <div class="b_e_step1">
                <h3>
                    창업, 어떤 책들을 봐야하죠?
                </h3>
                <p>
                    4월 한달간 매일 매일<br>
                    스타트업 멘토가 추천하는 창업자 필독서를 <br>
                    디캠프 이벤트 페이지에서 만나보세요!
                </p>
            </div>
            <div class="b_e_step2">
                <h3>
                    이벤트에 참여하세요!
                </h3>
                <p>
                    디캠프 회원이신가요? 자신의 프로필을 완성하고,<br>
                    개성있는 자기 소개를 작성해 주세요<br>
                    매일 한분께 멘토가 선정한 필독서를 드립니다.
                </p>
            </div>

        </div> <!-- /.b_e_container -->
    </div> <!-- /.bMastHead -->

    <div class="b_e_container b_e_content">

        {@ t_res}
        <!-- TODAY 필독서 -->
        <div class="b_e_bookWrap b_e_todayBook">
            <h4 class="b_e_date">
                <strong>TODAY<i>필독서</i></strong>
                <span>{=substr(.dates, 6)}({=date_to_day_only(.dates)})</span>
            </h4>
            <div class="bookInfo">
                <img class="bookCover" src="{.img}" alt="{.title}">
                <h4>{.title}{?.subtitle}<small>- {.subtitle}</small>{/}</h4>
                <p class="author">
                    {.author}
                </p>
                <p class="publisher">
                    {.publisher} <em>{.c_date}</em>
                </p>
                <p class="tags">
                    <i></i> {.tags}
                </p>
            </div>
            <div class="b_e_comment">
                <img class="commenter" src="{.mento_img}" alt="{.mento_name}">
                <h5>{.mento_name} 님의 추천</h5>
                <p>
                    <a href="{.url}">{=add_brs(.mento_endor)}</a>
                </p>
            </div> <!-- /.b_e_comment -->

            <a class="btn_apply_event hatch" href="{.url}">
                오늘 이벤트 참여하기
            </a>
        </div> <!-- /.b_e_bookWrap -->
        {/}





        <!-- 날짜 지난 이벤트 -->
        <ul class="bookList passedBookList">
            {@ passed}
            <li class="b_e_bookWrap">
                <h4 class="b_e_date">
                    <span>{=substr(.dates, 6)}({=date_to_day_only(.dates)})</span>
                </h4>
                <div class="bookInfo">
                    <img class="bookCover" src="{.img}" alt="권력의 법칙">
                    <h4>{.title}<small>- {.subtitle}</small></h4>
                    <p class="author">
                    {.author}
                </p>
                <p class="publisher">
                    {.publisher} <em>{.c_date}</em>
                </p>
                <p class="tags">
                    <i></i> {.tags}
                </p>
            </div>
            <div class="b_e_comment">
                <img class="commenter" src="{?.mento_img}{.mento_img}{:}/img/default-img-member.png{/}" alt="{.mento_name}">
                <h5>{.mento_name} 님의 추천</h5>
                <p>
                    <a href="{.url}">{=add_brs(.mento_endor)}</a>
                </p>
            </div> <!-- /.b_e_comment -->
            </li>
            {/}

        </ul>






        <!-- 예정된 이벤트 -->
        <ul class="bookList scheduledBookList">
            {@ scheduled}
            <li class="b_e_bookWrap">
                <h4 class="b_e_date">
                    <span>{=substr(.dates, 6)}({=date_to_day_only(.dates)})</span>
                </h4>
                <img class="commenter" src="{?.mento_img}{.mento_img}{:}/img/default-img-member.png{/}" alt="{.mento_name}">
                <p>
                    {.mento_name}님 이 추천하는 책은 <em>{=substr(date_to_kr(.dates), 9)} 정오</em>에 공개됩니다.
                </p>
            </li>
            {/}
        </ul>






    </div> <!-- /.b_e_container -->
</div> <!-- /.bookPromotionEvent -->

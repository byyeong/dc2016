            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2><span class="icon-plus"></span><span class="break"></span>분류 관리  </h2>
                            <div class="actions"> 
                                <span class="break"></span> 
                                <a title="목록보기" data-toggle="tooltip" href="/admin_manage/faq_category">
                                    <span class="icon-align-justify"></span>
                                </a> 
                            </div>
                        </div>
                        <!-- /panel-heading -->

                        <div class="panel-body">

                            <form class="form-horizontal" method="post" action="/admin_manage/edit_faq_category/{res.id}">
                                <fieldset>
                                    <div class="form-group">
                                        <span class="col-lg-2 control-label">분류명</span>
                                        <div class="col-lg-10">
                                            <input type="text" class="form-control" name="category" value="{res.category}" required>
                                        </div>
                                    </div>


                                    <!--div class="form-group">
                                        <span class="col-lg-2 control-label">담당자 연결하기</span>
                                        <div class="col-lg-10">
                                             
                                            <div class="well">
                                                <header>
                                                    <h4>연결된 계정 정보</h4>
                                                </header>
                                                <table class="table table-striped table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th class="td-id">아이디</th>
                                                            <th class="td-name">이름</th>
                                                            <th class="td-gender">성별</th>
                                                            <th class="td-birth">생년월일</th>
                                                            <th class="td-phone">휴대폰번호</th>
                                                            <th class="td-company">소속</th> 
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        {? u}
                                                        <tr>
                                                            <td class="td-id">{u.ids}</td>
                                                            <td class="td-name"><a href="/member/{u.ids}">{u.name}</a></td>
                                                            <td class="td-gender">{? u.gender == 1}남{:}여{/}</td>
                                                            <td class="td-birth">{u.birth}</td>
                                                            <td class="td-phone">{u.tel}</td>
                                                            <td class="td-company">{u.com.name}</td> 
                                                        </tr> 
                                                        {:}
                                                        <tr><td>등록된 계정이 없습니다.</td></tr>
                                                        {/}
                                                    </tbody>
                                                </table>
                                            </div>

                                            <button class="btn btn-default btn-sm" type="button" data-toggle="modal" data-target="#md-connectId">
                                                <span class="glyphicon glyphicon-search"></span> 계정찾기
                                            </button>
                                        </div>
                                    </div-->
                                    <!-- /form-group -->

                                    <div class="form-group form-submit"> 
                                        <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10">
                                            <button class="btn btn-default" type="button">취소</button>
                                            <button class="btn btn-primary" type="submit">저장</button>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    <input type="hidden" name="c_type" value="1" />
                                    <input type="hidden" name="id" value="{res.id}" />
                                </fieldset>
                            </form>

                        </div>
                        <!-- /panel-body -->
                    </div>
                    <!-- /panel --> 
                    
                </section>
                <!-- /section --> 
            </div>
            <!-- /contentwrap --> 

<div class="modal fade" id="md-connectId" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">멘토 권한과 연결하고자 하는 회원 검색  </h4>
            </div>
            <div class="modal-body">
            <!-- modal content -->
                <div class="panel panel-default"> 
                     <div class="panel-body highlight">
                        <form class="col-md-8 col-lg-offset-2" role="search" method="post" onsubmit="return false;" name="f_search">
                            <div class="input-group">
                                <input type="text" placeholder="이름, 핸드폰 번호, 생년월일을 입력한 후 검색하세요." class="form-control" name="q">
                                <span class="input-group-btn">
                                <button type="submit" class="btn btn-default" onclick="serch_member();">검색</button>
                                </span> 
                            </div>
                        </form>
                    </div>
                    <!-- /panel-body -->
                    <table class="table table-striped table-hover"></table>
                </div>
                <!-- /panel -->  
            <!-- /modal content -->
            </div> 
        </div>
    </div>
</div>
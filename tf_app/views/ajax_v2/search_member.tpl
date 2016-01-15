                    
                        <thead>
                            <tr>
                                <th class="td-id">아이디</th>
                                <th class="td-name">이름</th>
                                <th class="td-gender">성별</th>
                                <th class="td-birth">생년월일</th>
                                <th class="td-phone">휴대폰번호</th>
                                <th class="td-company">소속</th>
                                <th class="td-checkin">계정연결</th>
                            </tr>
                        </thead>
                        <tbody>
                            {@ res}
                            <tr>
                                <td class="td-id">{.ids}</td>
                                <td class="td-name"><a href="/member/{.ids}">{.name}</a></td>
                                <td class="td-gender">{? .gender == 1}남{/}{? .gender == 2}여{/}</td>
                                <td class="td-birth">{.birth}</td>
                                <td class="td-phone">{.tel}</td>
                                <td class="td-company">{.com.name}</td>
                                <td class="td-checkin">
                                    {? rep}
                                    <a class="btn btn-default btn-xs" href="#" onclick="this_select_r(this, {.id}, {rep}); return false;">선택하기 </a>
                                    {:}
                                    <a class="btn btn-default btn-xs" href="#" onclick="this_select(this, {.id}); return false;">선택하기 </a>
                                    {/}
                                </td>
                            </tr>
                            {/}
                        </tbody>
                    
                                {@ res}
                                <tr>
                                    <td class="td-num">{.key_ + 1}</td>
                                    <td class="td-category">{.category}</td>
                                    <td class="td-subject"><a href="/admin_manage/edit_faq/{.id}">{.title}</a></td> 
                                    <td class="td-status">
                                        {? .open}<span class="btn-success btn-xs">공개</span>
                                        {:}<span class="btn-danger btn-xs">비공개</span>{/}
                                    </td>
                                    <td class="td-manage">
                                        <a class="btn btn-default btn-xs" href="/admin_manage/edit_faq/{.id}">수정</a>
                                        <button class="btn btn-warning btn-xs" onclick="del_faq(this, '{.id}'); return false;">삭제</button>
                                    </td> 
                                    <td class="td-order">
                                        <button class="btn btn-default btn-xs" onclick="re_order({.id}, {.ord}, 0); return false;"><span class="glyphicon glyphicon-chevron-up"></span> <span class="sr-only">위로</span></button>
                                        <button class="btn btn-default btn-xs" onclick="re_order({.id}, {.ord}, 1); return false;"><span class="glyphicon glyphicon-chevron-down"></span> <span class="sr-only">아래로</span></button>
                                    </td>                               
                                </tr>
                                {/}
                                            {? res}
                                            {@ res}
                                            <tr>
                                                <td class="td-name">{.name}</td>
                                                <td class="td-cnt"><span class="badge badge-info">{.end}</span></td>
                                                <td class="td-cnt"><span class="badge badge-warning">{apply_cnt - .end}</span></span> 
                                                </td>
                                            </tr>
                                            {/}
                                            {:}
                                            <tr>
                                                <td colspan="3">등록된 심사위원이 없습니다. 
                                                </td>
                                            </tr>
                                            {/}
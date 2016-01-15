
<link rel="stylesheet" media="screen" href="/editor/editor.css" type="text/css" />
<script type="text/javascript" src="/editor/editor.js"></script>

<!--
<style>
	.itemWrap dl,
	.writeSet dl {border-bottom:1px solid #e8e8e8; padding:5px;}
	.itemWrap dt,
	.writeSet dt {font-size:11px;  float:left; color:#707070; font-weight:bold; width:80px; padding-top:5px;}
</style>
-->

<div id="editor" style="margin-top:0px; padding-top:0px;width:650px;">
	<div class="property">
		<dl class="fontrelatives">
		<dd>
		<select id="editor_fontname" name="fontname" class="fontname" onchange="onclick_editor_font('FontName', document.getElementById('editor_fontname')); return false;">
		<option value="">폰트</option>
		<option value="굴림체">굴림체</option>
		<option value="바탕체">바탕체</option>
		</select>
		<select id="editor_fontsize" name="fontsize" class="fontsize" onchange="onclick_editor_font('FontSize', document.getElementById('editor_fontsize')); return false;">
		<option value="">글자크기 </option>
		<option value="1">&nbsp;1</option>

		<option value="2">&nbsp;2(기본값)</option>
		<option value="3">&nbsp;3</option>
		<option value="4">&nbsp;4</option>
		<option value="5">&nbsp;5</option>
		<option value="6">&nbsp;6</option>
		<option value="7">&nbsp;7</option>
		<option value="8">&nbsp;8</option>
		</select>
		</dd>
		</dl>

		<dl class="fontstyle">
		<dt></dt>
		<dd>
		<a href="#" onclick="onclick_editor_com('Bold'); return false;"><img src="/editor/iconChracter_bold.gif" alt="bold" /></a
		><a href="#" onclick="onclick_editor_com('Italic'); return false;"><img src="/editor/iconChracter_italic.gif" alt="italic" /></a
		><a href="#" onclick="onclick_editor_com('Underline'); return false;"><img src="/editor/iconChracter_underline.gif" alt="underline" /></a
		><a href="#" onclick="onclick_editor_com('StrikeThrough'); return false;"><img src="/editor/iconChracter_strikethough.gif" alt="strike though" /></a
		><a href="#" onclick="palette_mode = '1'; display_palette(); return false;"><img src="/editor/iconChracter_color.gif" alt="font color" /></a
		><a href="#" onclick="palette_mode = '2'; display_palette(); return false;"><img src="/editor/iconChracter_background.gif" alt="background" /></a>

		</dd>
		</dl>

		<dl class="paragraph">
		<dt></dt>
		<dd>
		<a href="#" onclick="onclick_editor_com('JustifyLeft'); return false;"><img src="/editor/iconPragraph_leftalign.gif" alt="Left align text" /></a
		><a href="#" onclick="onclick_editor_com('JustifyCenter'); return false;"><img src="/editor/iconPragraph_centeralign.gif" alt="Center align text" /></a
		><a href="#" onclick="onclick_editor_com('JustifyRight'); return false;"><img src="/editor/iconPragraph_rightalign.gif" alt="Right align text" /></a
		>

		<!-- <a href="#" onclick=" return false;"><img src="/editor/iconPragraph_justifyall.gif" alt="justifyall" /></a
		><a href="#" onclick=" return false;"><img src="/editor/iconPragraph_outdent.gif" alt="Outdent" /></a
		><a href="#" onclick=" return false;"><img src="/editor/iconPragraph_indent.gif" alt="Indent" /></a>-->
		</dd>

		</dl>

		<dl class="insertSpecial">
		<dt></dt>
		<dd>
		<a href="#" onclick="onclick_attach_image(); return false;"><img src="/editor/insertspecial_image.gif" alt="" /></a>
		<a href="#" onclick="onclick_add_link(); return false;"><img src="/editor/insertlinkl_image.gif" alt="" /></a>
		<!-- <a href="#"><img src="/editor/insertspecial_link.gif" alt="link " /></a> -->
		<!--<a href="#"><img src="/editor/insertspecial_imgimoticon.gif" alt="imoticon " /></a>
		<a href="#"><img src="/editor/insertspecial_txtimoticon.gif" alt="imoticon " /></a>
		<a href="#"><img src="/editor/insertspecial_bgm.gif" alt="background music " /></a>-->

		<!-- <a href="#"><img src="/editor/insertspecial_bgm.gif" alt="動画 " /></a>-->
		</dd>
		</dl>

		<dl class="editormode">
		<dt></dt>
		<dd style="padding-right:12;">
		<a href="#" onclick="onclick_editor_mode_change('html'); return false;"><img src="/editor/editormode_edit.gif" alt="edit" /></a>
		<a href="#" onclick="onclick_editor_mode_change('text'); return false;"><img src="/editor/editormode_html.gif" alt="html" /></a>

		</dd>
		</dl>


			<script type="text/javascript">
			var currentMode = 'html';
			function onclick_editor_mode_change(mode) {
				var text_editor = document.getElementById('html_body');
				var html_editor = document.getElementById('htmleditor');
				if(currentMode == mode ) return false;
				if (mode == 'html') {
					htmleditor.document.body.innerHTML = text_editor.value;
					text_editor.style.display = 'none';
					html_editor.style.display = 'block';
					currentMode = 'html';
				}

				if (mode == 'text') {
					text_editor.value = htmleditor.document.body.innerHTML;
					text_editor.style.display = 'block';
					html_editor.style.display = 'none';
					currentMode = 'text';
				}
			}
			</script>

	</div>
	<div style="clear:both;"><span/></div>

	<!-- E property -->

	<!--
	<style>
	#editor_palette tr { height:10px; }
	#editor_palette td { padding:0px!important }
	#editor_palette img { margin:0px; }
	</style>
	-->

		<div style="position:absolute;">
		<div id="editor_palette" style="position:absolute; display:none; margin:0 0 0 230px">
			<table border="0" cellspacing="1" cellpadding="0" style="cursor:pointer; background-color:#FFFFFF">
			<tr>
			<td width="10" height="10" style="background-color:#ffffff"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#ffffff');" /></td>
			<td width="10" height="10" style="background-color:#ebebeb"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#ebebeb');" /></td>
			<td width="10" height="10" style="background-color:#e1e1e1"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#e1e1e1');" /></td>

			<td width="10" height="10" style="background-color:#d7d7d7"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#d7d7d7');" /></td>
			<td width="10" height="10" style="background-color:#cccccc"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#cccccc');" /></td>
			<td width="10" height="10" style="background-color:#c2c2c2"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#c2c2c2');" /></td>
			<td width="10" height="10" style="background-color:#acacac"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#acacac');" /></td>
			<td width="10" height="10" style="background-color:#959595"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#959595');" /></td>
			<td width="10" height="10" style="background-color:#898989"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#898989');" /></td>
			<td width="10" height="10" style="background-color:#6f6f6f"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#6f6f6f');" /></td>
			<td width="10" height="10" style="background-color:#626262"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#626262');" /></td>
			<td width="10" height="10" style="background-color:#555555"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#555555');" /></td>

			<td width="10" height="10" style="background-color:#464646"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#464646');" /></td>
			<td width="10" height="10" style="background-color:#363636"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#363636');" /></td>
			<td width="10" height="10" style="background-color:#252525"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#252525');" /></td>
			<td width="10" height="10" style="background-color:#000000"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#000000');" /></td>
			</tr>

			<tr>
			<td width="10" height="10" style="background-color:#f6977a"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#f6977a');" /></td>
			<td width="10" height="10" style="background-color:#f9ad81"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#f9ad81');" /></td>

			<td width="10" height="10" style="background-color:#fdc589"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#fdc589');" /></td>
			<td width="10" height="10" style="background-color:#fff799"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#fff799');" /></td>
			<td width="10" height="10" style="background-color:#c4df9b"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#c4df9b');" /></td>
			<td width="10" height="10" style="background-color:#a2d39c"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#a2d39c');" /></td>
			<td width="10" height="10" style="background-color:#82ca9c"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#82ca9c');" /></td>
			<td width="10" height="10" style="background-color:#7bccc8"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#7bccc8');" /></td>
			<td width="10" height="10" style="background-color:#6ecff6"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#6ecff6');" /></td>
			<td width="10" height="10" style="background-color:#7ea7d8"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#7ea7d8');" /></td>
			<td width="10" height="10" style="background-color:#8493ca"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#8493ca');" /></td>

			<td width="10" height="10" style="background-color:#8882be"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#8882be');" /></td>
			<td width="10" height="10" style="background-color:#a187be"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#a187be');" /></td>
			<td width="10" height="10" style="background-color:#bc8cbf"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#bc8cbf');" /></td>
			<td width="10" height="10" style="background-color:#f49ac2"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#f49ac2');" /></td>
			<td width="10" height="10" style="background-color:#f5989d"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#f5989d');" /></td>
			</tr>

			<tr>
			<td width="10" height="10" style="background-color:#f26c4e"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#f26c4e');" /></td>

			<td width="10" height="10" style="background-color:#f68e55"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#f68e55');" /></td>
			<td width="10" height="10" style="background-color:#fbaf5c"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#fbaf5c');" /></td>
			<td width="10" height="10" style="background-color:#fff467"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#fff467');" /></td>
			<td width="10" height="10" style="background-color:#abd372"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#abd372');" /></td>
			<td width="10" height="10" style="background-color:#7cc576"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#7cc576');" /></td>
			<td width="10" height="10" style="background-color:#3bb878"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#3bb878');" /></td>
			<td width="10" height="10" style="background-color:#1abbb4"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#1abbb4');" /></td>
			<td width="10" height="10" style="background-color:#00bff3"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#00bff3');" /></td>
			<td width="10" height="10" style="background-color:#438cca"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#438cca');" /></td>

			<td width="10" height="10" style="background-color:#5574b9"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#5574b9');" /></td>
			<td width="10" height="10" style="background-color:#605ca8"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#605ca8');" /></td>
			<td width="10" height="10" style="background-color:#855fa8"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#855fa8');" /></td>
			<td width="10" height="10" style="background-color:#a763a8"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#a763a8');" /></td>
			<td width="10" height="10" style="background-color:#f06ea9"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#f06ea9');" /></td>
			<td width="10" height="10" style="background-color:#f26d7c"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#f26d7c');" /></td>
			</tr>

			<tr>

			<td width="10" height="10" style="background-color:#ed1c24"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#ed1c24');" /></td>
			<td width="10" height="10" style="background-color:#f26522"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#f26522');" /></td>
			<td width="10" height="10" style="background-color:#f7941d"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#f7941d');" /></td>
			<td width="10" height="10" style="background-color:#fff200"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#fff200');" /></td>
			<td width="10" height="10" style="background-color:#8dc63f"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#8dc63f');" /></td>
			<td width="10" height="10" style="background-color:#39b54a"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#39b54a');" /></td>
			<td width="10" height="10" style="background-color:#00a650"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#00a650');" /></td>
			<td width="10" height="10" style="background-color:#00a99d"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#00a99d');" /></td>
			<td width="10" height="10" style="background-color:#00adef"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#00adef');" /></td>

			<td width="10" height="10" style="background-color:#0072bc"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#0072bc');" /></td>
			<td width="10" height="10" style="background-color:#0054a6"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#0054a6');" /></td>
			<td width="10" height="10" style="background-color:#2e3092"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#2e3092');" /></td>
			<td width="10" height="10" style="background-color:#662c91"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#662c91');" /></td>
			<td width="10" height="10" style="background-color:#92278f"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#92278f');" /></td>
			<td width="10" height="10" style="background-color:#ec008c"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#ec008c');" /></td>
			<td width="10" height="10" style="background-color:#ed145b"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#ed145b');" /></td>
			</tr>

			<tr>
			<td width="10" height="10" style="background-color:#9d0a0f"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#9d0a0f');" /></td>
			<td width="10" height="10" style="background-color:#a0410d"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#a0410d');" /></td>
			<td width="10" height="10" style="background-color:#a36209"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#a36209');" /></td>
			<td width="10" height="10" style="background-color:#aba000"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#aba000');" /></td>
			<td width="10" height="10" style="background-color:#598527"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#598527');" /></td>
			<td width="10" height="10" style="background-color:#1a7a30"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#1a7a30');" /></td>
			<td width="10" height="10" style="background-color:#007236"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#007236');" /></td>
			<td width="10" height="10" style="background-color:#00736b"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#00736b');" /></td>

			<td width="10" height="10" style="background-color:#0076a3"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#0076a3');" /></td>
			<td width="10" height="10" style="background-color:#004b80"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#004b80');" /></td>
			<td width="10" height="10" style="background-color:#003471"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#003471');" /></td>
			<td width="10" height="10" style="background-color:#1b1464"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#1b1464');" /></td>
			<td width="10" height="10" style="background-color:#440e62"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#440e62');" /></td>
			<td width="10" height="10" style="background-color:#630460"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#630460');" /></td>
			<td width="10" height="10" style="background-color:#9e005d"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#9e005d');" /></td>
			<td width="10" height="10" style="background-color:#9d0039"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#9d0039');" /></td>
			</tr>

			<tr>
			<td width="10" height="10" style="background-color:#790000"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#790000');" /></td>
			<td width="10" height="10" style="background-color:#7b2e00"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#7b2e00');" /></td>
			<td width="10" height="10" style="background-color:#7d4900"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#7d4900');" /></td>
			<td width="10" height="10" style="background-color:#827a00"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#827a00');" /></td>
			<td width="10" height="10" style="background-color:#406618"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#406618');" /></td>
			<td width="10" height="10" style="background-color:#005e20"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#005e20');" /></td>
			<td width="10" height="10" style="background-color:#005826"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#005826');" /></td>

			<td width="10" height="10" style="background-color:#005952"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#005952');" /></td>
			<td width="10" height="10" style="background-color:#005b7f"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#005b7f');" /></td>
			<td width="10" height="10" style="background-color:#003663"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#003663');" /></td>
			<td width="10" height="10" style="background-color:#002157"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#002157');" /></td>
			<td width="10" height="10" style="background-color:#0d004c"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#0d004c');" /></td>
			<td width="10" height="10" style="background-color:#32004b"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#32004b');" /></td>
			<td width="10" height="10" style="background-color:#4b0049"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#4b0049');" /></td>
			<td width="10" height="10" style="background-color:#7b0046"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#7b0046');" /></td>
			<td width="10" height="10" style="background-color:#790026"><img src="/images/spacer.gif" width="10px" height="10px" alt="" onclick="ck_color('#790026');" /></td>

			</tr>
			</table>
		</div>
	</div>


	<div class="contentTextarea" style="margin:5px 0 0 0">
	<textarea  class="writecontent" id="html_body" name="html_body" rows="5" cols="200"style="display:none" onkeypress="htmleditor.document.body.innerHTML = this.value;"></textarea>
	<iframe id="htmleditor"  name="htmleditor" style="background-color:#FFFFFF; border:1px solid; border-color:#AAAAAA; width:655px; height:500px" scrolling="yes" frameborder="0" marginwidth="5" marginheight="5">
	</iframe>

	<div id="result_autosave" style="font-family:arial; font-weight:bold;">&nbsp;</div>
	</div>

</div>


	<div class="itemWrap" id="item_wrap"></div>



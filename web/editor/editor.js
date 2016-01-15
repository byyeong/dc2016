//
//var isIE  = (document.all) ? true : false;
//var editor_focus = false;
//var palette_mode;
//
//
//function set_editor() {
//	var source = '<style> P { margin: 2px 0 2px 0;} BODY { padding:5px;}h5 {line-height:1.0em;}h4 {line-height:1.5em;}h3 {line-height:2.0em;}</style>';
//	htmleditor.document.designMode = 'On';
//	htmleditor.document.open('text/html');
//	htmleditor.document.write(source);
//	htmleditor.document.close();
//	htmleditor.document.body.style.fontSize = '13px';
//	htmleditor.document.body.style.color = '#404040';
//	htmleditor.document.body.style.fontFamily= 'MS P Gothic, arial';
//	var innerBody = htmleditor.document.body;
//	innerBody.onblur = function() { save_pos(); }
//	innerBody.onfocus = function() { save_pos(); editor_focus = true; }
//
//	htmleditor.focus();
//	
//}
//
//function save_pos() {
//	try { htmleditor.document.currentPos =  htmleditor.document.selection.createRange().duplicate(); }
//	catch(e) { }
//}
//
//function onclick_editor_com(com) {
//	htmleditor.document.execCommand(com, false, null);
//	htmleditor.focus();
//}
//
//function onclick_editor_font(com, obj) {
//       htmleditor.document.execCommand(com, null, obj.value);
//	htmleditor.focus();
//}
//
//function onclick_editor_lh(_v) {
//    document.getElementById("lineheight").style.display = "none";
//    if (!get_selection())
//    {
//        alert("선택 영역이 없습니다.");
//        return;
//    }
//    
//    htmleditor.document.execCommand('FormatBlock', false, "<h6>");
//    
//    var org = htmleditor.document.body.innerHTML;
//    
//    var cnt = 0;
//    
//    org = org.split("</h6><h6>").join("<br/>");
//    org = org.split("</H6><H6>").join("<br/>");
//    while(true)
//    {
//        cnt++;
//        var pos_t1_start = org.indexOf("<h6");
//        var pos_t1_startx = org.indexOf("<H6");
//
//        if (pos_t1_start == -1) pos_t1_start = pos_t1_startx;
//        
//        
//        if (pos_t1_start < 0) break;
//        var pos_t1_end = org.indexOf(">", pos_t1_start);
//
//        var pos_t2_start = org.indexOf("</h6", pos_t1_end);
//        var pos_t2_startx = org.indexOf("</H6", pos_t1_end);
//        if (pos_t2_start == -1 ) pos_t2_start = pos_t2_startx;
//
//        var pos_t2_end = org.indexOf(">", pos_t2_start);
//        
//        var _mid = org.substring(pos_t1_end + 1, pos_t2_start);
//        
//        var org = org.substring(0,pos_t1_start)
//            + "<div style=\"line-height:" + _v + "\">" + _mid + "</div>"
//            + org.substring(pos_t2_end+1);
//    }
//
//    htmleditor.document.body.innerHTML = org;
//    
//}
//
//function display_palette() {
//	document.getElementById('editor_palette').style.display = 'block';
//}
//
//function ck_color(color) {
//	htmleditor.focus();
//	if (palette_mode == '1') {
//		htmleditor.document.execCommand('ForeColor', false, color);
//	} else {
//	       if (isIE){
//			htmleditor.document.execCommand('BackColor', null, color );
//		}else{
//			htmleditor.document.execCommand('hilitecolor', null, color );
//		}
//	}
//	document.getElementById('editor_palette').style.display = 'none';
//}
//
//function set_emoticon(src) {
//	if (isIE) {
//		var sText = htmleditor.document.currentPos;
//		if (!sText) return false;
//		htmleditor.document.body.focus();
//		sText.pasteHTML('<img src="'+src+'" align="absmiddle">');
//		sText.select();
//	} else {
//		htmleditor.focus();
//		htmleditor.document.execCommand('insertHTML', false, '<img src="'+src+'" align="absmiddle">');
//		htmleditor.focus();
//	}
//}
//
//function set_image(server, path, width, position, caption) {
//	var position_str = '';
//	switch (position) {
//		case '1': position_str = 'left'; break;
//		case '2': position_str = 'center'; break;
//		case '3': position_str = 'right'; break;
//	}
//	
//		if(caption) {
//			paste_HTML('<div align="'+position_str+'"><img src="/'+path+'"><p style="text-align:center;">'+caption+'</p></div>');
//		} else {
//			paste_HTML('<div align="'+position_str+'"><img src="/'+path+'"></div>');
//		}
//		var imgs = document.getElementById('htmleditor').contentWindow.document.getElementsByTagName("IMG");
//
//        for (var i = 0; i < imgs.length; ++i) {
//            if (window.addEventListener) {             //firefox
//            	imgs[i].addEventListener("click", function(e) { show_img_prop(this); }, false);
//            }
//            else if (window.attachEvent) {               //IE
//                imgs[i].attachEvent("click", function(e) { show_img_prop(this); }, false);
//            }
//        }
//
//}
//
//var last_ip = null;
//function show_img_prop(_tgt)
//{
//    div_open("image_prop");
//    last_ip = _tgt;
//    document.getElementById("img_width").value = _tgt.width;
//    document.getElementById("img_height").value = _tgt.height;
//    
//}
//
//function set_image_width()
//{
//    last_ip.width = document.getElementById("img_width").value;
//    last_ip.height = document.getElementById("img_height").value;
//}
//
//function onclick_attach_image() {
//	window.open('/tf_editor/editor_add_image/','a_i','width=400,height=370');
//	
//}
//function onclick_add_movie() {
//
//    
//	window.open('/tf_editor/editor_add_movie/','a_i','width=400,height=370');
//	
//}
//
//function onclick_add_link() {
//		//htmleditor.document.execCommand('CreateLink');
//	window.open('/tf_editor/editor_add_link/','a_i','width=400,height=220');
//		//var sText = htmleditor.document.currentPos;
//		//sText.pasteHTML('<a href=#>' + sText.text + '</a>');
//}
//
//var id_remarks = 0;
//function onclick_add_remarks() {
//    if (!get_selection()) alert("선택 영역이 없습니다.");
//    
//    var _id = id_remarks;
//		//htmleditor.document.execCommand('CreateLink');
//	window.open('/tf_editor/editor_add_remarks/?id=' + _id,'a_i','width=400,height=220');
//		//var sText = htmleditor.document.currentPos;
//		//sText.pasteHTML('<a href=#>' + sText.text + '</a>');
//}
//
//function get_selection()
//{
//	if (isIE) {
//		var sText = htmleditor.document.currentPos;
//		if (!sText) return false;
//		htmleditor.document.body.focus();
//		return (htmleditor.document.selection.createRange().text);
//	} else {
//		 
//		var range = document.getElementById('htmleditor').contentWindow.getSelection().getRangeAt(0) 
//        
//        if (!range) return false;
//		htmleditor.focus();
//		return (range.toString());
//
//	}
//}
//
//
//function paste_HTML(_str)
//{
//	if (isIE) {
//        document.getElementById('htmleditor').contentWindow.focus();
//        
//        var imgIns =document.frames["htmleditor"].document.selection.createRange();
//        
//        
//        imgIns.pasteHTML(_str);
//	} else {
//		 
//        var range = document.getElementById('htmleditor').contentWindow.getSelection().getRangeAt(0) 
//
//		htmleditor.focus();
//		var _mid = range.toString();
//		htmleditor.document.execCommand('insertHTML', false, _str);
//		htmleditor.focus();
//
//	}    
//}
//
//function set_remarks(_str, _id)
//{
//	if (isIE) {
//		var sText = htmleditor.document.currentPos;
//		
//		if (!sText) return false;
//		htmleditor.document.body.focus();
//		sText.pasteHTML("<a href=\"#\" tag=\"" + _str + "\">" +  htmleditor.document.selection.createRange().text + "</a>");
//		sText.select();
//	} else {
//		 
//		 var range = document.getElementById('htmleditor').contentWindow.getSelection().getRangeAt(0) 
//
//		htmleditor.focus();
//		htmleditor.document.execCommand('insertHTML', false, "<a href=\"#\" tag=\"" + _str + "\">" + range.toString() + "</a>");
//		htmleditor.focus();
//
//	}
//}
//
//function set_movie(_src)
//{
//    paste_HTML('<div><img src="/admin/editor/movie.jpg" tag="' + _src + '"></div>');
//}
//
//
//function gotolink(urlto,optionStr) {
//	if (isIE) {
//		var sText = htmleditor.document.currentPos;
//		
//		if (!sText) return false;
//		htmleditor.document.body.focus();
//		sText.pasteHTML("<A href=\"" + urlto + "\" " + optionStr + ">" +  htmleditor.document.selection.createRange().text + "</A>");
//		sText.select();
//	} else {
//		 
//		var range = document.getElementById('htmleditor').contentWindow.getSelection().getRangeAt(0);
//
//		htmleditor.focus();
//		htmleditor.document.execCommand('insertHTML', false, "<A href=\"" + urlto + "\" " + optionStr + ">" + range.toString() + "</A>");
//		htmleditor.focus();
//
//	}
//		 
//		 
//}
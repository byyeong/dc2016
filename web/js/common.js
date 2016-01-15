var _duration = 1000;

function check_email_spec(email)
{
      var pattern = /^(.+)@(.+)$/;
      var atom = "\[^\\s\\(\\)<>#@,;:!\\\\\\\"\\.\\[\\]\]+";
      var word="(" + atom + "|(\"[^\"]*\"))";
      var user_pattern = new RegExp("^" + word + "(\\." + word + ")*$");
      var ip_pattern = /^\[(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\]$/;
      var domain_pattern = new RegExp("^" + atom + "(\\." + atom +")*$");

      var arr = email.match(pattern);
      if (!arr) return false;
      if (!arr[1].match(user_pattern)) return false;

      var ip = arr[2].match(ip_pattern);
      if (ip) {
              for (var i=1; i<5; i++) if (ip[i] > 255) return false;
      }
      else {
              if (!arr[2].match(domain_pattern)) return false;
              var domain = arr[2].match(new RegExp(atom,"g"));
              if (domain.length<2) return false;
              if (domain[domain.length-1].length<2 || domain[domain.length-1].length>4)
                    return false;
      }
      return true;
}

function show_login(_skey)
{
    $('#loginForm').slideToggle('fast')
    //document.getElementById("loginframe").src = "/login2/";
    var _url = parent.location.href;
    if (_url.indexOf("#") > 0)
    {
        var _pos = _url.indexOf("#");
        _url = _url.substr(0,_pos);
    }
    
    //document.getElementById("loginframe").src = "http://apis.userstory.net/login/userstorybook/?from=frame&sk=" + _skey + "&to_url=" + _url;
    document.getElementById("loginframe").src = "http://apis.userstory.net/login/userstorybook/?from=frame&sk=" + _skey + "&to_url=" + _url;
}


function isNumeric(sText)

{
   var ValidChars = "0123456789.";
   var IsNumber=true;
   var Char;

 
   for (i = 0; i < sText.length && IsNumber == true; i++) 
      { 
      Char = sText.charAt(i); 
      if (ValidChars.indexOf(Char) == -1) 
         {
         IsNumber = false;
         }
      }
   return IsNumber;
   
   }

function offsetTop(_id)
{
    x = document.getElementById(_id);
    var _top = x.offsetTop;
    
    while(x.offsetParent)
    {
        x = x.offsetParent;
        _top += x.offsetTop;
    }
    
    return _top;
}

function offsetLeft(_id)
{
    x = document.getElementById(_id);
    var _left = x.offsetLeft;
    
    while(x.offsetParent)
    {
        x = x.offsetParent;
        _left += x.offsetLeft;
    }
    
    return _left;
}

function httpcall_post(_hc_url, _query, _hcactionfunction)
{
    var xh_rel;
	if (window.ActiveXObject)
	{
		xh_rel = new ActiveXObject("Microsoft.XMLHTTP");
	}
	else if (window.XMLHttpRequest)
	{
		xh_rel = new XMLHttpRequest();
	}    

	xh_rel.onreadystatechange = function ()
    {
        _hcactionfunction(xh_rel);
    }

    
	xh_rel.open("POST", _hc_url, true);
	xh_rel.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xh_rel.setRequestHeader("Content-length", _query.length);
    xh_rel.setRequestHeader("Connection", "close");
    xh_rel.send(_query);

}

function httpcall(_hc_url, _hcactionfunction)
{
    var xh_rel;
	if (window.ActiveXObject)
	{
		xh_rel = new ActiveXObject("Microsoft.XMLHTTP");
	}
	else if (window.XMLHttpRequest)
	{
		xh_rel = new XMLHttpRequest();
	}    

	xh_rel.onreadystatechange = function ()
    {
        _hcactionfunction(xh_rel);
    }
    
	xh_rel.open("GET", _hc_url, true);
	xh_rel.send(null);

}

function httpcall_ajax(_hc_url, _hcactionfunction, _hcerrorfunction)
{
    var xh_rel;
	if (window.ActiveXObject)
	{
		xh_rel = new ActiveXObject("Microsoft.XMLHTTP");
	}
	else if (window.XMLHttpRequest)
	{
		xh_rel = new XMLHttpRequest();
	}    

	xh_rel.onreadystatechange = function ()
    {
    	if(xh_rel && xh_rel.readyState == 4)
    	{
    		if(xh_rel.status == 200)
    		{
                var ret = new Ajaxrslt(xh_rel.responseText);
                _hcactionfunction(ret);
    		}
    		else if(xh_rel.status == 500 || xh_rel.status == 403 || xh_rel.status == 404)
    		{
    		    _hcerrorfunction();
    		}
    	}
    }
    
	xh_rel.open("GET", _hc_url, true);
	xh_rel.send(null);

}

function httpcall_return_arg(_hc_url, _hcactionfunction, _hcerrorfunction, _arg)
{
    var xh_rel;
	if (window.ActiveXObject)
	{
		xh_rel = new ActiveXObject("Microsoft.XMLHTTP");
	}
	else if (window.XMLHttpRequest)
	{
		xh_rel = new XMLHttpRequest();
	}    

	xh_rel.onreadystatechange = function ()
    {
    	if(xh_rel && xh_rel.readyState == 4)
    	{
    		if(xh_rel.status == 200)
    		{
                _hcactionfunction(xh_rel, _arg);
    		}
    		else if(xh_rel.status == 500 || xh_rel.status == 403 || xh_rel.status == 404)
    		{
    		    _hcerrorfunction(_arg, xh_rel.status);
    		}
    	}
    }
    
	xh_rel.open("GET", _hc_url, true);
	xh_rel.send(null);
}

function httpcall_ajax_post(_hc_url, _query, _hcactionfunction, _hcerrorfunction)
{
    var xh_rel;
	if (window.ActiveXObject)
	{
		xh_rel = new ActiveXObject("Microsoft.XMLHTTP");
	}
	else if (window.XMLHttpRequest)
	{
		xh_rel = new XMLHttpRequest();
	}    
    
	xh_rel.onreadystatechange = function ()
    {
    	if(xh_rel && xh_rel.readyState == 4)
    	{
    		if(xh_rel.status == 200)
    		{
                var ret = new Ajaxrslt(xh_rel.responseText);
                _hcactionfunction(ret);
    		}
    		else if(xh_rel.status == 500 || xh_rel.status == 403 || xh_rel.status == 404)
    		{
    		    _hcerrorfunction();
    		}
    	}
    }
    
	xh_rel.open("POST", _hc_url, true);
	xh_rel.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xh_rel.setRequestHeader("Content-length", _query.length);
    xh_rel.setRequestHeader("Connection", "close");
    xh_rel.send(_query);


}

function httpcall_html(_hc_url, _hcactionfunction)
{
    var xh_rel;
	if (window.ActiveXObject)
	{
		xh_rel = new ActiveXObject("Microsoft.XMLHTTP");
	}
	else if (window.XMLHttpRequest)
	{
		xh_rel = new XMLHttpRequest();
	}    

	xh_rel.onreadystatechange = function ()
    {
    	if(xh_rel && xh_rel.readyState == 4)
    	{
    		if(xh_rel.status == 200)
    		{
    			_hcactionfunction(xh_rel.responseText);
    		}
    	}
    }
    
	xh_rel.open("GET", _hc_url, true);
	xh_rel.send(null);

}

function httpcall_html2(_hc_url, _hcactionfunction, _av)
{
    var xh_rel;
	if (window.ActiveXObject)
	{
		xh_rel = new ActiveXObject("Microsoft.XMLHTTP");
	}
	else if (window.XMLHttpRequest)
	{
		xh_rel = new XMLHttpRequest();
	}    

	xh_rel.onreadystatechange = function ()
    {
    	if(xh_rel && xh_rel.readyState == 4)
    	{
    		if(xh_rel.status == 200)
    		{
    			_hcactionfunction(xh_rel.responseText, _av);
    		}
    	}
    }
    
	xh_rel.open("GET", _hc_url, true);
	xh_rel.send(null);

}

function httpcall_html_post(_hc_url, _query, _hcactionfunction)
{
    var xh_rel;
	if (window.ActiveXObject)
	{
		xh_rel = new ActiveXObject("Microsoft.XMLHTTP");
	}
	else if (window.XMLHttpRequest)
	{
		xh_rel = new XMLHttpRequest();
	}    

	xh_rel.onreadystatechange = function ()
    {
    	if(xh_rel && xh_rel.readyState == 4)
    	{
    		if(xh_rel.status == 200)
    		{
    			_hcactionfunction(xh_rel.responseText);
    		}
    	}
    }

    
	xh_rel.open("POST", _hc_url, true);
	xh_rel.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xh_rel.setRequestHeader("Content-length", _query.length);
    xh_rel.setRequestHeader("Connection", "close");
    xh_rel.send(_query);

}


function httpcall_html_return_arg(_hc_url, _hcactionfunction, _arg)
{
    var xh_rel;
	if (window.ActiveXObject)
	{
		xh_rel = new ActiveXObject("Microsoft.XMLHTTP");
	}
	else if (window.XMLHttpRequest)
	{
		xh_rel = new XMLHttpRequest();
	}    

	xh_rel.onreadystatechange = function ()
    {
    	if(xh_rel && xh_rel.readyState == 4)
    	{
    		if(xh_rel.status == 200)
    		{
    			_hcactionfunction(xh_rel.responseText, _arg);
    		}
    	}
    }
    
	xh_rel.open("GET", _hc_url, true);
	xh_rel.send(null);

}

function cut(org, maxlen)
{
    if (org.length > maxlen)
        return org.substr(0, maxlen-2) + "..";
    
        
    return org;
}


var act_function;
function yesno(msg, action_function)
{
    act_function = action_function;
    msg = msg + "<span class='yesno'><a href='#' onclick=\"yesno_yes();return false;\">네!</a> <a href='#' onclick=\"yesno_no();return false;\">아니요.</a></span>";
    document.getElementById("div_yesno_inner").innerHTML = msg;


    var t = $(window).scrollTop();
    var l = document.documentElement.scrollLeft;
    document.getElementById("div_yesno").style.top = t + "px";
    document.getElementById("div_yesno").style.left = l + "px";
	$("#div_yesno").fadeIn('normal');

    
}

function clear_input(_id,_def)
{
    var t = document.getElementById(_id);
    if (t.value === _def) t.value = "";
}

function yesno_yes()
{
    act_function();
	$("#div_yesno").fadeOut('normal');
}

function yesno_no()
{
	$("#div_yesno").fadeOut('normal');
}



function to_HTML(org)
{
    org = org.split("&").join("&amp;");
    org = org.split(">").join("&gt;");
    org = org.split("<").join("&lt;");
    org = org.split(" ").join("&nbsp;");
    org = org.split("\"").join("&quot;");
    return org.split("\n").join("<br />");
}

function addBR(org)
{
    return org.split("\n").join("<br />");
}

function to_plain(org)
{
    org = org.split("<br />").join("\n");
    org = org.split("<br/>").join("\n");
    org = org.split("&lt;").join("<");
    org = org.split("&gt;").join(">");
    org = org.split("&nbsp;").join(" ");
    org = org.split("&amp;").join("&");
    return org.split("<br>").join("\n");
}

function addslashes(org)
{
    org.split("\\").join("\\\\");
    org = org.split("\"").join("\\\"");
    return org = org.split("\'").join("\\\'");
}

function addslashes2(org)
{
    org.split("\\").join("\\\\");
    org = org.split("\n").join("\\n");
    org = org.split("\"").join("&quot;");
    return org = org.split("\'").join("\\\'");
}

function div_close(div_name)
{
    if (document.getElementById(div_name))
        document.getElementById(div_name).style.display = "none";
}

function div_open(div_name)
{
    if (document.getElementById(div_name))
        document.getElementById(div_name).style.display = "block";
}

function toggle(div_name)
{
    if (document.getElementById(div_name).style.display === "none")
    {
        document.getElementById(div_name).style.display = "block";
    }
    else
    {
        document.getElementById(div_name).style.display = "none";
    }
}

function trim(value) {
    return value.replace(/^\s+|\s+$/g,"");
}

function trimVentus(value) {
    return value.replace(/\s+|\s+$/g, "");
}

function get_status_res(_res)
{
    
    if (_res !== "")
        show_and_fadeout_status(_res,1000);
        
}

function selectAll(where, like, count)
{
    var i;
    for (i=1;i<= count;i++)
    {
        document.getElementById(where + "_" + i).checked = document.getElementById(like).checked;
    }
    
}

function getTimeStamp() {
  var d = new Date();

  var s =
    leadingZeros(d.getFullYear(), 4) + '-' +
    leadingZeros(d.getMonth() + 1, 2) + '-' +
    leadingZeros(d.getDate(), 2) + ' ' +

    leadingZeros(d.getHours(), 2) + ':' +
    leadingZeros(d.getMinutes(), 2) + ':' +
    leadingZeros(d.getSeconds(), 2);

  return s;
}



function leadingZeros(n, digits) {
  var zero = '';
  n = n.toString();

  if (n.length < digits) {
    for (i = 0; i < digits - n.length; i++)
      zero += '0';
  }
  return zero + n;
}

var fadeout_counter = 0;

function show_and_fadeout_status(text, duration)
{
    var t = $(window).scrollTop();
    var l = document.documentElement.scrollLeft;
    document.getElementById("div_status_inner").innerHTML = text;
	$("#div_status").slideDown('normal');
//    document.getElementById("div_status").style.display = "block";
    document.getElementById("div_status").style.top = t + "px";
    document.getElementById("div_status").style.left = l + "px";
    
    fadeout_counter = (duration / 10) + 100;
    fade_out();
}

function fade_out()
{
    fadeout_counter--;
//    document.getElementById("div_status").style.opacity = fadeout_counter * 0.01;
//    document.getElementById("div_status").style.filter = "Alpha(opacity=" + fadeout_counter +");";
    if (fadeout_counter>0) setTimeout(fade_out, 10); else $("#div_status").fadeOut('normal');
//		document.getElementById("div_status").style.display = "none";
}


var Base64 = {

	// private property
	_keyStr : "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",

	// public method for encoding
	encode : function (input) {
		var output = "";
		var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
		var i = 0;

		input = Base64._utf8_encode(input);

		while (i < input.length) {

			chr1 = input.charCodeAt(i++);
			chr2 = input.charCodeAt(i++);
			chr3 = input.charCodeAt(i++);

			enc1 = chr1 >> 2;
			enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
			enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
			enc4 = chr3 & 63;

			if (isNaN(chr2)) {
				enc3 = enc4 = 64;
			} else if (isNaN(chr3)) {
				enc4 = 64;
			}

			output = output +
			this._keyStr.charAt(enc1) + this._keyStr.charAt(enc2) +
			this._keyStr.charAt(enc3) + this._keyStr.charAt(enc4);

		}

		return output;
	},
	// public method for decoding
	decode : function (input) {
		var output = "";
		var chr1, chr2, chr3;
		var enc1, enc2, enc3, enc4;
		var i = 0;

		input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");

		while (i < input.length) {

			enc1 = this._keyStr.indexOf(input.charAt(i++));
			enc2 = this._keyStr.indexOf(input.charAt(i++));
			enc3 = this._keyStr.indexOf(input.charAt(i++));
			enc4 = this._keyStr.indexOf(input.charAt(i++));

			chr1 = (enc1 << 2) | (enc2 >> 4);
			chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
			chr3 = ((enc3 & 3) << 6) | enc4;

			output = output + String.fromCharCode(chr1);

			if (enc3 != 64) {
				output = output + String.fromCharCode(chr2);
			}
			if (enc4 != 64) {
				output = output + String.fromCharCode(chr3);
			}

		}

		output = Base64._utf8_decode(output);

		return output;

	},

	// private method for UTF-8 encoding
	_utf8_encode : function (string) {
		string = string.replace(/\r\n/g,"\n");
		var utftext = "";

		for (var n = 0; n < string.length; n++) {

			var c = string.charCodeAt(n);
            if (c < 128) {
				utftext += String.fromCharCode(c);
			}
			else if((c > 127) && (c < 2048)) {
				utftext += String.fromCharCode((c >> 6) | 192);
				utftext += String.fromCharCode((c & 63) | 128);
			}
			else {
				utftext += String.fromCharCode((c >> 12) | 224);
				utftext += String.fromCharCode(((c >> 6) & 63) | 128);
				utftext += String.fromCharCode((c & 63) | 128);
			}

		}

		return utftext;
	},

	// private method for UTF-8 decoding
	_utf8_decode : function (utftext) {
		var string = "";
		var i = 0;
		var c = c1 = c2 = 0;

		while ( i < utftext.length ) {

			c = utftext.charCodeAt(i);

			if (c < 128) {
				string += String.fromCharCode(c);
				i++;
			}
			else if((c > 191) && (c < 224)) {
				c2 = utftext.charCodeAt(i+1);
				string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
				i += 2;
			}
			else {
				c2 = utftext.charCodeAt(i+1);
				c3 = utftext.charCodeAt(i+2);
				string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
				i += 3;
			}

		}

		return string;
	},
	
	URLEncode : function (string) {   
	    _t = escape(this._utf8_encode(string));
	    _t = _t.split("+").join("%2B");
        return _t;
    },   
  
    // public method for url decoding   
    URLDecode : function (string) {   
        return this._utf8_decode(unescape(string));   
    }
}




var JINDO = new Object();
JINDO.xml2obj = function(xml)
{
 var obj = {}, que = [], depth = 0;

 // attribute를 해석하기 위한 함수 
 var parse_attr = function(oobj, str) {
  str.replace(/([^=\s]+)\s*=\s*"([^"]*)"/g, function(a0,a1,a2) {
   oobj[a1] = a2;
  });
 }
 
 // 주석, XML선언, 태그 사이 공백 등의 의미 없는 코드를 삭제
 xml = xml.replace(/<(\?|\!-)[^>]*>/g,'').replace(/>\s+</g, '><');
 
 // 하위 노드가 없는 태그는 하나의 닫힌 태그로 수정
 xml = xml.replace(/<([^!][^ >]+)(\s[^>]*)?><\/\1>/g, '<$1$2 />').replace(/^\s+|\s+$/g, '');

 // 함수 객체를 정규 표현식 처리의 인자로 줘서 iterator로 사용
 xml = xml.replace(/<\/?([^\!][^ >]*)(\s[^>]*)?>(<\/$1>|<\!\[CDATA\[(?:(.|\s)*?)\]\]>|[^<>]*)/g, function(a0,a1,a2,a3)
 {
  // IE에서 일치하는 내용이 없으면 undefined로 전달되므로
  // 빈 문자열로 변경해 다른 브라우저와의 호환성을 맞춤
  if (typeof a1 === 'undefined') a1 = '';
  if (typeof a2 === 'undefined') a2 = '';
  if (typeof a3 === 'undefined') a3 = '';
  
  if (a0.substr(1,1) === '/') { // 현재 태그가 닫는 태그라면,
   // 깊이를 1만큼 감소
   depth--;
  } else if (que.length === 0) { // 객체 큐에 객체가 없다면,
   que[depth] = obj; // 초기의 객체를 큐에 넣고
   parse_attr(obj, a2); // attribute를 해석
  } else {
   var k  = a1, o = {}, is_closed = false;
   
   is_closed = (a2.substr(-1,1) === '/');
   if (a3.length > 0 || is_closed) { // 텍스트 노드가 있다면
    o = a3; // 추가할 객체는 문자열 객체
    
    // CDATA라면 전달받은 그대로 리턴하고
    // 그렇지 않다면 decode 해서 리턴
    if (o.substr(0,9) === '<![CDATA[' && o.substr(-3,3) === ']]>') o = o.substring(9, o.length-3);
    else o = o.replace(/</g, '<').replace(/>/g, '>').replace(/&/g, '&');
   }
   
   // 객체를 할당하기 전에 태그 이름이 이미 존재하는지 살펴보고
   // 이전에 존재하는 태그라면, 배열로 만든다. 이미 배열이라면 현재의 객체를 배열에 추가
   if (typeof que[depth][k] === 'undefined') {
    que[depth][k] = o;
   } else {    
    var v = que[depth][k];
    if (que[depth][k].constructor !== Array) que[depth][k] = [v];
    que[depth][k].push(o);
   }

   // attribute를 해석
   parse_attr(o, a2);
   
   if (!is_closed) que[++depth] = o; 
  }
  
  return '';
 });
 
 return obj;
}



var Ajaxrslt = function(_xml)
{
    if (window.DOMParser)
    {
        parser=new DOMParser();
        this.xmlDoc=parser.parseFromString(_xml,"text/xml");
    }
    else
    {
        this.xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
        this.xmlDoc.async="false";
        this.xmlDoc.loadXML(_xml);
    }
    
    this.org = _xml;
    this.error_code = parseInt( this.get("error_code") );
    this.error_str = this.get("error_str");
    this.result_html = this.get("result_html");
    this.count = parseInt(this.get("count"));
    
};

Ajaxrslt.prototype.get = function(_title)
{
    _res = "";
    _ret = this.xmlDoc.getElementsByTagName(_title);
    if (_ret.length > 0)
        _ret = _ret[0].childNodes;
    
    if (_ret.length > 0)
        _res = _ret[0].nodeValue;
    return _res;
};

// == Custom
function photo_actions(_url, _attr)
{
    $('#'+_attr).attr("value", _url);
}

function del_box(_this)
{
    $(_this).parent().remove();
}

function valid_email(ele) { 
    re=/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; 
    
    // 위의 조건을 만족하려면 최소 6자 이상이어야 함.
    if(ele.value.length<6 || !re.test(ele.value)) { 
        return false; 
    } else { 
        return true; 
    } 
} 

function valid_url(url) {
    var urlPattern = /^(?:(?:ftp|https?):\/\/)?(?:[a-z0-9](?:[-a-z0-9]*[a-z0-9])?\.)+(?:com|edu|biz|org|gov|int|info|mil|net|name|museum|coop|aero|[a-z][a-z])\b(?:\d+)?(?:\/[^;"'<>()\[\]{}\s\x7f-\xff]*(?:[.,?]+[^;"'<>()\[\]{}\s\x7f-\xff]+)*)?/;
    return urlPattern.test(url.toLowerCase());

}

function actions(_thumb, _which) {
	$('#'+_which).val(_thumb);
        $('#'+_which+'_img').attr('src', _thumb);
    
    if (_which == 'top') 
	    toggle_img2();
    else
        toggle_img();
}

function toggle_img() {
    $('#div_img_change').toggle();
}

function toggle_img2() {
    $('.div_img_change2').toggle();
}

//function onlyNumber(obj) {
//    var num_regx=/^[0-9\-]*$/;
//    if( !num_regx.test(obj.value) ) {
//        alert("숫자나 '-'만 입력하세요!");
//        obj.value = obj.value.substring(0, obj.value.length-1 );
//    }
//}

function onlyNumber(obj) {
    var num_regx=/^[0-9\-]*$/;
    if( !num_regx.test(obj.value) ) {
        alert("숫자나 '-'만 입력하세요!");
        obj.value = obj.value.substring(0, obj.value.length-1 );
    }
}

function onlyNumberCom(obj) {
    var num_regx=/^[0-9\:]*$/;
    if( !num_regx.test(obj.value) ) {
        obj.value = obj.value.substring(0, obj.value.length-1 );
    }
}
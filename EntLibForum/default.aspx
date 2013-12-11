﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="yaf._default" %>

<%@ Register Src="Include/pagefooter.ascx" TagName="pagefooter" TagPrefix="uc1" %>
<%@ Register TagPrefix="yaf" Namespace="yaf" Assembly="yaf" %>
<%@ Register TagPrefix="yc" Namespace="yaf.controls" Assembly="yaf" %>
<html>
<head>
    <meta name="Description" content="湖北文化产业网（http://www.hubeici.com）,又名文谷网，由湖北省委宣传部主管、主办，湖北日报传媒集团、湖北省文化产业发展信息中心承办，湖北文谷文化产业发展有限公司运营，是湖北省文化产业公共信息发布平台。" />
    <meta name="Keywords" content="文谷社区 湖北文化产业网" />
    <!-- If you don't want the forum to set the page title, you can remove runat and id -->
    <title>文谷社区</title>
    <asp:Literal ID="Style" runat="Server" />
    <link rel="stylesheet" href="editors/FCKEditorV2/editor/css/forumhot.css" type="text/css" />
    <link rel="stylesheet" href="editors/FCKEditorV2/editor/css/public.css" type="text/css" />
    <link rel="Stylesheet" href="editors/FCKEditorV2/editor/css/NaviTop.css" type="text/css" />

    <script type="text/javascript" src="editors/FCKEditorV2/editor/js/common.js"></script>
    <script type="text/javascript" src="editors/FCKEditorV2/editor/js/slide.js"></script>
    <link rel="shortcut icon" type="image/x-icon" href="images/firstpage/favicon.ico"
        media="screen" />
    <script src="./script/jquery-1.8.2/jquery-1.8.2.js" type="text/javascript"></script>
    <script src="script/slide/jquery.slide.js" type="text/javascript"></script>
    <script src="./script/forum.js" type="text/javascript"></script>
    <link href="script/slide/slide.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function tabselect(id) {
            $('hot_layer_' + id).style.display = ''
            $('tab_li_' + id).className = 'current'
            for (var i = 1; i <= 5; i++) {
                if (i != id) {
                    if ($('tab_li_' + i)) {
                        $('tab_li_' + i).className = 'switchNavItem'
                        $('hot_layer_' + i).style.display = 'none';
                    }
                }
            }
        }
    </script>
    <script type="text/javascript">
        for (var i = 1; i <= 5; i++) {
            try {
                $('hot_layer_' + i).style.display = ''
                $('tab_li_' + i).className = 'current'
                break;
            }
            catch (e) {
                continue;
            }
        }
    </script>
    <script type="text/javascript">
<!--
        var arVersion = navigator.appVersion.split("MSIE");
        var version = parseFloat(arVersion[1]);

        function fixPNG(myImage) {
            if ((version >= 5.5) && (version < 7) && (document.body.filters)) {
                var imgID = (myImage.id) ? "id='" + myImage.id + "' " : "";
                var imgClass = (myImage.className) ? "class='" + myImage.className + "' " : "";
                var imgTitle = (myImage.title) ?
		             "title='" + myImage.title + "' " : "title='" + myImage.alt + "' ";
                var imgStyle = "display:inline-block;" + myImage.style.cssText;
                var strNewHTML = "<span " + imgID + imgClass + imgTitle
                  + " style=\"" + "width:" + myImage.width
                  + "px; height:" + myImage.height
                  + "px;" + imgStyle + ";"
                  + "filter:progid:DXImageTransform.Microsoft.AlphaImageLoader"
                  + "(src=\'" + myImage.src + "\', sizingMethod='scale');\"></span>";
                myImage.outerHTML = strNewHTML;
            }
        }
 -->
    </script>
</head>
<body class="mainbody">
    <div style="text-align: center;">
        <img src="images/firstpage/banner.gif" alt="" style="height: 100px; width: 1002px;" />
    </div>
    <div style="text-align: center;">
        <div class="wrapper" style="width: 1002px; text-align: left;">
            <div class="innerWrapper">
                <ul id="navigator">
                    <li class="youAreHere"><a href="">社区首页 </a><span class="sep">|</span></li>
                    <li><a href="/blog">网站博客 </a><span class="sep">|</span></li>
                    <li><a href="/music">好听音乐 </a><span class="sep">|</span></li>
                    <li><a href="/code">网页特效 </a><span class="sep">|</span></li>
                    <li><a href="/about">关于我们 </a></li>
                </ul>
            </div>
            <div class="shadowWrapper">
            </div>
        </div>
    </div>
    <table width="1002px" cellpadding="3" cellspacing="0" style="background-color: White;"
        align="center">
                <tr>
            <td>
	<div class="w_ctr">
		<div class="JQ-slide">
			<ul class="JQ-slide-content">
				<li><a href="#"><img src="useruploadfiles\admin\image\Desert.jpg" width="297" height="181" alt="asfsdfsafd" /><span>abc</span></a>	</li>
				<li><a href="#"><img src="useruploadfiles\admin\image\2308.jpg" width="297" height="181" alt="ttttttttttt"/><span>ddddd</span></a></li>
				<li><a href="#"><img src="useruploadfiles\admin\image\2304.jpg" width="297" height="181" alt="tttttttt" /><span>ttttttttttt</span></a></li>
				<li><a href="#"><img src="useruploadfiles\admin\image\SQLServerProfiler_demo_2.gif" width="297" height="181" alt="ddddddddddddd" /><span>dddddddddddd</span></a></li>
			</ul>
			<ul class="JQ-slide-nav">
				<li class="on">1</li>
				<li>2</li>
				<li>3</li>
				<li>4</li>
			</ul>
		</div>
	</div>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <form id="Form2" runat="server" enctype="multipart/form-data" class="nomargin">
                <yaf:Forum runat="server" ID="forum" />
                </form>
            </td>
        </tr>

        <tr>
            <td colspan="2">
                <uc1:pagefooter ID="Pagefooter1" runat="server"></uc1:pagefooter>
            </td>
        </tr>
    </table>
</body>
</html>

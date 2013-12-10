<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="yaf._default" %>

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
    <link rel="stylesheet" href="editors/FCKEditorV2/editor/css/public.css" type="text/css" />
    <link rel="Stylesheet" href="editors/FCKEditorV2/editor/css/NaviTop.css" type="text/css" />

    <script type="text/javascript" src="editors/FCKEditorV2/editor/js/jquery.1.4.2-min.js"
        charset="UTF-8"></script>

    <link rel="shortcut icon" type="image/x-icon" href="images/firstpage/favicon.ico"
        media="screen" />

    <script src="./script/jquery-1.8.2/jquery-1.8.2.js" type="text/javascript"></script>
    <script src="./script/forum.js" type="text/javascript"></script>

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
    <div style="text-align:center;">
        <img src="images/firstpage/banner.gif" alt= "" style="height: 100px; width:1002px;" />
    </div>
    <div style=" text-align:center; ">
    <div class="wrapper" style="width:1002px; text-align:left; ">
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

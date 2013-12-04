<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="yaf._default" %>

<%@ Register Src="Include/pagefooter.ascx" TagName="pagefooter" TagPrefix="uc1" %>
<%@ Register TagPrefix="yaf" Namespace="yaf" Assembly="yaf" %>
<%@ Register TagPrefix="yc" Namespace="yaf.controls" Assembly="yaf" %>

<html>
<head>
    <meta name="Description" content="文谷社区，古玩社区" />
    <meta name="Keywords" content="文谷社区，古玩社区" />
    <!-- If you don't want the forum to set the page title, you can remove runat and id -->
    <title>文谷社区，古玩社区</title>
	<asp:Literal id="Style" runat="Server" />
	<link rel="stylesheet" href="../editors/FCKEditorV2/editor/css/public.css" type="text/css" />
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
    <table width="95%" cellpadding="3" cellspacing="0" style="background-color: White;" align="center">
        <tr>
            <td>
                <a href="http://www.hubeici.com">
                    <img src="images/firstpage/banner.gif" runat="server" id="imgBanner" alt="湖北文化产业网" /></a>
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

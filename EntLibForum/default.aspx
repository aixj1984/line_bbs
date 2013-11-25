<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="yaf._default" %>

<%@ Register Src="Include/pagefooter.ascx" TagName="pagefooter" TagPrefix="uc1" %>
<%@ Register TagPrefix="yaf" Namespace="yaf" Assembly="yaf" %>
<%@ Register TagPrefix="yc" Namespace="yaf.controls" Assembly="yaf" %>

<html>
<head>
    <meta name="Description" content="EntLib.com是电子商务解决方案的专业提供商，拥有丰富的经验、成熟的技术、实施方案和成功案例，提供全套的电子商务解决方案，包括定制化开发、实施和培训服务。" />
    <meta name="Keywords" content="专业的电子商务系统, 网上商城, 网上商店, 在线购物平台, 仓库管理系统(Warehouse Management System)" />
    <!-- If you don't want the forum to set the page title, you can remove runat and id -->
    <title>EntLib.com Forum 开源论坛系统::专业电子商务解决方案</title>
	<asp:Literal id="Style" runat="Server" />
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
<body>
    <table cellpadding="3" cellspacing="0" style="width: 1000px; background-color: White;"
        align="center">
        <tr>
            <td>
                <a href="http://www.entlib.com/">
                    <img src="images/entlib.gif" runat="server" id="imgBanner" alt="EntLib.com" /></a>
            </td>
            <td style="text-align: right; vertical-align: bottom; color: #999999; font-size: 12px;">
                基于Microsoft .Net Framework / ASP.Net / C# / AJAX 平台构建的标准电子商务系统
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

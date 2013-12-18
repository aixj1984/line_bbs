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
    <link rel="stylesheet" href="editors/FCKEditorV2/editor/css/forumhot.css" type="text/css" />
    <link rel="stylesheet" href="editors/FCKEditorV2/editor/css/public.css" type="text/css" />
    <link rel="Stylesheet" href="editors/FCKEditorV2/editor/css/NaviTop.css" type="text/css" />
    <script type="text/javascript" src="script/common.js"></script>
    <link rel="stylesheet" href="css/firstpage/index_v7.css" type="text/css" />

    <script type="text/javascript" src="script/slide.js"></script>
    <link rel="shortcut icon" type="image/x-icon" href="images/firstpage/favicon.ico"
        media="screen" />
    <script src="./script/jquery-1.8.2/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="script/slide/jquery.slide.js" type="text/javascript"></script>
    <script src="./script/forum.js" type="text/javascript"></script>
    <link href="script/slide/slide.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function tabselect(id) {
            GetId('hot_layer_' + id).style.display = ''
            GetId('tab_li_' + id).className = 'current'
            for (var i = 1; i <= 3; i++) {
                if (i != id) {
                    if (GetId('tab_li_' + i)) {
                        GetId('tab_li_' + i).className = 'switchNavItem'
                        GetId('hot_layer_' + i).style.display = 'none';
                    }
                }
            }
        }
    </script>
    
    <script type="text/javascript">

    </script>
</head>
<body class="mainbody">
    <div style="text-align: center;background: url('images/firstpage/top_back.jpg') repeat-x scroll 0% 0% transparent;">
        <img src="images/firstpage/banner.gif" alt="" style="height: 100px; width: 1002px;" />
    </div>
<%--    <div style=" width: 100%;background: url('images/firstpage/导航.gif') repeat-x scroll 0% 0% transparent; height:40px;margin-top:-3px;">
        <div  style="width: 1002px;margin: 0 auto;  text-align:left;">
            <div class="innerWrapper">
                <ul id="navigator">
                    <li class="youAreHere"><a href="default.aspx?g=forum">社区首页</a></li>
                    <li class="youAreHere"><a href="http://www.hubeici.com/index.shtml">文谷首页</a></li>
                    <li class="youAreHere"><a href="http://www.hubeici.com/about_us">关于我们</a></li>
                </ul>
            </div>
        </div>
    </div>--%>
    <span id="Span1" runat="server"></span>
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
    <script type="text/javascript">
        for (var i = 1; i <= 3; i++) {
            try {
                GetId('hot_layer_' + i).style.display = ''
                GetId('tab_li_' + i).className = 'current'
                break;
            }
            catch (e) {
                continue;
            }
        }
    </script>
</body>
</html>

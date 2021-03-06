<%@ Control Language="c#" CodeBehind="forum.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.forum" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>
<%@ Register TagPrefix="yaf" TagName="ForumList" Src="../controls/ForumList.ascx" %>
<META content="Yes" http-equiv="MSThemeCompatible"><LINK rel="stylesheet" type="text/css" 
href="css/style_4_common.css"><LINK rel="stylesheet" 
type="text/css" href="css/style_4_forum_index.css">
<style type="text/css">
    .forum_table
    {
        border: 1px solid rgb(68, 68, 68);
        border-collapse: collapse;
        width: 100%;
    }
    .tbody_tr
    {
        text-align: left;
        border-top-color: rgb(205, 205, 205);
        _display: inline-block; /*针对ie6*/
          border-top-width: 1px; 
         border-top-style: dashed;       
        line-height: 20px;
    }
    .notopic
    {
        width: 5%;
        height: 80px;
                border-top-color: rgb(205, 205, 205);
        _display: inline-block; /*针对ie6*/
          border-top-width: 1px; 
         border-top-style: dashed;     
        
    }
    .notoinfo
    {
        width: 40%;
        margin: 0px;
        padding: 0px;
        overflow: hidden;
        background-repeat: no-repeat;
        background-position: 8px 50%;
        font-weight: normal;
        text-align: left;
        border-top-color: rgb(205, 205, 205);
        _display: inline-block; /*针对ie6*/
          border-top-width: 1px; 
        border-top-style: dashed;     
    }
    .th_h2
    {
        font-size: 12px;
        margin: 0px;
        padding: 0px;
        display: block;
        -webkit-margin-after: 0.83em;
        -webkit-margin-start: 0px;
        -webkit-margin-end: 0px;
        font-weight: bold;
    }
    .th_h2_a
    {
        color: rgb(51, 51, 51);
        text-decoration: none;
        font-size: 14px;
    }
    .th_h2_em
    {
        font-style: normal;
        font-weight: 400;
        font-size: 12px;
        
    }
    .th_h2_em_strong
    {
        color: rgb(242, 108, 79);
    }
    .th_p
    {
        color: rgb(51, 51, 51);
        text-decoration: none;
        font: 12px/1.5 ,Helvetica,Arial,sans-serif;
        font-size: 12px;
        font-weight: normal;
        margin: 0px;
        padding: 0px;
    }
    .th_p_a
    {
        color: rgb(51, 51, 51);
        text-decoration: none;
        font-size: 12px;
    }
    .title_bar
    {
        background-image: url(images/hotbg.png);
        height: 30px;
        line-height: 30px;
        border-top: 1px solid #DCDCDC;
        padding-left: 0px;
    }
    .th_p_em
    {
        font-family: "微软雅黑",Arial;
        font-style: normal;
    }
</style>
<div>
    <asp:Label ID="lblHotInfo" runat="server" Text=""></asp:Label>
</div>
<yaf:PageLinks runat="server" ID="PageLinks" />
<div id="Welcome" runat="server">
    <%--    &nbsp;<img src="../images/common/arrow2.gif" alt="" />&nbsp;<asp:Label ID="TimeNow"
        runat="server" />
    <span style="padding-left: 20px;">
        <img src="../images/common/arrow2.gif" alt="" />
        <asp:Label ID="TimeLastVisit" runat="server" /></span>--%>
</div>
<%--<div id="divUnreadMsgs"><asp:HyperLink runat="server" ID="UnreadMsgs" Visible="true" /></div>--%>
<!--topic-->
<div class="main" id="wp" style="width: 1002px;">
    <div class="mainbox" id="category_forum">
        <%--<div class="titlebar" style="height: 39px; background-image: url('images/firstpage/产业专区.gif');
            background-repeat: no-repeat;">
        </div>
        <div id="category_69" class="fi" style="">
            <table cellspacing="0" cellpadding="0" class="forum_table">
                <tbody>
                    <tr class="tbody_tr">
                        <th class="notopic">
                            <img src="../images/ForumIcons/forumicon_235.jpg" border="0" align="left" hspace="5"
                                style="margin-left: 0px; float: left;" alt="攻城掠地" />
                        </th>
                        <th class="notoinfo">
                            <h2 class="th_h2">
                                <a href="#" class="th_h2_a">攻城掠地</a> <em class="th_h2_em">(今日:<strong class="th_h2_em_strong">12</strong>)</em>
                            </h2>
                            <p class="th_p">
                                主题:455, 帖数:1333</p>
                            <p class="th_p">
                                最后: <a href="#" title="酷玩吧【攻城掠地】30区论坛活动" class="th_p_a"><em class="th_p_em">1小时前</em></a>
                                by <a class="th_p_a" href="#" target="_blank">game9090</a>
                            </p>
                        </th>
                        <th style="width: 20%;" class="notopic ">
                            <img src="../images/ForumIcons/forumicon_214.jpg" border="0" align="left" hspace="5"
                                alt="斗破乾坤" />
                        </th>
                        <th class="notoinfo">
                            <h2 class="th_h2">
                                <a href="#" class="th_h2_a">攻城掠地</a> <em class="th_h2_em">(今日:<strong class="th_h2_em_strong">12</strong>)</em>
                            </h2>
                            <p class="th_p">
                                主题:455, 帖数:1333</p>
                            <p class="th_p">
                                最后: <a href="#" title="酷玩吧【攻城掠地】30区论坛活动" class="th_p_a"><em class="th_p_em">1小时前</em></a>
                                by <a class="th_p_a" href="#" target="_blank">game9090</a>
                            </p>
                        </th>
                    </tr>
                </tbody>
                <tbody>
                    <tr class="tbody_tr">
                        <th class="notopic">
                            <img src="../images/ForumIcons/forumicon_235.jpg" border="0" align="left" hspace="5"
                                style="margin-left: 0px; float: left;" alt="攻城掠地" />
                        </th>
                        <th class="notoinfo">
                            <h2 class="th_h2">
                                <a href="#" class="th_h2_a">攻城掠地</a> <em class="th_h2_em">(今日:<strong class="th_h2_em_strong">12</strong>)</em>
                            </h2>
                            <p class="th_p">
                                主题:455, 帖数:1333</p>
                            <p class="th_p">
                                最后: <a href="#" title="酷玩吧【攻城掠地】30区论坛活动" class="th_p_a"><em class="th_p_em">1小时前</em></a>
                                by <a class="th_p_a" href="#" target="_blank">game9090</a>
                            </p>
                        </th>
                        <th style="width: 20%;" class="notopic ">
                            <img src="../images/ForumIcons/forumicon_214.jpg" border="0" align="left" hspace="5"
                                alt="斗破乾坤" />
                        </th>
                        <th class="notoinfo">
                            <h2 class="th_h2">
                                <a href="#" class="th_h2_a">攻城掠地</a> <em class="th_h2_em">(今日:<strong class="th_h2_em_strong">12</strong>)</em>
                            </h2>
                            <p class="th_p">
                                主题:455, 帖数:1333</p>
                            <p class="th_p">
                                最后: <a href="#" title="酷玩吧【攻城掠地】30区论坛活动" class="th_p_a"><em class="th_p_em">1小时前</em></a>
                                by <a class="th_p_a" href="#" target="_blank">game9090</a>
                            </p>
                        </th>
                    </tr>
                </tbody>
            </table>
        </div>--%>
    </div>
</div>
<!--topic-->
<%--
<asp:Repeater ID="CategoryList" runat="server" OnItemCommand="categoryList_ItemCommand"
    OnItemDataBound="CategoryList_ItemDataBound">
    <HeaderTemplate>
        <table class="content" cellspacing="1" cellpadding="0" width="100%">
            <tr>
                <td class="header1" width="50px">
                    &nbsp;
                </td>
                <td class="header1" width="320px" align="left">
                    <%# GetText("FORUM") %>
                </td>
                <td class="header1" align="center" width="80px">
                    <%# GetText("topics") %>
                </td>
                <td class="header1" align="center" width="80px">
                    <%# GetText("posts") %>
                </td>
                <td class="header1" align="center" width="310px">
                    <%# GetText("lastpost") %>
                </td>
                <td class="header1" align="center" width="155px">
                    论坛图标
                </td>
            </tr>
    </HeaderTemplate>
    <ItemTemplate>
        <tr>
            <td class="header2" colspan="6"  style="<%# yaf.Forum.GetForumIconPath(DataBinder.Eval(Container.DataItem, "IconName"))%>">
            </td>
        </tr>
        <tr>
            <td class="header2" colspan="6" style="background-image: url('images/firstpage/产业专区.gif');background-repeat: no-repeat;" >
                <asp:ImageButton runat="server" ID="expandCategory" BorderWidth="0" ImageAlign="Baseline"
                    CommandName="panel" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "CategoryID") %>'>
                </asp:ImageButton>
                &nbsp;&nbsp; <a href='<%# yaf.Forum.GetLink(yaf.Pages.forum,"c={0}",DataBinder.Eval(Container.DataItem, "CategoryID")) %>'>
                    <%# DataBinder.Eval(Container.DataItem, "Name") %>
                </a>
            </td>
        </tr>
        <yaf:ForumList runat="server" Visible="true" ID="forumList" DataSource='<%# ((System.Data.DataRowView)Container.DataItem).Row.GetChildRows("FK_Forum_Category") %>' />
    </ItemTemplate>
    <FooterTemplate>
        </table>
    </FooterTemplate>
</asp:Repeater>--%>
<%--<hr />--%>
<!---ad-text area start--->
<asp:Label ID="lblForumAd" runat="server" Text="欢迎访问文谷论坛！"></asp:Label>
<!---ad-text area end--->
<div style="height: 39px; width: 100%; margin-top: 2px; background-image: url('images/firstpage/站点统计.gif')">
</div>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
    <tr>
        <td width="49%" valign="top">
            <table class="content" cellspacing="1" cellpadding="0" width="500px;">
                <tbody id="InformationTBody" runat="server">
                    <tr >
                        <td class="header2" colspan="2">
                            <%= GetText("ACTIVE_USERS") %>
                        </td>
                    </tr>
                    <tr >
                        <td class="post" width="40px;" align="center">
                            <img src="<%# GetThemeContents("ICONS","FORUM_USERS") %>" alt="" />
                        </td>
                        <td class="post" height="65px;">
                            <asp:Label runat="server" ID="activeinfo" /><br />
                            <asp:Repeater runat="server" ID="ActiveList">
                                <ItemTemplate>
                                    <a href='<%#yaf.Forum.GetLink(yaf.Pages.profile,"u={0}",DataBinder.Eval(Container.DataItem, "UserID"))%>'>
                                        <%# Server.HtmlEncode(Convert.ToString(DataBinder.Eval(Container.DataItem, "Name"))) %>
                                    </a>
                                </ItemTemplate>
                                <SeparatorTemplate>
                                    ,
                                </SeparatorTemplate>
                            </asp:Repeater>
                        </td>
                    </tr>
                </tbody>
            </table>
        </td>
        <td width="49%" valign="top">
        <table class="content" cellspacing="1" cellpadding="0" width="500px;">
                <tbody  runat="server">
                    <tr >
                        <td class="header2" colspan="2">
                            <%= GetText("STATS") %>
                        </td>
                    </tr>
                    <tr >
                        <td class="post" width="40px" align="center" > 
                            <img src="<%# GetThemeContents("ICONS","FORUM_STATS") %>" alt="" />
                        </td>
                        <td class="post" height="65px;">
                            <asp:Label ID="Stats" runat="server">Label</asp:Label>
                        </td>
                    </tr>
                </tbody>
            </table>
        </td>
    </tr>
</table>
<yaf:SmartScroller ID="SmartScroller1" runat="server" />

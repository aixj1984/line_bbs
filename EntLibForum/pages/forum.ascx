<%@ Control Language="c#" CodeBehind="forum.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.forum" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>
<%@ Register TagPrefix="yaf" TagName="ForumList" Src="../controls/ForumList.ascx" %>
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
        border-bottom: 1px dotted black ;
         _display:inline-block;/*针对ie6*/
        border-bottom-color:#ff0000;
        line-height: 20px;
    }
    .notopic
    {
        width: 20%;
        height:80px;
    }
    .notoinfo
    {
        width: 29.99%;
        margin: 0px;
        padding: 0px;
        overflow: hidden;
        background-repeat: no-repeat;
        background-position: 8px 50%;
        font-weight: normal;
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
    
    .th_p_em
    {
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
<div id="divUnreadMsgs">
    <asp:HyperLink runat="server" ID="UnreadMsgs" Visible="true" /></div>
<!--topic-->
<div class="main" id="wp" style="width: 1002px;">
    <div class="mainbox" id = "category_forum">
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
<asp:Label ID="lblForumAd" runat="server" Text="欢迎访问文古论坛！"></asp:Label>
<!---ad-text area end--->
<table border="0" cellspacing="0" cellpadding="0" width="100%">
    <tr>
        <td width="100%" valign="top">
            <table class="content" cellspacing="1" cellpadding="0" width="100%">
                
                    <div style=" height:39px; width:100%;  margin-top:2px; background-image:url('images/firstpage/站点统计.gif')"></div>
                   <%--  <tr>
                   <td class="header1" colspan="2">
                        <asp:ImageButton runat="server" ID="expandInformation" BorderWidth="0" ImageAlign="Baseline"
                            OnClick="expandInformation_Click" />&nbsp;&nbsp;<%= GetText("INFORMATION") %>
                    </td>
                </tr>--%>
                <tbody id="InformationTBody" runat="server">
                    <tr>
                        <td class="header2" colspan="2">
                            <%= GetText("ACTIVE_USERS") %>
                        </td>
                    </tr>
                    <tr>
                        <td class="post" width="1%">
                            <img src="<%# GetThemeContents("ICONS","FORUM_USERS") %>" alt="" />
                        </td>
                        <td class="post">
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
                    <tr>
                        <td class="header2" colspan="2">
                            <%= GetText("STATS") %>
                        </td>
                    </tr>
                    <tr>
                        <td class="post" width="1%">
                            <img src="<%# GetThemeContents("ICONS","FORUM_STATS") %>" alt="" />
                        </td>
                        <td class="post">
                            <asp:Label ID="Stats" runat="server">Label</asp:Label>
                        </td>
                    </tr>
                </tbody>
            </table>
        </td>
        <%--<td width="10">
            &nbsp;
        </td>
        <td width="34%" valign="top" height="100%">
            <table border="0" class="content" cellspacing="1" cellpadding="0" width="100%">
                <tbody id="ActiveDiscussionTBody" runat="server">
                    <tr>
                        <td class="header1" colspan="2">
                            <asp:ImageButton runat="server" ID="expandActiveDiscussions" BorderWidth="0" ImageAlign="Baseline"
                                OnClick="expandActiveDiscussions_Click" />&nbsp;&nbsp;<%= GetText("ACTIVE_DISCUSSIONS") %>
                        </td>
                    </tr>
                    <tr>
                        <td class="header2" colspan="2">
                            <%= GetText("LATEST_POSTS") %>
                        </td>
                    </tr>
                    <tr>
                        <td class="post" valign="top">
                            <asp:Repeater runat="server" ID="LatestPosts">
                                <ItemTemplate>
                                    &nbsp;<a href='<%#yaf.Forum.GetLink(yaf.Pages.posts,"m={0}#{0}",DataBinder.Eval(Container.DataItem, "LastMessageID"))%>'><%# yaf.Utils.BadWordReplace(Convert.ToString(DataBinder.Eval(Container.DataItem, "Topic"))) %></a>
                                    <a href="<%#yaf.Forum.GetLink(yaf.Pages.posts,"m={0}#{0}",DataBinder.Eval(Container.DataItem, "LastMessageID"))%>">
                                        <img src="<%# GetThemeContents("ICONS","ICON_LATEST") %>" border="0" alt=""></a><br />
                                </ItemTemplate>
                            </asp:Repeater>
                        </td>
                    </tr>
                </tbody>
            </table>
        </td>--%>
    </tr>
</table>
<%--<table style="padding: 2px; margin: 2px" width="99%;">
    <tr>
        <td>
            <img align="middle" src="<% =GetThemeContents("ICONS","FORUM_NEW") %>" alt="" />
            <%# GetText("ICONLEGEND","New_Posts") %>
            <img align="middle" src="<% =GetThemeContents("ICONS","FORUM") %>" alt="" />
            <%# GetText("ICONLEGEND","No_New_Posts") %>
            <img align="middle" src="<% =GetThemeContents("ICONS","FORUM_LOCKED") %>" alt="" />
            <%# GetText("ICONLEGEND","Forum_Locked") %>
        </td>
        <td align="right">
            <asp:LinkButton runat="server" OnClick="MarkAll_Click" ID="MarkAll" />
        </td>
    </tr>
</table>--%>
<yaf:SmartScroller ID="SmartScroller1" runat="server" />

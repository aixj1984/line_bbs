<%@ Control Language="c#" CodeBehind="forum.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.forum" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>
<%@ Register TagPrefix="yaf" TagName="ForumList" Src="../controls/ForumList.ascx" %>
<yaf:PageLinks runat="server" ID="PageLinks" />
<div id="Welcome" runat="server">
    &nbsp;<img src="images/common/arrow2.gif" alt="" />&nbsp;<asp:Label ID="TimeNow"
        runat="server" />
    <span style="padding-left: 20px;">
        <img src="images/common/arrow2.gif" alt="" />
        <asp:Label ID="TimeLastVisit" runat="server" /></span>
</div>
<div id="divUnreadMsgs">
    <asp:HyperLink runat="server" ID="UnreadMsgs" Visible="false" /></div>
<!---ad-text area start--->
<asp:Label ID="lblForumAd" runat="server" Text="欢迎访问EntLib.com论坛系统！"></asp:Label>
<!---ad-text area end--->
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
            <td class="header2" colspan="6">
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
</asp:Repeater>
<div style="padding: 3px; margin-bottom: 5px; margin-top: 5px; text-align:center;" class="content">

<script type="text/javascript"><!--
    google_ad_client = "pub-7768717352490832";
    /* 728x90, 创建于 09-9-27 */
    google_ad_slot = "3891791154";
    google_ad_width = 728;
    google_ad_height = 90;
//-->
</script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>
</div>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
    <tr>
        <td width="65%" valign="top">
            <table class="content" cellspacing="1" cellpadding="0" width="100%">
                <tr>
                    <td class="header1" colspan="2">
                        <asp:ImageButton runat="server" ID="expandInformation" BorderWidth="0" ImageAlign="Baseline"
                            OnClick="expandInformation_Click" />&nbsp;&nbsp;<%= GetText("INFORMATION") %>
                    </td>
                </tr>
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
        <td width="10">
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
        </td>
    </tr>
</table>
<table style="padding: 2px; margin: 2px" width="99%">
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
</table>
<yaf:SmartScroller ID="SmartScroller1" runat="server" />

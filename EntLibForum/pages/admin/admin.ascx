<%@ Control Language="c#" CodeBehind="admin.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.admin.admin" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>
<yaf:PageLinks runat="server" ID="PageLinks" />
<yaf:AdminMenu runat="server" ID="Adminmenu1">
    <asp:Repeater ID="ActiveList" runat="server">
        <HeaderTemplate>
            <table width="100%" cellspacing="1" cellpadding="0" class="content">
                <tr>
                    <td class="header1" colspan="5">
                        在线用户列表
                    </td>
                </tr>
                <tr>
                    <td class="header2">
                        用户名
                    </td>
                    <td class="header2">
                        IP地址
                    </td>
                    <td class="header2">
                        位 置
                    </td>
                    <td class="header2">
                        论 坛
                    </td>
                    <td class="header2">
                        主 题
                    </td>
                </tr>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td class="post">
                    <%# DataBinder.Eval(Container.DataItem, "Name")%>
                </td>
                <td class="post">
                    <%# DataBinder.Eval(Container.DataItem,"IP") %>
                </td>
                <td class="post">
                    <%# DataBinder.Eval(Container.DataItem, "Location")%>
                </td>
                <td class="post">
                    <%# FormatForumLink(DataBinder.Eval(Container.DataItem,"ForumID"),DataBinder.Eval(Container.DataItem,"ForumName")) %>
                </td>
                <td class="post">
                    <%# FormatTopicLink(DataBinder.Eval(Container.DataItem,"TopicID"),DataBinder.Eval(Container.DataItem,"TopicName")) %>
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            </table>
        </FooterTemplate>
    </asp:Repeater>
    <asp:Repeater ID="UserList" runat="server">
        <HeaderTemplate>
            <br />
            <table width="100%" cellspacing="1" cellpadding="0" class="content">
                <tr>
                    <td class="header1" colspan="5">
                        未验证用户列表
                    </td>
                </tr>
                <tr>
                    <td class="header2">
                        用户名
                    </td>
                    <td class="header2">
                        Email 地址
                    </td>
                    <td class="header2">
                        位 置
                    </td>
                    <td class="header2">
                        注册时间
                    </td>
                    <td class="header2">
                        &nbsp;
                    </td>
                </tr>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td class="post">
                    <%# DataBinder.Eval(Container.DataItem,"Name") %>
                </td>
                <td class="post">
                    <%# DataBinder.Eval(Container.DataItem,"Email") %>
                </td>
                <td class="post">
                    <%# DataBinder.Eval(Container.DataItem,"Location") %>
                </td>
                <td class="post">
                    <%# FormatDateTime(DataBinder.Eval(Container.DataItem,"Joined")) %>
                </td>
                <td class="post">
                    <asp:LinkButton OnLoad="Approve_Load" runat="server" CommandName="approve" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"UserID") %>'
                        Text="Approve" />
                    |
                    <asp:LinkButton OnLoad="Delete_Load" runat="server" CommandName="delete" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"UserID") %>'
                        Text="Delete" />
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            <tr>
                <td class="footer1" colspan="5">
                    <asp:Button CommandName="deleteall" title="Deletes all unverified users more than 2 days old"
                        runat="server" Text="全部删除" />
                </td>
            </tr>
            </table>
        </FooterTemplate>
    </asp:Repeater>
    <br />
    <table class="content" cellspacing="1" cellpadding="0" width="100%">
        <tr>
            <td class="header1" colspan="4">
                统计
            </td>
        </tr>
        <tr>
            <td class="postheader" width="25%">
                帖子数:
            </td>
            <td class="post" width="25%">
                <asp:Label ID="NumPosts" runat="server"></asp:Label>
            </td>
            <td class="postheader" width="25%">
                每天平均帖子数:
            </td>
            <td class="post" width="25%">
                <asp:Label ID="DayPosts" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                主题数:
            </td>
            <td class="post">
                <asp:Label ID="NumTopics" runat="server"></asp:Label>
            </td>
            <td class="postheader">
                每天平均主题数:
            </td>
            <td class="post">
                <asp:Label ID="DayTopics" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                用户数:
            </td>
            <td class="post">
                <asp:Label ID="NumUsers" runat="server"></asp:Label>
            </td>
            <td class="postheader">
                每天平均用户数:
            </td>
            <td class="post">
                <asp:Label ID="DayUsers" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                版块开始日期:
            </td>
            <td class="post">
                <asp:Label ID="BoardStart" runat="server"></asp:Label>
            </td>
            <td class="postheader">
                数据库大小:
            </td>
            <td class="post">
                <asp:Label ID="DBSize" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="postfooter" colspan="4">
                上述统计数据不包含已经删除的帖子和主题.
            </td>
        </tr>
    </table>
</yaf:AdminMenu>
<yaf:SmartScroller ID="SmartScroller1" runat="server" />

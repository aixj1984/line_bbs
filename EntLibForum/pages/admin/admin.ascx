<%@ Control Language="c#" CodeBehind="admin.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.admin.admin" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>
<yaf:PageLinks runat="server" ID="PageLinks" />
<yaf:AdminMenu runat="server" ID="Adminmenu1">
    <asp:Repeater ID="ActiveList" runat="server">
        <HeaderTemplate>
            <table width="100%" cellspacing="1" cellpadding="0" class="content">
                <tr>
                    <td class="header1" colspan="5">
                        �����û��б�
                    </td>
                </tr>
                <tr>
                    <td class="header2">
                        �û���
                    </td>
                    <td class="header2">
                        IP��ַ
                    </td>
                    <td class="header2">
                        λ ��
                    </td>
                    <td class="header2">
                        �� ̳
                    </td>
                    <td class="header2">
                        �� ��
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
                        δ��֤�û��б�
                    </td>
                </tr>
                <tr>
                    <td class="header2">
                        �û���
                    </td>
                    <td class="header2">
                        Email ��ַ
                    </td>
                    <td class="header2">
                        λ ��
                    </td>
                    <td class="header2">
                        ע��ʱ��
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
                        runat="server" Text="ȫ��ɾ��" />
                </td>
            </tr>
            </table>
        </FooterTemplate>
    </asp:Repeater>
    <br />
    <table class="content" cellspacing="1" cellpadding="0" width="100%">
        <tr>
            <td class="header1" colspan="4">
                ͳ��
            </td>
        </tr>
        <tr>
            <td class="postheader" width="25%">
                ������:
            </td>
            <td class="post" width="25%">
                <asp:Label ID="NumPosts" runat="server"></asp:Label>
            </td>
            <td class="postheader" width="25%">
                ÿ��ƽ��������:
            </td>
            <td class="post" width="25%">
                <asp:Label ID="DayPosts" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                ������:
            </td>
            <td class="post">
                <asp:Label ID="NumTopics" runat="server"></asp:Label>
            </td>
            <td class="postheader">
                ÿ��ƽ��������:
            </td>
            <td class="post">
                <asp:Label ID="DayTopics" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                �û���:
            </td>
            <td class="post">
                <asp:Label ID="NumUsers" runat="server"></asp:Label>
            </td>
            <td class="postheader">
                ÿ��ƽ���û���:
            </td>
            <td class="post">
                <asp:Label ID="DayUsers" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                ��鿪ʼ����:
            </td>
            <td class="post">
                <asp:Label ID="BoardStart" runat="server"></asp:Label>
            </td>
            <td class="postheader">
                ���ݿ��С:
            </td>
            <td class="post">
                <asp:Label ID="DBSize" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="postfooter" colspan="4">
                ����ͳ�����ݲ������Ѿ�ɾ�������Ӻ�����.
            </td>
        </tr>
    </table>
</yaf:AdminMenu>
<yaf:SmartScroller ID="SmartScroller1" runat="server" />

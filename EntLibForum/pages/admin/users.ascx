<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>
<%@ Control Language="c#" Codebehind="users.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.admin.users" %>
<yaf:PageLinks runat="server" ID="PageLinks" />
<yaf:AdminMenu runat="server" ID="Adminmenu1">
    <table class="content" cellspacing="0" cellpadding="0" width="100%">
        <tr>
            <td class="post" valign="top">
                <table cellspacing="0" cellpadding="0" width="100%">
                    <tr>
                        <td class="header2" nowrap colspan="4">
                            <b>��������</b></td>
                    </tr>
                    <tr class="post">
                        <td>
                            ��:</td>
                        <td>
                            �ȼ�:</td>
                        <td>
                            �û��������ַ�:</td>
                        <td width="99%">
                            &nbsp;</td>
                    </tr>
                    <tr class="post">
                        <td>
                            <asp:DropDownList ID="group" runat="server">
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="rank" runat="server">
                            </asp:DropDownList></td>
                        <td>
                            <asp:TextBox ID="name" runat="server"></asp:TextBox></td>
                        <td align="right">
                            <asp:Button ID="search" runat="server" Text="�� ѯ"></asp:Button></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <br />
    <table class="content" cellspacing="1" cellpadding="0" width="100%">
        <tr>
            <td class="header1" colspan="6">
                �û��б�</td>
        </tr>
        <tr>
            <td class="header2">
                �û���</td>
            <td class="header2">
                �ȼ�</td>
            <td class="header2" align="center">
                ����</td>
            <td class="header2" align="center">
                ��׼</td>
            <td class="header2">
                �����������</td>
            <td class="header2">
                &nbsp;</td>
        </tr>
        <asp:Repeater ID="UserList" runat="server">
            <ItemTemplate>
                <tr>
                    <td class="post">
                        <asp:LinkButton ID="NameEdit" runat="server" CommandName="edit" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "UserID") %>' Text='<%# DataBinder.Eval(Container.DataItem, "Name") %>' /></td>
                    <td class="post">
                        <%# DataBinder.Eval(Container.DataItem,"RankName") %>
                    </td>
                    <td class="post" align="center">
                        <%# DataBinder.Eval(Container.DataItem, "NumPosts") %>
                    </td>
                    <td class="post" align="center">
                        <%# BitSet(DataBinder.Eval(Container.DataItem, "Flags"),2) %>
                    </td>
                    <td class="post">
                        <%# FormatDateTime((System.DateTime)((System.Data.DataRowView)Container.DataItem)["LastVisit"]) %>
                    </td>
                    <td class="post" align="center">
                        <asp:LinkButton runat="server" CommandName="edit" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "UserID") %>'>�༭</asp:LinkButton>
                        |
                        <asp:LinkButton OnLoad="Delete_Load" runat="server" CommandName="delete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "UserID") %>'>ɾ��</asp:LinkButton>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
        <!--- Added BAI 07.01.2003 -->
        <tr>
            <td class="footer1" colspan="6">
                <asp:LinkButton ID="NewUser" runat="server">�����û�</asp:LinkButton></td>
        </tr>
        <!--- Added BAI 07.01.2003 -->
    </table>
</yaf:AdminMenu>
<yaf:SmartScroller ID="SmartScroller1" runat="server" />

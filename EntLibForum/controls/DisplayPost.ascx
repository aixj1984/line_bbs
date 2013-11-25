<%@ Control Language="c#" AutoEventWireup="True" Codebehind="DisplayPost.ascx.cs"
    Inherits="yaf.controls.DisplayPost" EnableViewState="false" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>
<tr class="postheader">
    <%#GetIndentCell()%>
    <td width="140px" id="NameCell" runat="server">
        <a name="<%# DataRow["MessageID"] %>" /><b>
            <asp:HyperLink ID="UserName" runat="server" href='<%# yaf.Forum.GetLink(yaf.Pages.profile,"u={0}",DataRow["UserID"]) %>'><%# Server.HtmlEncode(DataRow["UserName"].ToString()) %></asp:HyperLink></b>
    </td>
    <td width="80%" style="padding: 0 0 0 0;">
        <table cellspacing="0" cellpadding="0" width="100%">
            <tr>
                <td class="postheader">
                    <b>
                        <%# ForumPage.GetText("POSTED") %>
                        :</b>
                    <%# ForumPage.FormatDateTime((System.DateTime)DataRow["Posted"]) %>
                     - 【<%# GetRowNumber() %>】
                </td>
                <td class="postheader" align="right">
                    <asp:HyperLink runat="server" ID="Attach" />
                    <asp:HyperLink runat="server" ID="Edit" />
                    <asp:LinkButton runat="server" ID="Delete" />
                    <asp:HyperLink runat="server" ID="Quote" />
                </td>
            </tr>
        </table>
    </td>
</tr>
<tr class="<%#GetPostClass()%>">
    <td valign="top" height="100" class="UserBox" colspan='<%#GetIndentSpan()%>'>
        <%# FormatUserBox() %>
    </td>
    <td valign="top" class="message">
        <table style="width: 100%; height: 100%;">
            <tr>
                <td valign="top">
                    <div class="postdiv">
                        <%# FormatBody() %>
                    </div>
                </td>
            </tr>
            <tr>
                <td valign="bottom">
                    <%# SignatureContent() %>
                </td>
            </tr>
        </table>
    </td>
</tr>
<tr class="postfooter">
    <td class="small" colspan='<%#GetIndentSpan()%>'>
        <a href="javascript:scroll(0,0)">
            <%# ForumPage.GetText("TOP") %>
        </a>
    </td>
    <td class="postfooter" style="padding: 0 0 0 0;">
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
                    <asp:HyperLink runat='server' ID='Pm' ToolTip="悄悄话" />
                    <asp:HyperLink runat='server' ID='Email' ToolTip="我的邮件" />
                    <asp:HyperLink runat='server' ID='Home' ToolTip="我的主页" />
                    <asp:HyperLink runat='server' ID='Blog' ToolTip="我的博客" />
                </td>
                <td align="right" id="AdminInfo" runat="server">
                    &nbsp;</td>
            </tr>
        </table>
    </td>
</tr>
<tr class="postsep">
    <td colspan="3" style="height: 5px">
    </td>
</tr>
<yaf:PopMenu runat="server" ID="PopMenu1" Control="UserName" />

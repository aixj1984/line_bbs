<%@ Control Language="c#" CodeBehind="info.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.info" %>
<table width="100%" height="50%" border="0">
    <tr>
        <td valign="middle" align="center">
            <table class="content" align="center" width="45%" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="post" valign='top' style="padding: 0;">
                        <table width="100%" cellspacing="0" cellpadding="0">
                            <tr>
                                <td nowrap class="header2">
                                    <asp:Label runat="server" ID="Title" Text="Information" />
                                </td>
                            </tr>
                            <tr>
                                <td class="post">
                                    <asp:Label runat="server" ID="Info" />
                                </td>
                            </tr>
                            <tr>
                                <td class="post">
                                    <asp:HyperLink runat="server" ID="Continue" />
                                </td>
                            </tr>
                        </table>
                        <br />
                        <br />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<br />
<br />

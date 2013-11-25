<%@ Control language="c#" Codebehind="mail.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.admin.mail" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>

<yaf:PageLinks runat="server" id="PageLinks"/>

<yaf:adminmenu runat="server">

<table class=content cellSpacing=1 cellPadding=0 width=100%>
  <tr>
    <td class=header1 colspan="2">发送邮件</td></tr>
  <tr>
    <td class=postheader>收件人:</td>
    <td class=post><asp:dropdownlist id=ToList runat="server" DataValueField="GroupID" DataTextField="Name" Width="400px"></asp:dropdownlist></td></tr>
  <tr>
    <td class=postheader>主题:</td>
    <td class=post><asp:textbox id=Subject runat="server" CssClass="edit" Width="400px"></asp:textbox></td></tr>
  <tr>
    <td class=postheader vAlign=top>邮件内容:</td>
    <td class=post><asp:textbox id=Body runat="server" TextMode="MultiLine" CssClass="edit" Rows="16"  Width="400px"></asp:textbox></td></tr>
  <tr>
    <td class=postfooter align=middle colspan="2"><asp:button id=Send runat="server" Text="发送邮件" onclick="Send_Click"></asp:button></td></tr></table>

</yaf:adminmenu>

<yaf:SmartScroller id="SmartScroller1" runat = "server" />

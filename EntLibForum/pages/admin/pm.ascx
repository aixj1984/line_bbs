<%@ Control language="c#" Codebehind="pm.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.admin.pm" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>

<yaf:PageLinks runat="server" id="PageLinks"/>

<yaf:adminmenu runat="server">

<table class=content cellspacing=1 cellpadding=0 width=100%>
<tr>
	<td class=header1 colspan="2">我的消息</td>
</tr>
<tr>
	<td class="postheader" width="50%">消息条数:</td>
	<td class="post" width="50%"><asp:label runat="server" id="Count"/></td>
</td>
<tr>
	<td class="postheader" width="50%">删除已读的、超过指定天数的消息:</td>
	<td class="post" width="50%"><asp:textbox runat="server" id="Days1"/> 天</td>
</td>
<tr>
	<td class="postheader" width="50%">删除未读的、超过指定天数的消息:</td>
	<td class="post" width="50%"><asp:textbox runat="server" id="Days2"/> 天</td>
</td>

<tr>
	<td class=footer1 colspan="2" align=center>
		<asp:button id=commit runat=server text="删除消息"/>
	</td>
</tr>
</table>

</yaf:adminmenu>

<yaf:SmartScroller id="SmartScroller1" runat = "server" />


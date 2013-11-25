<%@ Control language="c#" Codebehind="prune.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.admin.prune" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>

<yaf:PageLinks runat="server" id="PageLinks"/>

<yaf:adminmenu runat="server">

<table class=content cellspacing=1 cellpadding=0 width=100%>
<tr>
	<td class=header1 colspan="2">删除陈旧的帖子</td>
</tr>
<tr>
	<td class=postheader width=50%><b>选择需要处理的论坛:</b></td>
	<td class=post width=50%><asp:dropdownlist id=forumlist runat=server></asp:dropdownlist>
</tr>
<tr>
	<td class=postheader><b>输入最小的天数:</b><br />如果主题的最新回复的帖子日期超过指定的天数，该主题将被删除.</td>
	<td class=post><asp:textbox id=days runat=server></asp:textbox>
</tr>
<tr>
	<td class=footer1 colspan="2" align=center>
		<asp:button id=commit runat=server text='清理陈旧的帖子'></asp:button>
	</td>
</tr>
</table>

</yaf:adminmenu>

<yaf:SmartScroller id="SmartScroller1" runat = "server" />

<%@ Control language="c#" Codebehind="eventlog.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.admin.eventlog" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>

<yaf:PageLinks runat="server" id="PageLinks"/>

<yaf:adminmenu runat="server">

<table class=content width="100%" cellspacing=1 cellpadding=0>
<tr>
	<td class=header1 colspan="8">事件日志</td>
</tr>

<asp:repeater runat="server" id="List">
	<HeaderTemplate>
		<tr class="header2">
			<td width="1%">类型</td>
			<td>用户名</td>
			<td>日期</td>
			<td>来源</td>
			<td>操作</td>
		</tr>
	</HeaderTemplate>
	<ItemTemplate>
		<tr class=postheader>
			<td align="center"><%# EventImageCode(Container.DataItem) %></td>
			<td><%# DataBinder.Eval(Container.DataItem, "Name") %></td>
			<td><%# DataBinder.Eval(Container.DataItem, "EventTime") %></td>
			<td><%# DataBinder.Eval(Container.DataItem, "Source") %></td>
			<td>
				<asp:linkbutton runat="server" id="showbutton" commandname="show">显示</asp:linkbutton>
				|
				<asp:linkbutton runat="server" onload="Delete_Load" commandname="delete" commandargument='<%# DataBinder.Eval(Container.DataItem, "EventLogID") %>'>删除</asp:linkbutton>
			</td>
		</tr>
		<tr class="post" runat="server" visible="false" id="details">
			<td colspan="5"><pre style="overflow:scroll"><%# DataBinder.Eval(Container.DataItem, "Description") %></pre></td>
		</tr>
	</ItemTemplate>
</asp:repeater>

</table>

</yaf:adminmenu>

<yaf:SmartScroller id="SmartScroller1" runat = "server" />

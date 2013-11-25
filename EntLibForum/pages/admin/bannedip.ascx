<%@ Control language="c#" Codebehind="bannedip.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.admin.bannedip" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>

<yaf:PageLinks runat="server" id="PageLinks"/>

<yaf:adminmenu runat="server">

<asp:repeater id=list runat=server>
<HeaderTemplate>
	<table class=content cellspacing=1 cellpadding=0 width=100%>
	<tr>
		<td class=header1 colspan=3>禁止的 IP 地址</td>
	</tr>
	<tr>
		<td class=header2>IP 地址</td>
		<td class=header2>禁止访问的时间</td>
		<td class=header2>&nbsp;</td>
	</tr>
</HeaderTemplate>
<ItemTemplate>
	<tr>
		<td class=post><%# DataBinder.Eval(Container.DataItem,"Mask") %></td>
		<td class=post><%# FormatDateTime(DataBinder.Eval(Container.DataItem,"Since")) %></td>
		<td class=post>
			<asp:linkbutton runat=server text=Edit commandname='编辑' commandargument='<%# DataBinder.Eval(Container.DataItem,"ID") %>'></asp:linkbutton>
			| <asp:linkbutton runat=server text=Delete commandname='删除' commandargument='<%# DataBinder.Eval(Container.DataItem,"ID") %>'></asp:linkbutton>
		</td>
	</tr>
</ItemTemplate>
<FooterTemplate>
	<tr>
		<td class=footer1 colspan=3><asp:linkbutton runat=server text='新增禁止的 IP 地址' commandname='add'></asp:linkbutton></td>
	</tr>
	</table>
</FooterTemplate>
</asp:repeater>

</yaf:adminmenu>

<yaf:SmartScroller id="SmartScroller1" runat = "server" />

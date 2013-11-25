<%@ Control language="c#" Codebehind="accessmasks.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.admin.accessmasks" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>

<yaf:PageLinks runat="server" id="PageLinks"/>

<yaf:adminmenu runat="server">

<table class=content cellSpacing=1 cellPadding=0 width="100%">
<tr>
	<td class="header1" colspan="12">����Ȩ������</td>
</tr>
<tr class="header2">
	<td>����</td>
	<td align="center">�Ķ�</td>
	<td align="center">����</td>
	<td align="center">�ظ�</td>
	<td align="center">�����ö���</td>
	<td align="center">����ͶƱ</td>
	<td align="center">ͶƱ</td>
	<td align="center">����</td>
	<td align="center">�༭</td>
	<td align="center">ɾ��</td>
	<td align="center">�ϴ��ļ�</td>
	<td>&nbsp;</td>
</tr>

<asp:repeater id="List" runat="server">
<ItemTemplate>
		<tr class="post">
			<td>
				<%# DataBinder.Eval(Container.DataItem, "Name") %>
			</td>
			<td align="center"><%# BitSet(DataBinder.Eval(Container.DataItem, "Flags"),1) %></td>
			<td align="center"><%# BitSet(DataBinder.Eval(Container.DataItem, "Flags"),2) %></td>
			<td align="center"><%# BitSet(DataBinder.Eval(Container.DataItem, "Flags"),4) %></td>
			<td align="center"><%# BitSet(DataBinder.Eval(Container.DataItem, "Flags"),8) %></td>
			<td align="center"><%# BitSet(DataBinder.Eval(Container.DataItem, "Flags"),16) %></td>
			<td align="center"><%# BitSet(DataBinder.Eval(Container.DataItem, "Flags"),32) %></td>
			<td align="center"><%# BitSet(DataBinder.Eval(Container.DataItem, "Flags"),64) %></td>
			<td align="center"><%# BitSet(DataBinder.Eval(Container.DataItem, "Flags"),128) %></td>
			<td align="center"><%# BitSet(DataBinder.Eval(Container.DataItem, "Flags"),256) %></td>
			<td align="center"><%# BitSet(DataBinder.Eval(Container.DataItem, "Flags"),512) %></td>
			<td width="13%" style="font-weight:normal">
				<asp:linkbutton runat='server' commandname='edit' commandargument='<%# DataBinder.Eval(Container.DataItem, "AccessMaskID") %>'>�༭</asp:linkbutton>
				|
				<asp:linkbutton runat='server' onload="Delete_Load" commandname='delete' commandargument='<%# DataBinder.Eval(Container.DataItem, "AccessMaskID") %>'>ɾ��</asp:linkbutton>
			</td>
		</tr>
	
</ItemTemplate>
</asp:repeater>
<tr class="footer1">
	<td colSpan="12">
		<asp:linkbutton id="New" runat="server" text="��������Ȩ������" onclick="New_Click" />
	</td>
</tr>
</table>
		
</yaf:adminmenu>

<yaf:SmartScroller id="SmartScroller1" runat = "server" />

<%@ Control language="c#" Codebehind="groups.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.admin.groups" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>

<yaf:PageLinks runat="server" id="PageLinks"/>

<yaf:adminmenu runat="server">

<table class=content width="100%" cellspacing=1 cellpadding=0>
<tr>
	<td class=header1 colspan=6>�û���Groups</td>
</tr>

<asp:repeater id=GroupList runat="server">
	<HeaderTemplate>
		<tr>
			<td class=header2>����</td>
			<td class=header2>�Ƿ����Ա</td>
			<td class=header2>�Ƿ��ο�</td>
			<td class=header2>�Ƿ�Ϊ��ʼ��</td>
			<td class=header2>�Ƿ��ǰ���</td>
			<td class=header2>�༭</td>
		</tr>
	</HeaderTemplate>
	<ItemTemplate>
		<tr>
			<td class=post>
				<%# DataBinder.Eval(Container.DataItem, "Name") %>
			</td>
			<td class=post>
				<%# BitSet(DataBinder.Eval(Container.DataItem, "Flags"),1) %>
			</td>
			<td class=post>
				<%# BitSet(DataBinder.Eval(Container.DataItem, "Flags"),2) %>
			</td>
			<td class=post>
				<%# BitSet(DataBinder.Eval(Container.DataItem, "Flags"),4) %>
			</td>
			<td class=post>
				<%# BitSet(DataBinder.Eval(Container.DataItem, "Flags"),8) %>
			</td>
			<td class=post>
				<asp:linkbutton runat="server" commandname="edit" commandargument='<%# DataBinder.Eval(Container.DataItem, "GroupID") %>'>�༭</asp:linkbutton>
				|
				<asp:linkbutton runat="server" onload="Delete_Load" commandname="delete" commandargument='<%# DataBinder.Eval(Container.DataItem, "GroupID") %>'>ɾ��</asp:linkbutton>
			</td>
		</tr>
	</ItemTemplate>
</asp:repeater>

<tr>
	<td class=footer1 colspan=6><asp:linkbutton id=NewGroup runat="server" onclick="NewGroup_Click">�����û���</asp:linkbutton></td>
</tr>
</table>

</yaf:adminmenu>

<yaf:SmartScroller id="SmartScroller1" runat = "server" />

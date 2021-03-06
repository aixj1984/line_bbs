<%@ Control language="c#" Codebehind="forums.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.admin.forums" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>

<yaf:PageLinks runat="server" id="PageLinks"/>

<yaf:adminmenu runat="server" ID="adminmenu1">

<table class=content cellSpacing=1 cellPadding=0 width="100%">
<tr>
	<td class=header1 colspan=3>论坛列表</td>
</tr>

<asp:repeater id=CategoryList runat="server">
<ItemTemplate>
		<tr>
			<td class=header2>
				<%# DataBinder.Eval(Container.DataItem, "Name") %>
			</td>
			<td class=header2 width=10% align=center><%# DataBinder.Eval(Container.DataItem, "SortOrder") %></td>
			<td class=header2 width=15% style="font-weight:normal">
				<asp:linkbutton runat='server' commandname='edit' commandargument='<%# DataBinder.Eval(Container.DataItem, "CategoryID") %>'>编辑</asp:linkbutton>
				|
				<asp:linkbutton runat='server' onload="DeleteCategory_Load" commandname='delete' commandargument='<%# DataBinder.Eval(Container.DataItem, "CategoryID") %>'>删除</asp:linkbutton>
			</td>
		</tr>
		<asp:Repeater id=ForumList OnItemCommand="ForumList_ItemCommand" runat="server" datasource='<%# ((System.Data.DataRowView)Container.DataItem).Row.GetChildRows("FK_Forum_Category") %>'>
			<ItemTemplate>
				<tr class=post>
					<td align=left><b><%# DataBinder.Eval(Container.DataItem, "[\"Name\"]") %></b><br /><%# DataBinder.Eval(Container.DataItem, "[\"Description\"]") %></td>
					<td align=center><%# DataBinder.Eval(Container.DataItem, "[\"SortOrder\"]") %></td>
					<td>
						<asp:linkbutton runat='server' commandname='edit' commandargument='<%# DataBinder.Eval(Container.DataItem, "[\"ForumID\"]") %>'>编辑</asp:linkbutton>
						|
						<asp:linkbutton runat='server' onload="DeleteForum_Load" commandname='delete' commandargument='<%# DataBinder.Eval(Container.DataItem, "[\"ForumID\"]") %>'>删除</asp:linkbutton>
					</td>
				</tr>
			</ItemTemplate>
		</asp:Repeater>
	
</ItemTemplate>
</asp:repeater>
  <tr>
    <td class=footer1 colSpan=3><asp:linkbutton id=NewCategory runat="server" onclick="NewCategory_Click">增加新的论坛目录</asp:linkbutton>
		|
		<asp:LinkButton id=NewForum runat="server" onclick="NewForum_Click">增加新的子论坛</asp:LinkButton></td></tr></table>
		
</yaf:adminmenu>

<yaf:SmartScroller id="SmartScroller1" runat = "server" />

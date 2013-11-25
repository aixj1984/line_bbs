<%@ Control language="c#" Codebehind="ranks.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.admin.ranks" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>

<yaf:PageLinks runat="server" id="PageLinks"/>

<yaf:adminmenu runat="server">

<table class=content width="100%" cellspacing=1 cellpadding=0>
<tr>
	<td class=header1 colspan=6>用户等级列表</td>
</tr>

<asp:repeater id=RankList runat="server">
	<HeaderTemplate>
		<tr>
			<td class=header2>等级名称</td>
			<td class=header2>是否为起始等级</td>
			<td class=header2>是否为阶梯升级</td>
			<td class=header2>操作</td>
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
				<%# LadderInfo(Container.DataItem) %>
			</td>
			<td class=post>
				<asp:linkbutton runat="server" commandname="edit" commandargument='<%# DataBinder.Eval(Container.DataItem, "RankID") %>'>编辑</asp:linkbutton>
				|
				<asp:linkbutton runat="server" onload="Delete_Load" commandname="delete" commandargument='<%# DataBinder.Eval(Container.DataItem, "RankID") %>'>删除</asp:linkbutton>
			</td>
		</tr>
	</ItemTemplate>
</asp:repeater>

<tr>
	<td class=footer1 colspan=6><asp:linkbutton id=NewRank runat="server" text="新增等级" onclick="NewRank_Click" /></td>
</tr>
</table>

</yaf:adminmenu>

<yaf:SmartScroller id="SmartScroller1" runat = "server" />

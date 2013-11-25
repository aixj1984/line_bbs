<%@ Control language="c#" Codebehind="smilies.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.admin.smilies" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>

<yaf:PageLinks runat="server" id="PageLinks"/>

<yaf:adminmenu runat="server">

<asp:repeater runat=server id=List>
<HeaderTemplate>
	<table width=100% cellspacing=1 cellpadding=0 class=content>
	<tr>
		<td class=header1 colspan=5>微笑图标库</td>
	</tr>
	<tr>
		<td class=header2>代码</td>
		<td class=header2 align="center">图标</td>
		<td class=header2>表情</td>
		<td class=header2>操作</td>
	</tr>
</HeaderTemplate>
<ItemTemplate>
	<tr>
		<td class=post><%# DataBinder.Eval(Container.DataItem,"Code") %></td>
		<td class=post align="center"><img src="<%# yaf.Data.ForumRoot %>images/emoticons/<%# DataBinder.Eval(Container.DataItem,"Icon") %>"/></td>		
		<td class=post><%# DataBinder.Eval(Container.DataItem,"Emoticon") %></td>
		<td class=post>
			<asp:linkbutton runat="server" commandname="edit" commandargument='<%# DataBinder.Eval(Container.DataItem,"SmileyID") %>' text="编辑"/>
			|
			<asp:linkbutton runat="server" onload="Delete_Load" commandname="delete" commandargument='<%# DataBinder.Eval(Container.DataItem,"SmileyID") %>' text="删除"/>
		</td>
	</tr>
</ItemTemplate>
<FooterTemplate>
	<tr>
		<td class=footer1 colSpan=4>
			<asp:linkbutton runat="server" commandname="add">新增微笑图标</asp:linkbutton>
			|
			<asp:LinkButton runat="server" commandname="import">导入微笑图标库</asp:LinkButton>
		</td>
	</tr>
	</table>
</FooterTemplate>
</asp:repeater>

</yaf:adminmenu>

<yaf:SmartScroller id="SmartScroller1" runat = "server" />

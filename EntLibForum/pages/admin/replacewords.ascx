<%@ Control language="c#" Debug="true" Codebehind="replacewords.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.admin.replacewords" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>
<yaf:PageLinks runat="server" id="PageLinks" />
<yaf:adminmenu runat="server" id="Adminmenu1">
	<asp:repeater id="list" runat="server">
		<HeaderTemplate>
			<table class="content" cellspacing="1" cellpadding="0" width="100%">
				<tr>
					<td class="header1" colspan="3">禁用单词过滤</td>
				</tr>
				<tr>
					<td class="header2">禁用词</td>
					<td class="header2">替换为合适用语</td>
					<td class="header2">&nbsp;</td>
				</tr>
		</HeaderTemplate>
		<ItemTemplate>
			<tr>
				<td class="post"><%# Server.HtmlEncode(Convert.ToString(DataBinder.Eval(Container.DataItem,"badword"))) %></td>
				<td class="post"><%# Server.HtmlEncode(Convert.ToString(DataBinder.Eval(Container.DataItem,"goodword"))) %></td>
				<td class="post">
					<asp:linkbutton runat=server text='编辑' commandname='edit' commandargument='<%# DataBinder.Eval(Container.DataItem,"ID") %>' ID="Linkbutton1">
					</asp:linkbutton>
					|
					<asp:linkbutton runat=server text='删除' commandname='delete' commandargument='<%# DataBinder.Eval(Container.DataItem,"ID") %>' ID="Linkbutton2">
					</asp:linkbutton>
				</td>
			</tr>
		</ItemTemplate>
		<FooterTemplate>
			<tr>
				<td class="footer1" colspan="3">
					<asp:linkbutton runat="server" text="新增" commandname='add' ID="Linkbutton3"></asp:linkbutton></td>
			</tr>
			</table>
		</FooterTemplate>
	</asp:repeater>
</yaf:adminmenu>
<yaf:SmartScroller id="SmartScroller1" runat="server" />

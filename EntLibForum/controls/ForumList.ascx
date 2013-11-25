<%@ Control Language="c#" AutoEventWireup="True" Codebehind="ForumList.ascx.cs" Inherits="yaf.controls.ForumList" EnableViewState="false" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>

<asp:Repeater id="forumList1" runat="server">
<ItemTemplate>
	<tr class="post">
		<td><%# GetForumIcon(Container.DataItem) %></td>
		<td>
			<span class="forumheading"><%# GetForumLink((System.Data.DataRow)Container.DataItem) %></span>
			<span class="forumviewing"><%# GetViewing(Container.DataItem) %></span><br />
			<span class="subforumheading"><%# DataBinder.Eval(Container.DataItem, "[\"Description\"]") %></span>
			<br/>
			<asp:repeater visible='true' id="ModeratorList" runat="server" onitemcommand='ModeratorList_ItemCommand' datasource='<%# ((System.Data.DataRow)Container.DataItem).GetChildRows("FK_Moderator_Forum") %>'>
				<HeaderTemplate><span class="smallfont"><%# ForumPage.GetText("moderators") %>: </HeaderTemplate>
				<ItemTemplate><%# DataBinder.Eval(Container.DataItem, "[\"UserName\"]") %></ItemTemplate>
				<SeparatorTemplate>, </SeparatorTemplate>
				<FooterTemplate></span></FooterTemplate>
			</asp:repeater>
		</td>
		<td align="center"><%# Topics(Container.DataItem) %></td>
		<td align="center"><%# Posts(Container.DataItem) %></td>
		<td align="center" class="smallfont"><%# yaf.Utils.BadWordReplace(FormatLastPost((System.Data.DataRow)Container.DataItem)) %></td>
		<td><%# GetForumLogoLink(Container.DataItem) %></td>
	</tr>
</ItemTemplate>
<AlternatingItemTemplate>
	<tr class="post_alt">
		<td><%# GetForumIcon(Container.DataItem) %></td>
		<td>
			<span class="forumheading"><%# GetForumLink((System.Data.DataRow)Container.DataItem) %></span>
			<span class="forumviewing"><%# GetViewing(Container.DataItem) %></span><br />
			<span class="subforumheading"><%# DataBinder.Eval(Container.DataItem, "[\"Description\"]") %></span>
			<br/>
			<asp:repeater visible='true' id="Repeater1" runat="server" onitemcommand='ModeratorList_ItemCommand' datasource='<%# ((System.Data.DataRow)Container.DataItem).GetChildRows("FK_Moderator_Forum") %>'>
				<HeaderTemplate><span class="smallfont"><%# ForumPage.GetText("moderators") %>: </HeaderTemplate>
				<ItemTemplate><%# DataBinder.Eval(Container.DataItem, "[\"UserName\"]") %></ItemTemplate>
				<SeparatorTemplate>, </SeparatorTemplate>
				<FooterTemplate></span></FooterTemplate>
			</asp:repeater>
		</td>
		<td align="center"><%# Topics(Container.DataItem) %></td>
		<td align="center"><%# Posts(Container.DataItem) %></td>
		<td align="center" class="smallfont"><%# yaf.Utils.BadWordReplace(FormatLastPost((System.Data.DataRow)Container.DataItem)) %></td>
		<td><%# GetForumLogoLink(Container.DataItem) %></td>
	</tr>
</AlternatingItemTemplate>
<SeparatorTemplate>
<tr><td colspan="6" class="tbltdLine"></td></tr>
</SeparatorTemplate>
</asp:Repeater>

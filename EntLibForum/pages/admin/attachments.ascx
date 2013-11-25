<%@ Control language="c#" Codebehind="attachments.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.admin.attachments" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>

<yaf:PageLinks runat="server" id="PageLinks"/>

<yaf:adminmenu runat="server">

<table class=content width="100%" cellspacing=1 cellpadding=0>
<tr>
	<td class=header1 colspan="8">附件</td>
</tr>

<asp:repeater runat="server" id="List">
	<HeaderTemplate>
		<tr class="header2">
			<td>论坛</td>
			<td>主题</td>
			<td>发帖日期</td>
			<td>文件名</td>
			<td align="right">下载次数</td>
			<td>文件类型</td>
			<td align="right">大小</td>
			<td nowrap>操作</td>
		</tr>
	</HeaderTemplate>
	<ItemTemplate>
		<tr class=post>
			<td><a target="_top" href='<%# yaf.Forum.GetLink(yaf.Pages.topics,"f={0}",DataBinder.Eval(Container.DataItem,"ForumID")) %>'><%# DataBinder.Eval(Container.DataItem,"ForumName") %></a></td>
			<td><a target="_top" href='<%# yaf.Forum.GetLink(yaf.Pages.posts,"t={0}",DataBinder.Eval(Container.DataItem,"TopicID")) %>'><%# DataBinder.Eval(Container.DataItem,"TopicName") %></a></td>
			<td><%# FormatDateTimeShort(DataBinder.Eval(Container.DataItem, "Posted")) %></td>
			<td><%# DataBinder.Eval(Container.DataItem, "FileName") %></td>
			<td align="right"><%# DataBinder.Eval(Container.DataItem, "Downloads") %></td>
			<td><%# DataBinder.Eval(Container.DataItem, "ContentType") %></td>
			<td align="right"><%# DataBinder.Eval(Container.DataItem, "Bytes") %></td>
			<td>
				<asp:linkbutton runat="server" onload="Delete_Load" commandname="delete" commandargument='<%# DataBinder.Eval(Container.DataItem, "AttachmentID") %>'>删除</asp:linkbutton>
			</td>
		</tr>
	</ItemTemplate>
</asp:repeater>

</table>

</yaf:adminmenu>

<yaf:SmartScroller id="SmartScroller1" runat = "server" />

<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>
<%@ Control language="c#" Codebehind="editforum.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.admin.editforum" %>
<yaf:PageLinks runat="server" id="PageLinks" />
<yaf:adminmenu runat="server" id="Adminmenu1">
	<table class="content" cellspacing="1" cellpadding="0" width="100%">
		<tr>
			<td class="header1" colspan="2">编辑论坛:
				<asp:label id="ForumNameTitle" runat="server"></asp:label></td>
		</tr>
		<tr>
			<td class="postheader"><b>栏目:</b><br />
				该论坛将放在该栏目下：（What category to put the forum under.）</td>
			<td class="post">
				<asp:dropdownlist id="CategoryList" runat="server" OnSelectedIndexChanged="Category_Change" DataValueField="CategoryID" DataTextField="Name"></asp:dropdownlist></td>
		</tr>
		<tr>
			<td class="postheader"><b>父论坛:</b><br />
				讲该论坛成为其他论坛的子论坛。（Will make this forum a sub forum of another forum.）</td>
			<td class="post">
				<asp:dropdownlist id="ParentList" runat="server"></asp:dropdownlist></td>
		</tr>
		<tr>
			<td class="postheader"><b>论坛名称:</b><br />
				论坛的名称.</td>
			<td class="post">
				<asp:textbox id="Name" runat="server" cssclass="edit"></asp:textbox></td>
		</tr>
		<tr>
			<td class="postheader"><b>论坛描述:</b><br />
				论坛的简单描述.</td>
			<td class="post">
				<asp:textbox id="Description" runat="server" cssclass="edit"></asp:textbox></td>
		</tr>
		<tr>
			<td class="postheader"><b>论坛超链接:</b><br />
				输入链接，则会替代原有的论坛模块连接。Enter a url here, and instead of going to the forum you will be taken to this 
				url instead.</td>
			<td class="post">
				<asp:textbox id="remoteurl" runat="server" cssclass="edit"></asp:textbox></td>
		</tr>
		<tr>
			<td class="postheader"><b>主题:</b><br />
				为论坛选择一个主体，使他不不同于其他标准板块的主题。（Choose a theme for this forum if its to differ from the standard Board theme.）</td>
			<td class="post">
				<asp:Dropdownlist id="ThemeList" runat="server"></asp:Dropdownlist></td>
		</tr>
		<tr>
			<td class="postheader"><b>排序编号:</b><br />
				在改栏目下的排序编号。（Sort order under this category.）</td>
			<td class="post">
				<asp:textbox id="SortOrder" runat="server"></asp:textbox></td>
		</tr>
		<tr>
			<td class="postheader"><b>论坛查看控制Hide if no access:</b><br />
				设置了不允许查看后，这该模块对用户不可见。Means that the forum will be hidden when the user don't have read access to it.</td>
			<td class="post">
				<asp:checkbox id="HideNoAccess" runat="server"></asp:checkbox></td>
		</tr>
		<tr>
			<td class="postheader"><b>上锁Locked:</b><br />
				如果论坛上锁，则表示没有人能够进行转发和回复。If the forum is locked, no one can post or reply in this forum.</td>
			<td class="post">
				<asp:checkbox id="Locked" runat="server"></asp:checkbox></td>
		</tr>
		<tr>
			<td class="postheader"><b>是否是测试论坛Is Test:</b><br />
				如果该选项被选中，在这个论坛的帖子不会在天梯系统计数。If this is checked, posts in this forum will not count in the ladder system.</td>
			<td class="post">
				<asp:checkbox id="IsTest" runat="server"></asp:checkbox></td>
		</tr>
		<tr>
			<td class="postheader"><b>过滤Moderated:</b><br />
				如果论坛被过滤，职位必须由主持人批准。If the forum is moderated, posts have to be approved by a moderator.</td>
			<td class="post">
				<asp:checkbox id="Moderated" runat="server"></asp:checkbox></td>
		</tr>
		<tr id="NewGroupRow" runat="server">
			<td class="postheader"><b>初始化访问权限Initial Access Mask:</b><br />
				所有论坛的初始化访问权限。The initial access mask for all forums.</td>
			<td class="post">
				<asp:dropdownlist id="AccessMaskID" ondatabinding="BindData_AccessMaskID" runat="server"></asp:dropdownlist></td>
		</tr>
		<asp:repeater id="AccessList" runat="server">
			<HeaderTemplate>
				<tr>
					<td class="header1" colspan="2">权限控制Access</td>
				</tr>
				<tr class="header2">
					<td>Group</td>
					<td>Access Mask</td>
				</tr>
			</HeaderTemplate>
			<ItemTemplate>
				<tr>
					<td class="postheader">
						<asp:label id="GroupID" visible="false" runat="server" text='<%# DataBinder.Eval(Container.DataItem, "GroupID") %>'>
						</asp:label>
						<%# DataBinder.Eval(Container.DataItem, "GroupName") %>
					</td>
					<td class="post">
						<asp:dropdownlist runat="server" id="AccessMaskID" ondatabinding="BindData_AccessMaskID" onprerender="SetDropDownIndex" value='<%# DataBinder.Eval(Container.DataItem,"AccessMaskID") %>'/>
						...
					</td>
				</tr>
			</ItemTemplate>
		</asp:repeater>
		<tr>
			<td class="postfooter" align="center" colspan="2">
				<asp:button id="Save" runat="server" text="保存"></asp:button>&nbsp;
				<asp:Button id="Cancel" runat="server" Text="取消"></asp:Button></td>
		</tr>
	</table>
</yaf:adminmenu>
<yaf:SmartScroller id="SmartScroller1" runat = "server" />

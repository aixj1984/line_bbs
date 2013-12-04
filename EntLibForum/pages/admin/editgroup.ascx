<%@ Control language="c#" Codebehind="editgroup.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.admin.editgroup" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>

<yaf:PageLinks runat="server" id="PageLinks"/>

<yaf:adminmenu runat="server">

<table class=content cellSpacing=1 cellPadding=0 width="100%">
<tr>
	<td class=header1 colspan=11>编辑用户组</td>
</tr>
<tr>
	<td class=postheader width="50%"><b>组名称:</b><br/>Name of this group.</td>
	<td class=post width="50%"><asp:textbox style="width:300px" id=Name runat="server"/></td>
</tr>
<tr>
	<td class=postheader><b>是否为管理员组:</b><br/>Means that users in this group are admins.</td>
	<td class=post><asp:checkbox id=IsAdminX runat="server"></asp:checkbox></td>
</tr>
<tr>
	<td class=postheader><b>是否是游客组Is Guest:</b><br/>Means that users in this group are guests (anonymous). Only one group should have this checked.</td>
	<td class=post><asp:checkbox id=IsGuestGroup runat="server"></asp:checkbox></td>
</tr>
<tr>
	<td class=postheader><b>Is Start:</b><br/>If this is checked, all new users will be a member of this group.</td>
	<td class=post><asp:checkbox id=IsStart runat="server"></asp:checkbox></td>
</tr>
<tr>
	<td class=postheader><b>是否是版主Is Forum Moderator:</b><br/>When this is checked, members of this group will have some admin access rights.</td>
	<td class=post><asp:checkbox id=IsModeratorX runat="server"></asp:checkbox></td>
</tr>
<tr runat="server" id="NewGroupRow">
	<td class="postheader"><b>初始访问掩码:</b><br/>The initial access mask for all forums.</td>
	<td class="post"><asp:dropdownlist runat="server" id="AccessMaskID" ondatabinding="BindData_AccessMaskID"/></td>
</tr>
    
<asp:repeater id=AccessList runat="server">
<HeaderTemplate>
	<tr>
		<td class=header1 colspan=11>Access</td>
	</tr>
	<tr>
		<td class=header2>论坛</td>
		<td class=header2>论坛进入掩码</td>
	</tr>
</HeaderTemplate>
<ItemTemplate>
	<tr>
		<td class="postheader">
			<asp:label id=ForumID visible=false runat="server" text='<%# DataBinder.Eval(Container.DataItem, "ForumID") %>'></asp:label>
			<b><%# DataBinder.Eval(Container.DataItem, "ForumName") %></b><br />
			Category: <%# DataBinder.Eval(Container.DataItem, "CategoryName") %>
		</td>
		<td class="post">
			<asp:dropdownlist runat="server" id="AccessMaskID" ondatabinding="BindData_AccessMaskID" onprerender="SetDropDownIndex" value='<%# DataBinder.Eval(Container.DataItem,"AccessMaskID") %>'/>
			...
		</td>
	</tr>
</ItemTemplate>
</asp:repeater>
  <tr>
    <td class=postfooter align=middle colspan=11><asp:button id=Save runat="server" text="保存" onclick="Save_Click"></asp:button>&nbsp; 
<asp:button id=Cancel runat="server" Text="取消" onclick="Cancel_Click"></asp:button></td></tr></table>

</yaf:adminmenu>

<yaf:SmartScroller id="SmartScroller1" runat = "server" />

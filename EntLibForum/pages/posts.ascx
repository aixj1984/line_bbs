<%@ Control language="c#" Codebehind="posts.ascx.cs" AutoEventWireup="True" Inherits="yaf.pages.posts" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>
<%@ Register TagPrefix="yaf" TagName="displaypost" Src="../controls/DisplayPost.ascx" %>
<%@ Register Assembly="WebValidates" Namespace="WebValidates" TagPrefix="cc1" %>

<yaf:PageLinks runat="server" id="PageLinks"/>

<a name="top"></a>

<asp:repeater id="Poll" runat="server" visible="false">
<HeaderTemplate>
<table class="content" cellspacing="1" cellpadding="0" width="100%">
	<tr>
		<td class="header1" colspan="3"><%= GetText("question") %>: <%# GetPollQuestion() %> <%# GetPollIsClosed() %></td>
	</tr>
	<tr>
		<td class="header2"><%= GetText("choice") %></td>
		<td class="header2" align="center" width="10%"><%= GetText("votes") %></td>
		<td class="header2" width="40%"><%= GetText("statistics") %></td>
	</tr>
</HeaderTemplate>
<ItemTemplate>
	<tr>
		<td class="post">
		<yaf:mylinkbutton runat="server" enabled="<%#CanVote%>" commandname=vote commandargument='<%# DataBinder.Eval(Container.DataItem, "ChoiceID") %>' text='<%# DataBinder.Eval(Container.DataItem, "Choice") %>'/></td>
		<td class="post" align="center"><%# DataBinder.Eval(Container.DataItem, "Votes") %></td>
		<td class="post"><nobr><img src="<%# GetThemeContents("VOTE","LCAP") %>"><img src="<%# GetThemeContents("VOTE","BAR") %>" height=12px width='<%# VoteWidth(Container.DataItem) %>%'><img src="<%# GetThemeContents("VOTE","RCAP") %>"></nobr> <%# DataBinder.Eval(Container.DataItem,"Stats") %>%</td>
	</tr>
</ItemTemplate>
<FooterTemplate>
</table><br/>
</FooterTemplate>
</asp:repeater>
<table class='command' cellspacing='0' cellpadding='0' width='100%'>
<tr>
	<td align="left" class="navlinks"><yaf:pager runat="server" id="Pager" UsePostBack="false"/></td>
	<td align="right">
		<asp:linkbutton id="PostReplyLink1" runat="server" cssclass="imagelink" ToolTip="Post Reply" onclick="PostReplyLink_Click" />
		<asp:linkbutton id="NewTopic1" runat="server" cssclass="imagelink" onclick="NewTopic_Click" />
		<asp:linkbutton id="DeleteTopic1" runat="server" onload="DeleteTopic_Load" cssclass="imagelink" onclick="DeleteTopic_Click" />
		<asp:linkbutton id="LockTopic1" runat="server" cssclass="imagelink" onclick="LockTopic_Click" />
		<asp:linkbutton id="UnlockTopic1" runat="server" cssclass="imagelink" onclick="UnlockTopic_Click" />
		<asp:linkbutton id="MoveTopic1" runat="server" cssclass="imagelink" onclick="MoveTopic_Click" />
	</td>
</tr>
</table>

<table class="content" cellspacing="1" cellpadding="0" width="100%" border="1">
<tr>
	<td colspan="3" style="padding:0px">
		<table border="0" cellpadding="0" cellspacing="0" width="100%" class="header1">
			<tr class="header1">
				<td class="header1Title"><asp:label id="TopicTitle" runat="server"/></td>
				<td align="right">
					<asp:hyperlink id="MyTest" runat="server"><%= GetText("Options") %></asp:hyperlink>
					<asp:placeholder runat="server" id="ViewOptions">
					&middot;
					<asp:hyperlink id="View" runat="server"><%= GetText("View") %></asp:hyperlink>
					</asp:placeholder>
				</td>
			</tr>
		</table>
	</td>
</tr>
<tr class="header2">
	<td colspan="3" align="right" class="header2links">
		<asp:linkbutton id="PrevTopic" CssClass="header2link" runat="server" onclick="PrevTopic_Click"><%# GetText("prevtopic") %></asp:linkbutton>
		&middot;
		<asp:linkbutton id="NextTopic" CssClass="header2link" runat="server" onclick="NextTopic_Click"><%# GetText("nexttopic") %></asp:linkbutton>
		<div runat="server" visible="false">
			<asp:linkbutton id="TrackTopic" CssClass="header2link" runat="server" onclick="TrackTopic_Click"><%# GetText("watchtopic") %></asp:linkbutton>
			&middot;
			<asp:linkbutton id="EmailTopic" CssClass="header2link" runat="server" onclick="EmailTopic_Click"><%# GetText("emailtopic") %></asp:linkbutton>
			&middot;
			<asp:linkbutton id="PrintTopic" CssClass="header2link" runat="server" onclick="PrintTopic_Click"><%# GetText("printtopic") %></asp:linkbutton>
 			&middot;
 			<asp:hyperlink id="RssTopic" CssClass="header2link" runat="server"><%# GetText("rsstopic") %></asp:hyperlink>
		</div>
	</td>
</tr>
<asp:Literal ID="txtEmptyContentDesc" runat="server"></asp:Literal>
<asp:repeater id="MessageList" runat="server">
<ItemTemplate>
	<%# GetThreadedRow(Container.DataItem) %>
	<yaf:displaypost runat="server" datarow="<%# Container.DataItem %>" visible="<%#IsCurrentMessage(Container.DataItem)%>" isthreaded="<%#IsThreaded%>"/>
</ItemTemplate>
<AlternatingItemTemplate>
	<%# GetThreadedRow(Container.DataItem) %>
	<yaf:displaypost runat="server" datarow="<%# Container.DataItem %>" IsAlt="True" visible="<%#IsCurrentMessage(Container.DataItem)%>" isthreaded="<%#IsThreaded%>"/>
</AlternatingItemTemplate>
</asp:repeater>

<tr>
<td colspan="3" align="center">
<a href="http://www.hubeici.com/zp/zhop.html"><img src="http://www.hubeici.com/ggw/syggw/hxggs/201212/W020130924326679582821.jpg" alt="文谷网" title="文谷网" style=" width:985px;" /></a>
</td>
</tr>
    <asp:PlaceHolder id="QuickReplyPlaceHolder" runat="server">
    <tr>
        <td colspan="3" class="post" style="padding:0px;">
            <yaf:DataPanel runat="server" id="DataPanel1"  AllowTitleExpandCollapse="true" TitleStyle-CssClass="header2" TitleStyle-Font-Bold="true" Collapsed="false">
                请输入回复内容（必须大于5个字符）：
                <div class="post" id="QuickReplyLine" runat="server" style="width: 100%; height: 120px; text-align: center;">
                </div>                
                <div align="center" style="margin:7px;"><!-- 
验证码 (不区分大小写):&nbsp;&nbsp;
	<cc1:SerialNumber ID="SerialNumber1" runat="server">
        </cc1:SerialNumber>&nbsp;&nbsp;<asp:TextBox ID="snvTxt1" runat="server"></asp:TextBox>  -->
                          <br /> 
                    <asp:button id="QuickReply" cssclass="pbutton" runat="server" OnClick="QuickReply_Click"/>
                </div>                
            </yaf:DataPanel>
        </td>
    </tr>
    </asp:PlaceHolder>        

<yaf:ForumUsers runat="server" ID="ForumUsersID"/>

</table>

<br />

<table class="command" cellspacing="0" cellpadding="0" width="100%">
  <tr>
    <td align="left" class="navlinks"><yaf:pager runat="server" linkedpager="Pager" UsePostBack="false" ID="pager1"/></td>
    <td align="right">
		<asp:linkbutton id="PostReplyLink2" runat="server" cssclass="imagelink" onclick="PostReplyLink_Click" />
		<asp:linkbutton id="NewTopic2" runat="server" cssclass="imagelink" onclick="NewTopic_Click" />
		<asp:linkbutton id="DeleteTopic2" runat="server" onload="DeleteTopic_Load" cssclass="imagelink" onclick="DeleteTopic_Click" />
		<asp:linkbutton id="LockTopic2" runat="server" cssclass="imagelink" onclick="LockTopic_Click" />
		<asp:linkbutton id="UnlockTopic2" runat="server" cssclass="imagelink" onclick="UnlockTopic_Click" />
		<asp:linkbutton id="MoveTopic2" runat="server" cssclass="imagelink" onclick="MoveTopic_Click" />
</td></tr>
</table>

<br />
<table cellspacing="0" cellpadding="0" width="100%">
<tr id="ForumJumpLine" runat="Server">
	<td align="right"><%= GetText("FORUM_JUMP") %> <yaf:forumjump id="ForumJump1" runat="server"/></td>
</tr>
<tr>
	<td align="right" valign="top" class="smallfont"><yaf:PageAccess id="PageAccess1" runat="server"/></td>
</tr>
</table>

<yaf:SmartScroller id="SmartScroller1" runat = "server" />

<yaf:PopMenu runat="server" id="MyTestMenu" control="MyTest"/>
<yaf:PopMenu runat="server" id="ViewMenu" control="View"/>

<span id="WatchTopicID" runat="server" visible="false"></span>

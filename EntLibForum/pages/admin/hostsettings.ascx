<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>
<%@ Control Language="c#" CodeBehind="hostsettings.ascx.cs" AutoEventWireup="True"
    Inherits="yaf.pages.admin.hostsettings" %>
<yaf:PageLinks runat="server" ID="PageLinks" />
<yaf:AdminMenu runat="server" ID="Adminmenu1">
    <table class="content" cellspacing="1" cellpadding="0" align="center" border="1">
        <tr>
            <td class="header1" colspan="2">
                主机设置
            </td>
        </tr>
        <tr>
            <td class="header2" align="center" colspan="2">
                论坛主机设置
            </td>
        </tr>
        <tr>
            <td class="postheader" width="50%" style="min-width: 300px">
                <b>MS SQL Server 版本:</b><br>
                MS SQL Server 正在运行的版本信息.
            </td>
            <td class="post" width="50%">
                <asp:Label ID="SQLVersion" runat="server" CssClass="smallfont"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>时区:</b><br>
                Web server 所在时区.
            </td>
            <td class="post">
                <asp:DropDownList ID="TimeZones" runat="server" DataValueField="Value" DataTextField="Name">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>论坛邮件地址:</b><br>
                在给用户发送Email时，显示的发送地址.
            </td>
            <td class="post">
                <asp:TextBox ID="ForumEmailEdit" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>需要Email验证:</b><br>
                如果不选择，表示不需要验证用户Email地址.
            </td>
            <td class="post">
                <asp:CheckBox ID="EmailVerification" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>显示已移动的主题:</b><br>
                如果选择，在主题移动后，仍留下一条记录指向新的主题.
            </td>
            <td class="post">
                <asp:CheckBox ID="ShowMoved" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>在新窗口打开链接:</b><br>
                如果选择，将在新窗口打开帖子中的链接.
            </td>
            <td class="post">
                <asp:CheckBox ID="BlankLinks" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>显示组（Groups）:</b><br>
                是否在帖子页面显示用户所在的组.
            </td>
            <td class="post">
                <asp:CheckBox ID="ShowGroupsX" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>在用户信息页面显示组（Groups）:</b><br>
                是否在用户信息页面显示用户所在的组.
            </td>
            <td class="post">
                <asp:CheckBox ID="ShowGroupsProfile" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>使用数据表存放文件（File Table）:</b><br>
                上传的文件存放在数据库，而不是文件系统.
            </td>
            <td class="post">
                <asp:CheckBox ID="UseFileTableX" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>显示 RSS 链接:</b><br>
                是否在整个论坛显示 RSS 链接.
            </td>
            <td class="post">
                <asp:CheckBox ID="ShowRSSLinkX" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>显示页面生成时间:</b><br>
                是否在页脚显示页面生成时间.
            </td>
            <td class="post">
                <asp:CheckBox ID="ShowPageGenerationTime" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>显示论坛跳转列表框:</b><br>
                是否在整个论坛显示论坛跳转列表框.
            </td>
            <td class="post">
                <asp:CheckBox ID="ShowForumJumpX" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>显示用户积分:</b><br>
                如果选择，将显示每一个用户的发帖积分.
            </td>
            <td class="post">
                <asp:CheckBox ID="DisplayPoints" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>删除嵌套的引用:</b><br>
                自动删除回复中的嵌套引用标识.
            </td>
            <td class="post">
                <asp:CheckBox ID="RemoveNestedQuotesX" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>显示成员统计:</b><br>
                在首页显示所有成员统计信息.
            </td>
            <td class="post">
                <asp:CheckBox ID="ShowMemberStatsX" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>投票 IP 约束Poll Votes Dependant on IP:</b><br>
                默认情况下，根据用户名和客户端Cookie来限制投票（每一个用户可以投票一次，如果允许Guest投票，则根据Cookie来限制投票）。如果选中此项，则采用 IP 来限制投票，提供最高的安全，避免单一用户多次投票。
            </td>
            <td class="post">
                <asp:CheckBox ID="PollVoteTiedToIPX" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>最大上传文件限制:</b><br>
                设定最大允许上传的文件.如果为空，则没有限制.
            </td>
            <td class="post">
                <asp:TextBox ID="MaxFileSize" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>微笑图标显示网格大小:</b><br>
                设置微笑图标显示的行×列.
            </td>
            <td class="post">
                <asp:TextBox ID="SmiliesPerRow" runat="server"></asp:TextBox><b>x</b>
                <asp:TextBox ID="SmiliesColumns" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>每页显示帖数:</b><br>
                设定每页显示的帖数.
            </td>
            <td class="post">
                <asp:TextBox ID="PostsPerPage" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>每页主题数:</b><br>
                设定每页显示的主题数.
            </td>
            <td class="post">
                <asp:TextBox ID="TopicsPerPage" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>多少天之后自动锁贴:</b><br>
                设定多少天之后，系统自动锁贴（不允许编辑和删除）. 设置为 0 表示没有限制.
            </td>
            <td class="post">
                <asp:TextBox ID="LockPosts" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>连续发帖间隔时间:</b><br>
                设定连续发帖的间隔时间（秒），没有达到间隔时间，则第二贴不允许发布. (对管理员Admin和版主没有约束.)
            </td>
            <td class="post">
                <asp:TextBox ID="PostFloodDelay" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>根据语言文件设定日期和时间格式:</b><br>
                如果选中，则根据语言文件中的配置来设定日期和时间的格式. 否则采用浏览器的设置.
            </td>
            <td class="post">
                <asp:CheckBox ID="DateFormatFromLanguage" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="header2" align="center" colspan="2">
                论坛广告设置
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>第二贴广告设置:</b><br />
                设置每一个主题中第二贴的广告显示. 如果您不希望显示广告, 则不需要输入任何内容.
            </td>
            <td class="post" style="word-break: break-all; word-wrap: break-word; width: 50%;">
                <asp:TextBox TextMode="MultiLine" runat="server" ID="AdPost" Columns="75" Rows="10"  Width="100%"/>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>显示上述广告给登录用户:</b><br />
                如果选择，登录用户将看到上述广告.
            </td>
            <td class="post">
                <asp:CheckBox runat="server" ID="ShowAdsToSignedInUsers" />
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>设置论坛广告:</b><br />
                设置论坛头部的广告。如果为空，则不显示广告。
            </td>
            <td class="post" style="word-break: break-all; word-wrap: break-word; width: 50%;">
                <asp:TextBox TextMode="MultiLine" runat="server" ID="txtForumAd" Columns="75" Rows="10" Width="100%"/>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>设置论坛文字链接广告:</b><br />
                目前设置在论坛第一帖的后面。如果为空，则不显示广告。
            </td>
            <td class="post" style="word-break: break-all; word-wrap: break-word; width: 50%;">
                <asp:TextBox TextMode="MultiLine" runat="server" ID="txtFirstPostAd" Columns="75" Rows="10" Width="100%"/>
            </td>
        </tr>        <tr>
            <td class="header2" align="center" colspan="2">
                编辑/格式化设置
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>论坛编辑器:</b><br>
                选择论坛使用的全局编辑器. 如使用HTML编辑器(FCK 和 FreeTextBox)，相应.bin 文件需要存放到 \bin 目录，并且需要的支持文件需要存放在\editors目录.
            </td>
            <td class="post">
                <asp:DropDownList ID="ForumEditorList" runat="server" DataValueField="Value" DataTextField="Name">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>接收的 HTML 标签:</b><br>
                使用逗号分隔（不需要空格） HTML 标签列表，这些 HTML 标签允许出现在 HTML 编辑器中。
            </td>
            <td class="post">
                <asp:TextBox ID="AcceptedHTML" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="header2" align="center" colspan="2">
                权限设置
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>允许用户更改 Theme 设置:</b><br>
                是否允许用户更改 Theme?
            </td>
            <td class="post">
                <asp:CheckBox ID="AllowUserThemeX" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>允许用户更改语言设置:</b><br>
                是否允许用户更改论坛的语言设置?
            </td>
            <td class="post">
                <asp:CheckBox ID="AllowUserLanguageX" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>允许发送悄悄话(Private Messages):</b><br>
                是否允许用户接收和发送悄悄话.
            </td>
            <td class="post">
                <asp:CheckBox ID="AllowPrivateMessagesX" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>允许悄悄话提醒:</b><br>
                当有新的悄悄话到达时，是否通过用户邮件提醒.
            </td>
            <td class="post">
                <asp:CheckBox ID="AllowPMNotifications" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>允许Email发送:</b><br>
                是否允许用户相互发送Email.
            </td>
            <td class="post">
                <asp:CheckBox ID="AllowEmailSendingX" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>允许签名:</b><br>
                是否允许用户设置个性化签名.
            </td>
            <td class="post">
                <asp:CheckBox ID="AllowSignaturesX" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>禁止新用户注册:</b><br>
                禁止新用户在论坛注册.
            </td>
            <td class="post">
                <asp:CheckBox ID="DisableRegistrations" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="header2" align="center" colspan="2">
                邮件服务器（SMTP Server）设置
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>邮件服务器（SMTP Server）:</b><br>
                为了发送Email，请输入有效的邮件服务器 SMTP Server.
            </td>
            <td class="post">
                <asp:TextBox ID="ForumSmtpServer" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>SMTP 用户名:</b><br>
                如果 SMTP Server需要认证，请输入用户名.
            </td>
            <td class="post">
                <asp:TextBox ID="ForumSmtpUserName" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>SMTP 密码:</b><br>
                如果 SMTP Server需要认证，请输入密码.
            </td>
            <td class="post">
                <asp:TextBox ID="ForumSmtpUserPass" runat="server" TextMode="Password"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="header2" align="center" colspan="2">
                个人图像设置
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>允许使用外部网站的图像:</b><br>
               是否允许用户使用外部网站的图像.
            </td>
            <td class="post">
                <asp:CheckBox ID="AvatarRemote" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>允许上传图像:</b><br>
                是否允许用户上传图片作为自己的图像.
            </td>
            <td class="post">
                <asp:CheckBox ID="AvatarUpload" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>图像宽度:</b><br>
                图像的最大宽度.
            </td>
            <td class="post">
                <asp:TextBox ID="AvatarWidth" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>图像高度:</b><br>
                图像的最大高度.
            </td>
            <td class="post">
                <asp:TextBox ID="AvatarHeight" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>图像大小:</b><br>
                图像最大字节数.
            </td>
            <td class="post">
                <asp:TextBox ID="AvatarSize" runat="server"></asp:TextBox>
            </td>
        </tr>
        <!--tr>
		<td class="header2" colspan="2">Forum Moderator Access</td>
	</tr>
	<tr>
		<td class="postheader"><b>Groups and Users:</b><br/>Forum moderators can access groups and users administration.</td>
		<td class="post">...</td>
	</tr>
	<tr>
		<td class="postheader"><b>Forum:</b><br/>Forum moderators can access forum management.</td>
		<td class="post">...</td>
	</tr>
	<tr>
		<td class="postheader"><b>...</b><br/>...</td>
		<td class="post">...</td>
	</tr-->
        <tr>
            <td class="postfooter" align="center" colspan="2">
                <asp:Button ID="Save" runat="server" Text="Save" OnClick="Save_Click"></asp:Button>
            </td>
        </tr>
    </table>
</yaf:AdminMenu>
<yaf:SmartScroller ID="SmartScroller1" runat="server" />

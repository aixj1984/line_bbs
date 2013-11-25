<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>
<%@ Control Language="c#" CodeBehind="hostsettings.ascx.cs" AutoEventWireup="True"
    Inherits="yaf.pages.admin.hostsettings" %>
<yaf:PageLinks runat="server" ID="PageLinks" />
<yaf:AdminMenu runat="server" ID="Adminmenu1">
    <table class="content" cellspacing="1" cellpadding="0" align="center" border="1">
        <tr>
            <td class="header1" colspan="2">
                ��������
            </td>
        </tr>
        <tr>
            <td class="header2" align="center" colspan="2">
                ��̳��������
            </td>
        </tr>
        <tr>
            <td class="postheader" width="50%" style="min-width: 300px">
                <b>MS SQL Server �汾:</b><br>
                MS SQL Server �������еİ汾��Ϣ.
            </td>
            <td class="post" width="50%">
                <asp:Label ID="SQLVersion" runat="server" CssClass="smallfont"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>ʱ��:</b><br>
                Web server ����ʱ��.
            </td>
            <td class="post">
                <asp:DropDownList ID="TimeZones" runat="server" DataValueField="Value" DataTextField="Name">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>��̳�ʼ���ַ:</b><br>
                �ڸ��û�����Emailʱ����ʾ�ķ��͵�ַ.
            </td>
            <td class="post">
                <asp:TextBox ID="ForumEmailEdit" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>��ҪEmail��֤:</b><br>
                �����ѡ�񣬱�ʾ����Ҫ��֤�û�Email��ַ.
            </td>
            <td class="post">
                <asp:CheckBox ID="EmailVerification" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>��ʾ���ƶ�������:</b><br>
                ���ѡ���������ƶ���������һ����¼ָ���µ�����.
            </td>
            <td class="post">
                <asp:CheckBox ID="ShowMoved" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>���´��ڴ�����:</b><br>
                ���ѡ�񣬽����´��ڴ������е�����.
            </td>
            <td class="post">
                <asp:CheckBox ID="BlankLinks" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>��ʾ�飨Groups��:</b><br>
                �Ƿ�������ҳ����ʾ�û����ڵ���.
            </td>
            <td class="post">
                <asp:CheckBox ID="ShowGroupsX" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>���û���Ϣҳ����ʾ�飨Groups��:</b><br>
                �Ƿ����û���Ϣҳ����ʾ�û����ڵ���.
            </td>
            <td class="post">
                <asp:CheckBox ID="ShowGroupsProfile" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>ʹ�����ݱ����ļ���File Table��:</b><br>
                �ϴ����ļ���������ݿ⣬�������ļ�ϵͳ.
            </td>
            <td class="post">
                <asp:CheckBox ID="UseFileTableX" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>��ʾ RSS ����:</b><br>
                �Ƿ���������̳��ʾ RSS ����.
            </td>
            <td class="post">
                <asp:CheckBox ID="ShowRSSLinkX" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>��ʾҳ������ʱ��:</b><br>
                �Ƿ���ҳ����ʾҳ������ʱ��.
            </td>
            <td class="post">
                <asp:CheckBox ID="ShowPageGenerationTime" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>��ʾ��̳��ת�б��:</b><br>
                �Ƿ���������̳��ʾ��̳��ת�б��.
            </td>
            <td class="post">
                <asp:CheckBox ID="ShowForumJumpX" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>��ʾ�û�����:</b><br>
                ���ѡ�񣬽���ʾÿһ���û��ķ�������.
            </td>
            <td class="post">
                <asp:CheckBox ID="DisplayPoints" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>ɾ��Ƕ�׵�����:</b><br>
                �Զ�ɾ���ظ��е�Ƕ�����ñ�ʶ.
            </td>
            <td class="post">
                <asp:CheckBox ID="RemoveNestedQuotesX" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>��ʾ��Աͳ��:</b><br>
                ����ҳ��ʾ���г�Աͳ����Ϣ.
            </td>
            <td class="post">
                <asp:CheckBox ID="ShowMemberStatsX" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>ͶƱ IP Լ��Poll Votes Dependant on IP:</b><br>
                Ĭ������£������û����Ϳͻ���Cookie������ͶƱ��ÿһ���û�����ͶƱһ�Σ��������GuestͶƱ�������Cookie������ͶƱ�������ѡ�д������� IP ������ͶƱ���ṩ��ߵİ�ȫ�����ⵥһ�û����ͶƱ��
            </td>
            <td class="post">
                <asp:CheckBox ID="PollVoteTiedToIPX" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>����ϴ��ļ�����:</b><br>
                �趨��������ϴ����ļ�.���Ϊ�գ���û������.
            </td>
            <td class="post">
                <asp:TextBox ID="MaxFileSize" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>΢Цͼ����ʾ�����С:</b><br>
                ����΢Цͼ����ʾ���С���.
            </td>
            <td class="post">
                <asp:TextBox ID="SmiliesPerRow" runat="server"></asp:TextBox><b>x</b>
                <asp:TextBox ID="SmiliesColumns" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>ÿҳ��ʾ����:</b><br>
                �趨ÿҳ��ʾ������.
            </td>
            <td class="post">
                <asp:TextBox ID="PostsPerPage" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>ÿҳ������:</b><br>
                �趨ÿҳ��ʾ��������.
            </td>
            <td class="post">
                <asp:TextBox ID="TopicsPerPage" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>������֮���Զ�����:</b><br>
                �趨������֮��ϵͳ�Զ�������������༭��ɾ����. ����Ϊ 0 ��ʾû������.
            </td>
            <td class="post">
                <asp:TextBox ID="LockPosts" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>�����������ʱ��:</b><br>
                �趨���������ļ��ʱ�䣨�룩��û�дﵽ���ʱ�䣬��ڶ�����������. (�Թ���ԱAdmin�Ͱ���û��Լ��.)
            </td>
            <td class="post">
                <asp:TextBox ID="PostFloodDelay" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>���������ļ��趨���ں�ʱ���ʽ:</b><br>
                ���ѡ�У�����������ļ��е��������趨���ں�ʱ��ĸ�ʽ. ������������������.
            </td>
            <td class="post">
                <asp:CheckBox ID="DateFormatFromLanguage" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="header2" align="center" colspan="2">
                ��̳�������
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>�ڶ����������:</b><br />
                ����ÿһ�������еڶ����Ĺ����ʾ. �������ϣ����ʾ���, ����Ҫ�����κ�����.
            </td>
            <td class="post" style="word-break: break-all; word-wrap: break-word; width: 50%;">
                <asp:TextBox TextMode="MultiLine" runat="server" ID="AdPost" Columns="75" Rows="10"  Width="100%"/>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>��ʾ����������¼�û�:</b><br />
                ���ѡ�񣬵�¼�û��������������.
            </td>
            <td class="post">
                <asp:CheckBox runat="server" ID="ShowAdsToSignedInUsers" />
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>������̳���:</b><br />
                ������̳ͷ���Ĺ�档���Ϊ�գ�����ʾ��档
            </td>
            <td class="post" style="word-break: break-all; word-wrap: break-word; width: 50%;">
                <asp:TextBox TextMode="MultiLine" runat="server" ID="txtForumAd" Columns="75" Rows="10" Width="100%"/>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>������̳�������ӹ��:</b><br />
                Ŀǰ��������̳��һ���ĺ��档���Ϊ�գ�����ʾ��档
            </td>
            <td class="post" style="word-break: break-all; word-wrap: break-word; width: 50%;">
                <asp:TextBox TextMode="MultiLine" runat="server" ID="txtFirstPostAd" Columns="75" Rows="10" Width="100%"/>
            </td>
        </tr>        <tr>
            <td class="header2" align="center" colspan="2">
                �༭/��ʽ������
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>��̳�༭��:</b><br>
                ѡ����̳ʹ�õ�ȫ�ֱ༭��. ��ʹ��HTML�༭��(FCK �� FreeTextBox)����Ӧ.bin �ļ���Ҫ��ŵ� \bin Ŀ¼��������Ҫ��֧���ļ���Ҫ�����\editorsĿ¼.
            </td>
            <td class="post">
                <asp:DropDownList ID="ForumEditorList" runat="server" DataValueField="Value" DataTextField="Name">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>���յ� HTML ��ǩ:</b><br>
                ʹ�ö��ŷָ�������Ҫ�ո� HTML ��ǩ�б���Щ HTML ��ǩ��������� HTML �༭���С�
            </td>
            <td class="post">
                <asp:TextBox ID="AcceptedHTML" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="header2" align="center" colspan="2">
                Ȩ������
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>�����û����� Theme ����:</b><br>
                �Ƿ������û����� Theme?
            </td>
            <td class="post">
                <asp:CheckBox ID="AllowUserThemeX" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>�����û�������������:</b><br>
                �Ƿ������û�������̳����������?
            </td>
            <td class="post">
                <asp:CheckBox ID="AllowUserLanguageX" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>���������Ļ�(Private Messages):</b><br>
                �Ƿ������û����պͷ������Ļ�.
            </td>
            <td class="post">
                <asp:CheckBox ID="AllowPrivateMessagesX" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>�������Ļ�����:</b><br>
                �����µ����Ļ�����ʱ���Ƿ�ͨ���û��ʼ�����.
            </td>
            <td class="post">
                <asp:CheckBox ID="AllowPMNotifications" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>����Email����:</b><br>
                �Ƿ������û��໥����Email.
            </td>
            <td class="post">
                <asp:CheckBox ID="AllowEmailSendingX" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>����ǩ��:</b><br>
                �Ƿ������û����ø��Ի�ǩ��.
            </td>
            <td class="post">
                <asp:CheckBox ID="AllowSignaturesX" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>��ֹ���û�ע��:</b><br>
                ��ֹ���û�����̳ע��.
            </td>
            <td class="post">
                <asp:CheckBox ID="DisableRegistrations" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="header2" align="center" colspan="2">
                �ʼ���������SMTP Server������
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>�ʼ���������SMTP Server��:</b><br>
                Ϊ�˷���Email����������Ч���ʼ������� SMTP Server.
            </td>
            <td class="post">
                <asp:TextBox ID="ForumSmtpServer" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>SMTP �û���:</b><br>
                ��� SMTP Server��Ҫ��֤���������û���.
            </td>
            <td class="post">
                <asp:TextBox ID="ForumSmtpUserName" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>SMTP ����:</b><br>
                ��� SMTP Server��Ҫ��֤������������.
            </td>
            <td class="post">
                <asp:TextBox ID="ForumSmtpUserPass" runat="server" TextMode="Password"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="header2" align="center" colspan="2">
                ����ͼ������
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>����ʹ���ⲿ��վ��ͼ��:</b><br>
               �Ƿ������û�ʹ���ⲿ��վ��ͼ��.
            </td>
            <td class="post">
                <asp:CheckBox ID="AvatarRemote" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>�����ϴ�ͼ��:</b><br>
                �Ƿ������û��ϴ�ͼƬ��Ϊ�Լ���ͼ��.
            </td>
            <td class="post">
                <asp:CheckBox ID="AvatarUpload" runat="server"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>ͼ����:</b><br>
                ͼ��������.
            </td>
            <td class="post">
                <asp:TextBox ID="AvatarWidth" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>ͼ��߶�:</b><br>
                ͼ������߶�.
            </td>
            <td class="post">
                <asp:TextBox ID="AvatarHeight" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="postheader">
                <b>ͼ���С:</b><br>
                ͼ������ֽ���.
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

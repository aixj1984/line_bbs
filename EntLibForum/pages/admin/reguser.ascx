<%@ Control Language="c#" AutoEventWireup="True" Codebehind="reguser.ascx.cs" Inherits="yaf.pages.admin.reguser" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" Assembly="yaf" %>
<yaf:PageLinks runat="server" id="PageLinks" />
<yaf:adminmenu runat="server" id="Adminmenu1">
  <table class="content" cellSpacing="1" cellPadding="0" width="100%">
    <tr>
      <td class="header1" colSpan="2">�����û�</td>
    </tr>
    <tr>
      <td class="header2" align="center" colSpan="2">ע����ϸ��ϢRegistration Details</td>
    </tr>
    <tr>
      <td class="postheader" width="50%">�û���:</td>
      <td class="post">
        <asp:TextBox id="UserName" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator id="Requiredfieldvalidator1" runat="server" NAME="Requiredfieldvalidator1" EnableClientScript="False"
          ControlToValidate="UserName" ErrorMessage="User Name is required."></asp:RequiredFieldValidator></td>
    </tr>
    <tr>
      <td class="postheader">����:</td>
      <td class="post">
        <asp:TextBox id="Password" runat="server" TextMode="Password"></asp:TextBox>
        <asp:RequiredFieldValidator id="Requiredfieldvalidator2" runat="server" NAME="Requiredfieldvalidator2" EnableClientScript="False"
          ControlToValidate="Password" ErrorMessage="Password is required."></asp:RequiredFieldValidator></td>
    </tr>
    <tr>
      <td class="postheader">�ظ���������:</td>
      <td class="post">
        <asp:TextBox id="Password2" runat="server" TextMode="Password"></asp:TextBox>
        <asp:CompareValidator id="Comparevalidator1" runat="server" NAME="Comparevalidator1" EnableClientScript="False"
          ControlToValidate="Password2" ErrorMessage="Passwords didnt match." ControlToCompare="Password"></asp:CompareValidator></td>
    </tr>
    <tr>
      <td class="postheader">�����ַ:</td>
      <td class="post">
        <asp:TextBox id="Email" runat="server"></asp:TextBox></td>
    </tr>
    <tr>
      <td class="header2" align="center" colSpan="2">������Ϣ</td>
    </tr>
    <tr>
      <td class="postheader">��ͥ��ַ:</td>
      <td class="post">
        <asp:TextBox id="Location" runat="server"></asp:TextBox></td>
    </tr>
    <tr>
      <td class="postheader">������ҳ:</td>
      <td class="post">
        <asp:TextBox id="HomePage" runat="server"></asp:TextBox></td>
    </tr>
    <tr>
      <td class="header2" align="center" colSpan="2">��̳����</td>
    </tr>
    <tr>
      <td class="postheader">����ʱ��:</td>
      <td class="post">
        <asp:DropDownList id="TimeZones" runat="server" DataValueField="Value" DataTextField="Name"></asp:DropDownList></td>
    </tr>
    <tr>
      <td class="footer1" align="center" colSpan="2">
        <asp:Button id="ForumRegister" runat="server" text="ע��" onclick="ForumRegister_Click"></asp:Button>
        <asp:button id="cancel" runat="server" Text="ȡ��" onclick="cancel_Click"></asp:button></td>
    </tr>
  </table>
</yaf:adminmenu>
<yaf:SmartScroller id="SmartScroller1" runat = "server" />

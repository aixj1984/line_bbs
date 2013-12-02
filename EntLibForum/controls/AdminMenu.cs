using System;

namespace yaf.controls
{
	/// <summary>
	/// Summary description for AdminMenu.
	/// </summary>
	public class AdminMenu : BaseControl
	{
		public AdminMenu()
		{
			//
			// TODO: Add constructor logic here
			//
		}
	
		protected override void Render(System.Web.UI.HtmlTextWriter writer) 
		{	
			writer.WriteLine(@"<table width=""100%"" cellspacing=""0"" cellpadding=""0""><tr>");
			writer.WriteLine(@"<td width=""10%"" valign=""top"">");

			writer.WriteLine(@"<table class=""content"" width=""100%"" cellspacing=""0"" cellpadding=""0""><tr><td style='padding:1' valign=""top"">");
			writer.WriteLine(@"<table width=""160px"" cellspacing=""0"" cellpadding=""0"" >");
			
			if (ForumPage.IsHostAdmin) 
			{
				// host admin -- create host admin menu...
				string [,] hostAdminLinks =
				{
					{"��̳��������",Forum.GetLink(Pages.admin_hostsettings)},
					{"��̳�������",Forum.GetLink(Pages.admin_boards)}
				};

				writer.Write( createMenu( "��������", "header2", "post", ref hostAdminLinks ) );
			}

			// create the admin menu...
			string [,] adminLinks =
			{
				{"�����û�ͳ��",Forum.GetLink(Pages.admin_admin)},
				{"��̳����",Forum.GetLink(Pages.admin_boardsettings)},
				{"��̳�б�",Forum.GetLink(Pages.admin_forums)},
				{"IP������",Forum.GetLink(Pages.admin_bannedip)},
				{"΢Цͼ��",Forum.GetLink(Pages.admin_smilies)},
				{"���õ��ʹ���",Forum.GetLink(Pages.admin_replacewords)}
			};

			writer.Write(createMenu( "��������", "header2", "post", ref adminLinks ));

			// create the groups and users menu...
			string [,] groupsAndUsersLinks =
			{
				{"Ȩ������",Forum.GetLink(Pages.admin_accessmasks)},
				{"��(��ɫ)",Forum.GetLink(Pages.admin_groups)},
				{"��ѯ�û�",Forum.GetLink(Pages.admin_users)},
				{"�û��ȼ��б�",Forum.GetLink(Pages.admin_ranks)},
				{"�����ʼ�",Forum.GetLink(Pages.admin_mail)}
			};

			writer.Write(createMenu( "�飨��ɫ�����û�", "header2", "post", ref groupsAndUsersLinks ));

			// create maintenance menu...
			string [,] maintenanceLinks =
			{
				{"ɾ���¾ɵ�����",Forum.GetLink(Pages.admin_prune)},
				{"�ҵ���Ϣ",Forum.GetLink(Pages.admin_pm)},
				{"�� ��",Forum.GetLink(Pages.admin_attachments)},
				{"�¼���־",Forum.GetLink(Pages.admin_eventlog)}
			};

			writer.Write( createMenu( "����ά��", "header2", "post", ref maintenanceLinks ) );

			writer.WriteLine(@"</table>");
			writer.WriteLine(@"</td></tr></table>");

            writer.WriteLine(@"<br />Powered by:<br />");
            writer.WriteLine(@"<a href='http://www.hubeici.com/index.shtml' target='_blank'><img src='images/powerby/powerby_entlibforum.gif' alt='Powered by �����Ļ���ҵ��'/></a>");

			writer.WriteLine(@"</td><td valign=""top"">&nbsp;&nbsp;");
			writer.WriteLine(@"</td><td width=""90%"" valign=""top"">");
			
			base.RenderChildren(writer);

			writer.WriteLine(@"</td></tr></table>");

		}

		protected string createMenu( string menuTitle, string menuClass, string itemClass, ref string [,] menuItems )
		{
			string returnValue;

			returnValue = createHeader( menuClass, menuTitle ) + "\r\n";

			for ( int i = 0; i < menuItems.GetUpperBound(0)+1; i++ )
			{
				returnValue += createLink( itemClass, menuItems [i,0], menuItems [i,1] ) + "\r\n";	
			}

			return returnValue;
		}

		protected string createHeader( string className, string headerText )
		{
			return string.Format( @"<tr><td nowrap=""nowrap"" class=""{0}""><b>{1}</b></td></tr>", className, headerText );
		}

		protected string createLink( string className, string linkText, string linkURL )
		{
			return string.Format( @"<tr><td nowrap=""nowrap"" class=""{0}""><a href=""{1}"">{2}</a></td></tr>", className, linkURL, linkText );
		}
	}
}

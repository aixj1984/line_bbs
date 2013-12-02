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
					{"论坛主机设置",Forum.GetLink(Pages.admin_hostsettings)},
					{"论坛版块设置",Forum.GetLink(Pages.admin_boards)}
				};

				writer.Write( createMenu( "主机管理", "header2", "post", ref hostAdminLinks ) );
			}

			// create the admin menu...
			string [,] adminLinks =
			{
				{"在线用户统计",Forum.GetLink(Pages.admin_admin)},
				{"论坛设置",Forum.GetLink(Pages.admin_boardsettings)},
				{"论坛列表",Forum.GetLink(Pages.admin_forums)},
				{"IP黑名单",Forum.GetLink(Pages.admin_bannedip)},
				{"微笑图标",Forum.GetLink(Pages.admin_smilies)},
				{"禁用单词过滤",Forum.GetLink(Pages.admin_replacewords)}
			};

			writer.Write(createMenu( "管理配置", "header2", "post", ref adminLinks ));

			// create the groups and users menu...
			string [,] groupsAndUsersLinks =
			{
				{"权限设置",Forum.GetLink(Pages.admin_accessmasks)},
				{"组(角色)",Forum.GetLink(Pages.admin_groups)},
				{"查询用户",Forum.GetLink(Pages.admin_users)},
				{"用户等级列表",Forum.GetLink(Pages.admin_ranks)},
				{"发送邮件",Forum.GetLink(Pages.admin_mail)}
			};

			writer.Write(createMenu( "组（角色）和用户", "header2", "post", ref groupsAndUsersLinks ));

			// create maintenance menu...
			string [,] maintenanceLinks =
			{
				{"删除陈旧的帖子",Forum.GetLink(Pages.admin_prune)},
				{"我的消息",Forum.GetLink(Pages.admin_pm)},
				{"附 件",Forum.GetLink(Pages.admin_attachments)},
				{"事件日志",Forum.GetLink(Pages.admin_eventlog)}
			};

			writer.Write( createMenu( "数据维护", "header2", "post", ref maintenanceLinks ) );

			writer.WriteLine(@"</table>");
			writer.WriteLine(@"</td></tr></table>");

            writer.WriteLine(@"<br />Powered by:<br />");
            writer.WriteLine(@"<a href='http://www.hubeici.com/index.shtml' target='_blank'><img src='images/powerby/powerby_entlibforum.gif' alt='Powered by 湖北文化产业网'/></a>");

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

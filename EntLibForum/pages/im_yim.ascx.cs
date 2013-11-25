using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace yaf.pages
{
	/// <summary>
	/// Summary description for active.
	/// </summary>
	public partial class im_yim : ForumPage
	{

		public im_yim() : base("IM_YIM")
		{
		}

		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!User.IsAuthenticated)
				Data.AccessDenied();

			if(!IsPostBack) 
			{
				using(DataTable dt=DB.user_list(PageBoardID,Request.QueryString["u"],null)) 
				{
					foreach(DataRow row in dt.Rows) 
					{
						PageLinks.AddLink(BoardSettings.Name,Forum.GetLink(Pages.forum));
						PageLinks.AddLink(row["Name"].ToString(),Forum.GetLink(Pages.profile,"u={0}",row["UserID"]));
						PageLinks.AddLink(GetText("TITLE"),"");
						Img.Src = string.Format("http://opi.yahoo.com/online?u={0}&m=g&t=2",row["YIM"]);
						Msg.NavigateUrl = string.Format("http://edit.yahoo.com/config/send_webmesg?.target={0}&.src=pg",row["YIM"]);
						break;
					}
				}
			}
		}

		override protected void OnInit(EventArgs e)
		{
			this.Load += new System.EventHandler(this.Page_Load);
			base.OnInit(e);
		}
	}
}

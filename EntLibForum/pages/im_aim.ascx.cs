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
	public partial class im_aim : ForumPage
	{

		public im_aim() : base("IM_AIM")
		{
		}

		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!User.IsAuthenticated)
				Data.AccessDenied();

			if(!IsPostBack) {
				using(DataTable dt=DB.user_list(PageBoardID,Request.QueryString["u"],null)) 
				{
					foreach(DataRow row in dt.Rows) 
					{
						PageLinks.AddLink(BoardSettings.Name,Forum.GetLink(Pages.forum));
						PageLinks.AddLink(row["Name"].ToString(),Forum.GetLink(Pages.profile,"u={0}",row["UserID"]));
						PageLinks.AddLink(GetText("TITLE"),"");

						Msg.NavigateUrl = string.Format("aim:goim?screenname={0}&message=Hi.+Are+you+there?",row["AIM"]);
						Buddy.NavigateUrl = string.Format("aim:addbuddy?screenname={0}",row["AIM"]);
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

using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace yaf.pages.help
{
	/// <summary>
	/// Summary description for main.
	/// </summary>
	public partial class recover : ForumPage
	{

		public recover() : base(null)
		{
		}

		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack) 
			{
				PageLinks.AddLink(BoardSettings.Name,Forum.GetLink(Pages.forum));
				PageLinks.AddLink("Help",Forum.GetLink(Pages.help_index));
				PageLinks.AddLink("Recover lost passwords",Forum.GetLink(Pages.help_recover));
				BindData();
			}
		}

		private void BindData() 
		{
			DataBind();
		}

		override protected void OnInit(EventArgs e)
		{
			base.OnInit(e);
		}
	}
}

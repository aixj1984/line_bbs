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
	public partial class index : ForumPage
	{

		public index() : base(null)
		{
		}

		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack) 
			{
				PageLinks.AddLink(BoardSettings.Name,Forum.GetLink(Pages.forum));
				PageLinks.AddLink("Help",Forum.GetLink(Pages.help_index));
				BindData();
			}
		}

		private void BindData() 
		{
			DataBind();
		}

		override protected void OnInit(EventArgs e)
		{
			DoSearch.Click += new EventHandler(DoSearch_Click);
			base.OnInit(e);
		}

		private void DoSearch_Click(object sender, EventArgs e)
		{
			throw new ApplicationException("TODO");
		}
	}
}

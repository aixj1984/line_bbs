using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace yaf.pages
{
	/// <summary>
	/// Summary description for rules.
	/// </summary>
	public partial class rules : ForumPage
	{
	
		public rules() : base("RULES")
		{
		}

		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack) 
			{
				PageLinks.AddLink(BoardSettings.Name,Forum.GetLink(Pages.forum));
			
				ForumRules.Text = "TODO:";
			}
			//TODO: Write license info and stuff...
			Forum.Redirect(Pages.register);
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    

		}
		#endregion

		protected void Cancel_Click(object sender, System.EventArgs e)
		{
			Forum.Redirect(Pages.forum);
		}

		protected void Accept_Click(object sender, System.EventArgs e)
		{
			Forum.Redirect(Pages.register);
		}

	}
}

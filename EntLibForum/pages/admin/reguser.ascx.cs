namespace yaf.pages.admin
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;

	/// <summary>
	///		Summary description for reguser.
	/// </summary>
	public partial class reguser : AdminPage
	{
    

		protected void Page_Load(object sender, System.EventArgs e)
		{
      if(!IsPostBack) 
      {
        PageLinks.AddLink(BoardSettings.Name,Forum.GetLink(Pages.forum));
        PageLinks.AddLink("Administration",Forum.GetLink(Pages.admin_admin));
        PageLinks.AddLink("Users","");

        TimeZones.DataSource = Data.TimeZones();
        DataBind();
        TimeZones.Items.FindByValue("480").Selected = true;
      }
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
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{

		}
		#endregion
		
    protected void cancel_Click(object sender,EventArgs e) 
    {
      Forum.Redirect(Pages.admin_users);
    }
		
    protected void ForumRegister_Click(object sender, System.EventArgs e)
    {
      if(Page.IsValid) 
      {
        if(!Utils.IsValidEmail(Email.Text))
        {
          AddLoadMessage("You have entered an illegal e-mail address.");
          return;
        }

        if(DB.user_find(PageBoardID,false,UserName.Text,Email.Text).Rows.Count>0) 
        {
          AddLoadMessage("Username or email are already registered.");
          return;
        }

        if (DB.user_register(this,PageBoardID,UserName.Text,Password.Text,Email.Text,Location.Text,HomePage.Text,TimeZones.SelectedItem.Value,BoardSettings.EmailVerification))
				{
					// success
					Forum.Redirect(Pages.admin_reguser);
				}
      }
    }
		
	}
}

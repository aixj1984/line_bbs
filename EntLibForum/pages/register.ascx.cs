using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Web.Security;
using System.Globalization;

namespace yaf.pages
{
	/// <summary>
	/// Summary description for register.
	/// </summary>
	public partial class register : ForumPage
	{
	
		public register() : base("REGISTER")
		{
		}

		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!User.CanLogin || BoardSettings.DisableRegistrations)
				Data.AccessDenied();

			if(!IsPostBack) {
				PageLinks.AddLink(BoardSettings.Name,Forum.GetLink(Pages.forum));
				ForumRegister.Text = GetText("register");
				cancel.Text = GetText("Cancel");

				TimeZones.DataSource = Data.TimeZones();
				DataBind();
				TimeZones.Items.FindByValue("480").Selected = true;

                SerialNumber1.Create();
			}
		}

		private void cancel_Click(object sender,EventArgs e) {
			Forum.Redirect(Pages.forum);
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			cancel.Click += new EventHandler(cancel_Click);
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

		static public string CreatePassword(int length) {
			string valid = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
			string res = "";
			Random rnd = new Random();
			while(0<length--)
				res += valid[rnd.Next(valid.Length)];
			return res;
		}

		protected void ForumRegister_Click(object sender, System.EventArgs e)
		{
            if (!SerialNumber1.CheckSN(snvTxt1.Text))
            {
				AddLoadMessage("请输入正确的验证码!");
                SerialNumber1.Create();
                return;
            }



			if(Page.IsValid) 
			{
                if (UserName.Text.Trim().Length < 3)
                {
                    AddLoadMessage("用户名长度必须大于或等于3位！");
                    return;
                }

                if (Password.Text.Trim().Length < 3)
                {
                    AddLoadMessage("密码长度必须大于或等于3位！");
                    return;
                }

                if(!Utils.IsValidEmail(Email.Text))
				{
					AddLoadMessage(GetText("BAD_EMAIL"));
					return;
				}

				if(DB.user_find(PageBoardID,false,UserName.Text,Email.Text).Rows.Count>0) 
				{
					AddLoadMessage(GetText("ALREADY_REGISTERED"));
					return;
				}

				DB.user_register(this,PageBoardID,UserName.Text,Password.Text,Email.Text,Location.Text,HomePage.Text,TimeZones.SelectedItem.Value,BoardSettings.EmailVerification);
				if(BoardSettings.EmailVerification)
					Forum.Redirect(Pages.info,"i=3");
				else
					Forum.Redirect(Pages.login);
			}
		}
	}
}

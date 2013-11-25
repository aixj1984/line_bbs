using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Globalization;

namespace yaf.pages
{
	/// <summary>
	/// Summary description for editprofile.
	/// </summary>
	public partial class cp_profile : ForumPage
	{

		public cp_profile()
			: base( "CP_PROFILE" )
		{
		}

		protected void Page_Load( object sender, System.EventArgs e )
		{
			if ( !User.IsAuthenticated )
			{
				if ( User.CanLogin )
					Forum.Redirect( Pages.login, "ReturnUrl={0}", Utils.GetSafeRawUrl() );
				else
					Forum.Redirect( Pages.forum );
			}

			if ( !IsPostBack )
			{
				BindData();

				PageLinks.AddLink( BoardSettings.Name, Forum.GetLink( Pages.forum ) );
				PageLinks.AddLink( PageUserName, "" );
			}
		}

		private void BindData()
		{
			DataRow row;

			Groups.DataSource = DB.usergroup_list( PageUserID );

			// Bind			
			DataBind();
			using ( DataTable dt = DB.user_list( PageBoardID, PageUserID, true ) )
			{
				row = dt.Rows [0];
			}

			TitleUserName.Text = Server.HtmlEncode( ( string ) row ["Name"] );
			AccountEmail.Text = row ["Email"].ToString();
			Name.Text = Server.HtmlEncode( ( string ) row ["Name"] );
			Joined.Text = FormatDateTime( ( DateTime ) row ["Joined"] );
			NumPosts.Text = String.Format( "{0:N0}", row ["NumPosts"] );

			if ( BoardSettings.AvatarUpload && row ["HasAvatarImage"] != null && long.Parse( row ["HasAvatarImage"].ToString() ) > 0 )
			{
				AvatarImage.Src = String.Format( "{0}resource.ashx?u={1}", Data.ForumRoot, PageUserID );
			}
			else if ( row ["Avatar"].ToString().Length > 0 ) // Took out BoardSettings.AvatarRemote
			{
				AvatarImage.Src = String.Format( "{3}resource.ashx?url={0}&width={1}&height={2}",
					Server.UrlEncode( row ["Avatar"].ToString() ),
					BoardSettings.AvatarWidth,
					BoardSettings.AvatarHeight,
					Data.ForumRoot );
			}
			else
			{
				AvatarImage.Visible = false;
			}
		}

		#region Web Form Designer generated code
		override protected void OnInit( EventArgs e )
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit( e );
		}

		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{

		}
		#endregion
	}
}

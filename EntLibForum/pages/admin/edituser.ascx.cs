using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace yaf.pages.admin
{
	/// <summary>
	/// Summary description for edituser.
	/// </summary>
	public partial class edituser : AdminPage
	{
		protected void Page_Load( object sender, System.EventArgs e )
		{
			// we're in the admin section...
			ProfileEditControl.InAdminPages = true;
			SignatureEditControl.InAdminPages = true;
			AvatarEditControl.InAdminPages = true;

			if ( !IsPostBack )
			{
				if ( Request.QueryString ["u"] != null )
					if ( !IsHostAdmin && IsUserHostAdmin( Convert.ToInt32( Request.QueryString ["u"] ) ) )
					{
						Data.AccessDenied();
					}

				PageLinks.AddLink( BoardSettings.Name, Forum.GetLink( Pages.forum ) );
				PageLinks.AddLink( "Administration", Forum.GetLink( Pages.admin_admin ) );
				PageLinks.AddLink( "Users", Forum.GetLink( Pages.admin_users ) );
				PageLinks.AddLink( "Edit", "" );

				BasicEditLink.Text = "User Details";
				BasicEditLink.CommandArgument = "QuickEditView";

				GroupLink.Text = "User Groups";
				GroupLink.CommandArgument = "GroupEditControl";

				SignatureLink.Text = "Signature Edit";
				SignatureLink.CommandArgument = "SignatureEditControl";

				ProfileLink.Text = "Profile Edit";
				ProfileLink.CommandArgument = "ProfileEditControl";

				SuspendLink.Text = "Suspend User";
				SuspendLink.CommandArgument = "SuspendUserControl";

				PointsLink.Text = "User Points";
				PointsLink.CommandArgument = "UserPointsView";

				AvatarLink.Text = "Avatar Edit";
				AvatarLink.CommandArgument = "AvatarEditView";

				if ( Request.QueryString ["av"] != null )
				{
					// show the avatar section...
					UserAdminMultiView.SetActiveView( AvatarEditView );
				}
			}
		}

		protected void Edit1_Click( object sender, System.EventArgs e )
		{
			UserAdminMultiView.SetActiveView( QuickEditView );
		}
		protected void Edit2_Click( object sender, System.EventArgs e )
		{
			UserAdminMultiView.SetActiveView( GroupsEditView );
		}
		protected void Edit3_Click( object sender, System.EventArgs e )
		{
			UserAdminMultiView.SetActiveView( ProfileEditView );
		}
		protected void Edit4_Click( object sender, System.EventArgs e )
		{
			UserAdminMultiView.SetActiveView( SignatureEditView );
		}
		protected void Edit5_Click( object sender, System.EventArgs e )
		{
			UserAdminMultiView.SetActiveView( SuspendUserView );
		}
		protected void Edit6_Click( object sender, System.EventArgs e )
		{
			UserAdminMultiView.SetActiveView( UserPointsView );
		}
		protected void Edit7_Click( object sender, System.EventArgs e )
		{
			UserAdminMultiView.SetActiveView( AvatarEditView );
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

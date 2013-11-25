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
	/// Summary description for moderate.
	/// </summary>
	public partial class mod_forumuser : ForumPage
	{

		public mod_forumuser()
			: base( "MOD_FORUMUSER" )
		{
		}

		protected void Page_Load( object sender, System.EventArgs e )
		{
			if ( !ForumModeratorAccess )
				Data.AccessDenied();

			if ( !IsPostBack )
			{
				FindUsers.Text = GetText( "FIND" );
				Update.Text = GetText( "UPDATE" );
				Cancel.Text = GetText( "CANCEL" );

				if ( ForumControl.LockedForum == 0 )
				{
					PageLinks.AddLink( BoardSettings.Name, Forum.GetLink( Pages.forum ) );
					PageLinks.AddLink( PageCategoryName, Forum.GetLink( Pages.forum, "c={0}", PageCategoryID ) );
				}
				PageLinks.AddForumLinks( PageForumID );
				PageLinks.AddLink( GetText( "TITLE" ), "" );

				BindData();
				if ( Request.QueryString ["u"] != null )
				{
					using ( DataTable dt = DB.userforum_list( Request.QueryString ["u"], PageForumID ) )
					{
						foreach ( DataRow row in dt.Rows )
						{
							UserName.Text = row ["Name"].ToString();
							UserName.Enabled = false;
							FindUsers.Visible = false;
							AccessMaskID.Items.FindByValue( row ["AccessMaskID"].ToString() ).Selected = true;
						}
					}
				}
			}
		}

		private void BindData()
		{
			AccessMaskID.DataSource = DB.accessmask_list( PageBoardID, null );
			AccessMaskID.DataValueField = "AccessMaskID";
			AccessMaskID.DataTextField = "Name";
			DataBind();
		}

		private void FindUsers_Click( object sender, System.EventArgs e )
		{
			if ( UserName.Text.Length < 2 ) return;

			using ( DataTable dt = DB.user_find( PageBoardID, true, UserName.Text, null ) )
			{
				if ( dt.Rows.Count > 0 )
				{
					ToList.DataSource = dt;
					ToList.DataValueField = "UserID";
					ToList.DataTextField = "Name";
					ToList.Visible = true;
					UserName.Visible = false;
					FindUsers.Visible = false;
				}
				DataBind();
			}
		}

		private void Update_Click( object sender, System.EventArgs e )
		{
			if ( UserName.Text.Length <= 0 )
			{
				AddLoadMessage( GetText( "NO_SUCH_USER" ) );
				return;
			}
			if ( ToList.Visible )
				UserName.Text = ToList.SelectedItem.Text;

			using ( DataTable dt = DB.user_find( PageBoardID, false, UserName.Text, null ) )
			{
				if ( dt.Rows.Count != 1 )
				{
					AddLoadMessage( GetText( "NO_SUCH_USER" ) );
					return;
				}
				else if ( ( int ) dt.Rows [0] ["IsGuest"] > 0 )
				{
					AddLoadMessage( GetText( "NOT_GUEST" ) );
					return;
				}

				DB.userforum_save( dt.Rows [0] ["UserID"], PageForumID, AccessMaskID.SelectedValue );
				Forum.Redirect( Pages.moderate, "f={0}", PageForumID );
			}
		}

		private void Cancel_Click( object sender, System.EventArgs e )
		{
			Forum.Redirect( Pages.moderate, "f={0}", PageForumID );
		}

		#region Web Form Designer generated code
		override protected void OnInit( EventArgs e )
		{
			FindUsers.Click += new EventHandler( FindUsers_Click );
			Update.Click += new EventHandler( Update_Click );
			Cancel.Click += new EventHandler( Cancel_Click );
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

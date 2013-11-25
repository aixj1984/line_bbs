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
	/// Summary description for emailtopic.
	/// </summary>
	public partial class emailtopic : ForumPage
	{

		public emailtopic()
			: base( "EMAILTOPIC" )
		{
		}

		protected void Page_Load( object sender, System.EventArgs e )
		{
			if ( Request.QueryString ["t"] == null || !ForumReadAccess )
				Data.AccessDenied();

			if ( !IsPostBack )
			{
				if ( ForumControl.LockedForum == 0 )
				{
					PageLinks.AddLink( BoardSettings.Name, Forum.GetLink( Pages.forum ) );
					PageLinks.AddLink( PageCategoryName, Forum.GetLink( Pages.forum, "c={0}", PageCategoryID ) );
				}
				PageLinks.AddForumLinks( PageForumID );
				PageLinks.AddLink( PageTopicName, Forum.GetLink( Pages.posts, "t={0}", PageTopicID ) );

				SendEmail.Text = GetText( "send" );

				Subject.Text = PageTopicName;
				string msg = Utils.ReadTemplate( "emailtopic.txt" );
				msg = msg.Replace( "{link}", String.Format( "{0}{1}", ServerURL, Forum.GetLink( Pages.posts, "t={0}", PageTopicID ) ) );
				msg = msg.Replace( "{user}", PageUserName );
				Message.Text = msg;
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

		protected void SendEmail_Click( object sender, System.EventArgs e )
		{
			if ( EmailAddress.Text.Length == 0 )
			{
				AddLoadMessage( GetText( "need_email" ) );
				return;
			}

			try
			{
				string senderemail;
				using ( DataTable dt = DB.user_list( PageBoardID, PageUserID, true ) )
					senderemail = ( string ) dt.Rows [0] ["Email"];

				//  Build a MailMessage
				Utils.SendMail( this, senderemail, EmailAddress.Text, Subject.Text, Message.Text );
				Forum.Redirect( Pages.posts, "t={0}", PageTopicID );
			}
			catch ( Exception x )
			{
				DB.eventlog_create( PageUserID, this, x );
				AddLoadMessage( String.Format( GetText( "failed" ), x.Message ) );
			}
		}
	}
}

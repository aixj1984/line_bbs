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
	/// Summary description for inbox.
	/// </summary>
	public partial class cp_message : ForumPage
	{

		public cp_message()
			: base( "CP_MESSAGE" )
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
				BindData();
		}

		private void BindData()
		{
			if ( Request.QueryString ["pm"] == null )
			{
				Data.AccessDenied();
				return;
			}

			using ( DataTable dt = DB.userpmessage_list( Request.QueryString ["pm"] ) )
			{
				foreach ( DataRow row in dt.Rows )
				{
					if ( ( int ) row ["ToUserID"] != PageUserID && ( int ) row ["FromUserID"] != PageUserID )
						Data.AccessDenied();

					PageLinks.AddLink( BoardSettings.Name, Forum.GetLink( Pages.forum ) );
					PageLinks.AddLink( PageUserName, Forum.GetLink( Pages.cp_profile ) );
					if ( ( int ) row ["ToUserID"] == PageUserID )
						PageLinks.AddLink( GetText( "INBOX" ), Forum.GetLink( Pages.cp_inbox ) );
					else
						PageLinks.AddLink( GetText( "SENTITEMS" ), Forum.GetLink( Pages.cp_inbox, "sent=1" ) );
					PageLinks.AddLink( HtmlEncode( row ["Subject"] ), "" );
				}
				Inbox.DataSource = dt;
			}
			DataBind();
			DB.pmessage_markread( Request.QueryString ["pm"] );
		}

		protected string FormatBody( object o )
		{
			DataRowView row = ( DataRowView ) o;
			return FormatMsg.FormatMessage( this, row ["Body"].ToString(), Convert.ToInt32( row ["Flags"] ) );
		}

		private void Inbox_ItemCommand( object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e )
		{
			if ( e.CommandName == "delete" )
			{
				DB.userpmessage_delete( e.CommandArgument );
				BindData();
				AddLoadMessage( GetText( "msg_deleted" ) );
			}
			else if ( e.CommandName == "reply" )
			{
				Forum.Redirect( Pages.pmessage, "p={0}&q=0", e.CommandArgument );
			}
			else if ( e.CommandName == "quote" )
			{
				Forum.Redirect( Pages.pmessage, "p={0}&q=1", e.CommandArgument );
			}
		}

		protected void DeleteMessage_Load( object sender, System.EventArgs e )
		{
			( ( LinkButton ) sender ).Attributes ["onclick"] = String.Format( "return confirm('{0}')", GetText( "confirm_deletemessage" ) );
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
			this.Inbox.ItemCommand += new System.Web.UI.WebControls.RepeaterCommandEventHandler( this.Inbox_ItemCommand );
		}
		#endregion
	}
}

using System;
using System.Web;
using System.Reflection;
using System.Configuration;
using yaf.pages;

namespace yaf
{
	public class Config
	{
		private System.Xml.XmlNode m_section;

		public Config( System.Xml.XmlNode node )
		{
			m_section = node;
		}

		public string this [string key]
		{
			get
			{
				System.Xml.XmlNode node = m_section.SelectSingleNode( key );
				if ( node != null )
					return node.InnerText;
				else
					return null;
			}
		}

		static private Config configSection
		{
			get
			{
				Config config = ( Config ) System.Configuration.ConfigurationManager.GetSection( "yafnet" );
				if ( config == null )
				{
                    if (System.Web.HttpContext.Current == null)
                    {
                        throw new ApplicationException("The main forum control is not design-time compatible due to it's complexity. Please load the individual page controls to modify the forum.");
                    }
                    else
                        throw new ApplicationException("Failed to get configuration from Web.config.");
				}
				return config;
			}
		}

		static public Config yafSection
		{
			get
			{
				return configSection;
			}
		}

		static public string BoardID
		{
			get
			{
				return configSection[ "boardid" ];
			}
		}

		static public string CategoryID
		{
			get
			{
				return configSection[ "categoryid" ];
			}
		}

		static public string UploadDir
		{
			get
			{
				return configSection[ "uploaddir" ];
			}
		}

		static public string Root
		{
			get
			{
				return configSection[ "root" ];
			}
		}

		static public string LogToMail
		{
			get
			{
				return configSection[ "logtomail" ];
			}
		}

		static public string ConnectionString
		{
			get
			{
				return configSection[ "connstr" ];
			}
		}

		static public bool IsCustom
		{
			get
			{
				return ( configSection ["CustomUserClass"] != null && configSection["CustomUserAssembly"] != null );
			}
		}

		static public IUrlBuilder UrlBuilder
		{
			get
			{
				if ( HttpContext.Current.Application ["yaf_UrlBuilder"] == null )
				{
					string urlAssembly;

					urlAssembly = "yaf.UrlBuilder,yaf";

					HttpContext.Current.Application ["yaf_UrlBuilder"] = Activator.CreateInstance( Type.GetType( urlAssembly ) );
				}

				return ( IUrlBuilder ) HttpContext.Current.Application ["yaf_UrlBuilder"];
			}
		}

        static public bool EnableMailServer
        {
            get
            {
                
                bool enableMail = false;
                try
                {
                    enableMail = bool.Parse(ConfigurationManager.AppSettings["EnableMailServer"]);
                }
                catch
                {
                    enableMail = false;
                }

                return enableMail;
            }
        }

        static public string WebSiteURL
        {
            get
            {
                try
                {
                    return ConfigurationManager.AppSettings["WebSiteURL"];
                }
                catch
                {
                    return "http://www.hubeici.com/index.shtml";
                }
            }
        }

        static public string BlogURL
        {
            get
            {
                try
                {
                    return ConfigurationManager.AppSettings["BlogURL"];
                }
                catch
                {
                    return "http://www.hubeici.com/index.shtml";
                }
            }
        }
	}
}

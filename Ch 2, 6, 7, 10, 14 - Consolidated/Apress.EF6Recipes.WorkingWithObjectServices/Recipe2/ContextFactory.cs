using System;
using System.Collections.Generic;
using System.Data.Entity.Core.EntityClient;
using System.Data.Entity.Core.Mapping;
using System.Data.Entity.Core.Metadata.Edm;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace Apress.EF6Recipes.WorkingWithObjectServices.Recipe2
{
    public static class ContextFactory
    {
        static string connString = @"Data Source=localhost;
           initial catalog=EFRecipes;Integrated Security=True;";
        private static MetadataWorkspace workspace = CreateWorkSpace();

        public static EFRecipesEntities CreateContext()
        {
            var conn = new EntityConnection(workspace, 
                             new SqlConnection(connString));
            return new EFRecipesEntities(conn);
        }

        private static MetadataWorkspace CreateWorkSpace()
        {
            string sql = @"select csdl,msl,ssdl from Chapter7.Definitions";
            XmlReader csdlReader = null;
            XmlReader mslReader = null;
            XmlReader ssdlReader = null;

            using (var cn = new SqlConnection(connString))
            {
                using (var cmd = new SqlCommand(sql, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        csdlReader = reader.GetSqlXml(0).CreateReader();
                        mslReader = reader.GetSqlXml(1).CreateReader();
                        ssdlReader = reader.GetSqlXml(2).CreateReader();
                    }
                }
            }

            var edmCollection = new EdmItemCollection(new XmlReader[] 
                                                   { csdlReader });
            var ssdlCollection = new StoreItemCollection(new XmlReader[] 
                                                   { ssdlReader });
            var mappingCollection = new StorageMappingItemCollection(
                edmCollection, ssdlCollection, new XmlReader[] { mslReader });

            var localWorkspace = new MetadataWorkspace();
            localWorkspace.RegisterItemCollection(edmCollection);
            localWorkspace.RegisterItemCollection(ssdlCollection);
            localWorkspace.RegisterItemCollection(mappingCollection);
            return localWorkspace;
        }
    }
}

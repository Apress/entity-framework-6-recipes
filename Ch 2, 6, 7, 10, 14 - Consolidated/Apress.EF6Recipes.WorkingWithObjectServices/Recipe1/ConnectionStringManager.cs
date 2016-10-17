using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Entity.Core.EntityClient;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace Apress.EF6Recipes.WorkingWithObjectServices.Recipe1
{
    public static class ConnectionStringManager
    {
        public static string EFConnection = GetConnection();

        private static string GetConnection()
        {
            var sqlBuilder = new SqlConnectionStringBuilder();

            sqlBuilder.DataSource = ConfigurationManager.AppSettings["SqlDataSource"];

            // fill in the rest
            sqlBuilder.InitialCatalog = ConfigurationManager.AppSettings["SqlInitialCatalog"];
            sqlBuilder.IntegratedSecurity = true;
            sqlBuilder.MultipleActiveResultSets = true;

            var eBuilder = new EntityConnectionStringBuilder();
            eBuilder.Provider = "System.Data.SqlClient";
            eBuilder.Metadata =
                  "res://*/Recipe1.csdl|res://*/Recipe1.ssdl|res://*/Recipe1.msl";
            eBuilder.ProviderConnectionString = sqlBuilder.ToString();
            return eBuilder.ToString();
        }

    }
}

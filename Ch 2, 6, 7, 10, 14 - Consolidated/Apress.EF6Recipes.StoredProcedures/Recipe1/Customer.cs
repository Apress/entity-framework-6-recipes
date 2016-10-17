using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace Apress.EF6Recipes.StoredProcedures.Recipe1
{
    public class Customer
    {
        public int CustomerId { get; set; }
        public string Name { get; set; }
        public string Company { get; set; }
        public string ContactTitle { get; set; }
    }
}

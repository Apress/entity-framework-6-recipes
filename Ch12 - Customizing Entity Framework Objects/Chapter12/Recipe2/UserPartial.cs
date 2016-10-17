using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CustomEFRecipe2
{
    public partial class User
    {
       // void OnUserNameChanging(string value);
        void OnUserNameChanging(string value)
        {
            if (value.Length > 5)
                Console.WriteLine("{0}'s UserName changing to {1}, OK!",
                                   this.FullName, value);
            else
                Console.WriteLine("{0}'s UserName changing to {1}, Too Short!",
                                   this.FullName, value);
        }

        void OnUserNameChanged()
        {
            this.IsActive = (this.UserName.Length > 5);
        }
    }
}

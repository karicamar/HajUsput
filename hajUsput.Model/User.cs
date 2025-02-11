using System;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.ConstrainedExecution;

namespace hajUsput.Model
{

    public partial class User
    {
        public int UserId { get; set; }

        public string FirstName { get; set; } 

        public string LastName { get; set; } 

        public int? GenderId { get; set; }

        public string Username { get; set; } 

        public string Email { get; set; } 

        public string PhoneNumber { get; set; }

        public bool IsBlocked { get; set; }

        public virtual ICollection<UserRole> UserRoles { get; set; } = new List<UserRole>();
    }

}

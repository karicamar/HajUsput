using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace hajUsput.Model
{
    public partial class UserRole
    {
        public int UserRoleId { get; set; }

        public int? UserId { get; set; }

        public int? RoleId { get; set; }

        public virtual Role Role { get; set; }
    }
}

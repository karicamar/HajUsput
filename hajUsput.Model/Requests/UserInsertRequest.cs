using System;
using System.Collections.Generic;
using System.Text;

namespace hajUsput.Model.Requests
{
    public class UserInsertRequest
    {
        

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public int? GenderId { get; set; }

        public string Username { get; set; }

        public string Email { get; set; }

        public string PhoneNumber { get; set; }

       
        public string Password { get; set; }

        
        public DateTime? RegistrationDate = DateTime.Now;

    }
}

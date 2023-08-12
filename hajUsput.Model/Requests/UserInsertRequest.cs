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

        // [Required]
        //[Compare("PasswordConfirm", ErrorMessage = "Passwords do not match.")]
        public string Password { get; set; }

        //[Compare("Password", ErrorMessage = "Passwords do not match.")]
        public string PasswordConfirm { get; set; }
        public DateTime? RegistrationDate = DateTime.Now;

    }
}

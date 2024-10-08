﻿using System;
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

        // public DateTime? RegistrationDate { get; set; }
        //public virtual ICollection<Booking> Bookings { get; set; } = new List<Booking>();

        //public virtual ICollection<Car> Cars { get; set; } = new List<Car>();

        //public virtual Gender? Gender { get; set; }

        //public virtual ICollection<MessageNotification> MessageNotificationReceivers { get; set; } = new List<MessageNotification>();

        //public virtual ICollection<MessageNotification> MessageNotificationSenders { get; set; } = new List<MessageNotification>();

        //public virtual ICollection<Payment> Payments { get; set; } = new List<Payment>();

        //public virtual ICollection<ReviewRating> ReviewRatings { get; set; } = new List<ReviewRating>();

        //public virtual ICollection<Ride> Rides { get; set; } = new List<Ride>();
        public bool IsBlocked { get; set; }

        public virtual ICollection<UserRole> UserRoles { get; set; } = new List<UserRole>();
    }

}

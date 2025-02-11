using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace hajUsput.Services.Database
{
    public partial class _180072Context
    {
        private void Seed(ModelBuilder modelBuilder) {

            modelBuilder.Entity<Gender>().HasData(
                        new Gender { GenderId = 1, GenderName = "Male" },
                        new Gender { GenderId = 2, GenderName = "Female" },
                        new Gender { GenderId = 3, GenderName = "Other" }

                    );
            
            modelBuilder.Entity<User>().HasData(
                new User
                {
                    UserId = 1,
                    FirstName = "Desktop",
                    LastName = "Admin",
                    GenderId = 3,
                    Username = "desktop",
                    Email = "desktop@example.com",
                    PasswordHash = "2cbdZqHhy9RrytXZahjsbxwei/E=", // Password: test
                    PasswordSalt = "uL8kIBKEeCRKGdcpeVEywQ==",
                    PhoneNumber = "111111111",
                    RegistrationDate = DateTime.UtcNow,
                    IsBlocked = false
                },
                new User
                {
                    UserId = 2,
                    FirstName = "Mobile",
                    LastName = "User",
                    GenderId = 3,
                    Username = "mobile",
                    Email = "mobile@example.com",
                    PasswordHash = "B16o6u/bkUnb/UyRPjNvvC40QGg=", // Password: test
                    PasswordSalt = "iGZkmWiEvWTcgdKyA7nzsw==",
                    PhoneNumber = "222222222",
                    RegistrationDate = DateTime.UtcNow,
                    IsBlocked = false
                },
                new User
                {
                    UserId = 3,
                    FirstName = "John",
                    LastName = "Doe",
                    GenderId = 1,
                    Username = "john.doe",
                    Email = "john.doe@example.com",
                    PasswordHash = "wOk6vHp5cvY+Q8a0O6xAHnYZYFA=", // Password: password1
                    PasswordSalt = "6uWglWz8+FPXd0HaS+EJ2g==",
                    PhoneNumber = "333333333",
                    RegistrationDate = DateTime.UtcNow,
                    IsBlocked = false
                },
                new User
                {
                    UserId = 4,
                    FirstName = "Jane",
                    LastName = "Smith",
                    GenderId = 2,
                    Username = "jane.smith",
                    Email = "jane.smith@example.com",
                    PasswordHash = "4bW2W2Q0wnyY0E3POm9kPYJktVs=", // Password: password2
                    PasswordSalt = "oq7VOWmLurMri8cxiJbshA==",
                    PhoneNumber = "444444444",
                    RegistrationDate = DateTime.UtcNow,
                    IsBlocked = false
                },
                new User
                {
                    UserId = 5,
                    FirstName = "Alice",
                    LastName = "Johnson",
                    GenderId = 2,
                    Username = "alice.johnson",
                    Email = "alice.johnson@example.com",
                    PasswordHash = "0FiR8gJfy/ED7BZ1ssAgkRX6h7g=", // Password: password3
                    PasswordSalt = "lI62DwXac3xk0tLIWBcj2g==",
                    PhoneNumber = "555555555",
                    RegistrationDate = DateTime.UtcNow,
                    IsBlocked = false
                },
                new User
                {
                    UserId = 6,
                    FirstName = "Bob",
                    LastName = "Williams",
                    GenderId = 1,
                    Username = "bob.williams",
                    Email = "bob.williams@example.com",
                    PasswordHash = "fTZsmb0NgGS8EOfoF0sQ0F9pR7M=", // Password: password4
                    PasswordSalt = "GTxGmBaI9/ioc94ljYuD9w==",
                    PhoneNumber = "666666666",
                    RegistrationDate = DateTime.UtcNow,
                    IsBlocked = false
                },
                new User
                {
                    UserId = 7,
                    FirstName = "David",
                    LastName = "Taylor",
                    GenderId = 1,
                    Username = "david.taylor",
                    Email = "david.taylor@example.com",
                    PasswordHash = "hashedpassword7",
                    PasswordSalt = "salt7",
                    PhoneNumber = "9988776655",
                    RegistrationDate = DateTime.UtcNow,
                    IsBlocked = true
                },
                new User
                {
                    UserId = 8,
                    FirstName = "Olivia",
                    LastName = "Moore",
                    GenderId = 2,
                    Username = "olivia.moore",
                    Email = "olivia.moore@example.com",
                    PasswordHash = "hashedpassword8",
                    PasswordSalt = "salt8",
                    PhoneNumber = "3344556677",
                    RegistrationDate = DateTime.UtcNow,
                    IsBlocked = false
                }
            );

            modelBuilder.Entity<CarMake>().HasData(
new CarMake
{
    CarMakeId = 1,
    Name = "Toyota"
},
new CarMake
{
    CarMakeId = 2,
    Name = "Ford"
},
new CarMake
{
    CarMakeId = 3,
    Name = "BMW"
},
new CarMake
{
    CarMakeId = 4,
    Name = "Mercedes"
},
new CarMake
{
    CarMakeId = 5,
    Name = "Hyundai"
},
new CarMake
{
    CarMakeId = 6,
    Name = "Volkswagen"
},
new CarMake
{
    CarMakeId = 7,
    Name = "Audi"
},
new CarMake
{
    CarMakeId = 8,
    Name = "Chevrolet"
}
);

            modelBuilder.Entity<Car>().HasData(
    new Car
    {
        CarId = 1,
        DriverId = 1,
        CarMakeId = 1, // Toyota
        Color = "Red",
        YearOfManufacture = 2015,
        LicensePlateNumber = "ABC-123"
    },
    new Car
    {
        CarId = 2,
        DriverId = 2,
        CarMakeId = 2, // Ford
        Color = "Blue",
        YearOfManufacture = 2018,
        LicensePlateNumber = "DEF-456"
    },
    new Car
    {
        CarId = 3,
        DriverId = 3,
        CarMakeId = 3, // BMW
        Color = "Black",
        YearOfManufacture = 2020,
        LicensePlateNumber = "GHI-789"
    },
    new Car
    {
        CarId = 4,
        DriverId = 4,
        CarMakeId = 4, // Mercedes
        Color = "White",
        YearOfManufacture = 2017,
        LicensePlateNumber = "JKL-012"
    },
    new Car
    {
        CarId = 5,
        DriverId = 5,
        CarMakeId = 5, // Hyundai
        Color = "Gray",
        YearOfManufacture = 2016,
        LicensePlateNumber = "MNO-345"
    },
    new Car
    {
        CarId = 6,
        DriverId = 6,
        CarMakeId = 6, // Volkswagen
        Color = "Silver",
        YearOfManufacture = 2019,
        LicensePlateNumber = "PQR-678"
    },
    new Car
    {
        CarId = 7,
        DriverId = 7,
        CarMakeId = 7, // Audi
        Color = "Green",
        YearOfManufacture = 2021,
        LicensePlateNumber = "STU-901"
    },
    new Car
    {
        CarId = 8,
        DriverId = 8,
        CarMakeId = 8, // Chevrolet
        Color = "Yellow",
        YearOfManufacture = 2014,
        LicensePlateNumber = "VWX-234"
    }
);

            modelBuilder.Entity<Location>().HasData(
    new Location
    {
        LocationId = 1,
        City = "Sarajevo",
        Country = "Bosnia and Herzegovina"
    },
    new Location
    {
        LocationId = 2,
        City = "Mostar",
        Country = "Bosnia and Herzegovina"
    },
    new Location
    {
        LocationId = 3,
        City = "Banja Luka",
        Country = "Bosnia and Herzegovina"
    },
    new Location
    {
        LocationId = 4,
        City = "Zagreb",
        Country = "Croatia"
    },
    new Location
    {
        LocationId = 5,
        City = "Belgrade",
        Country = "Serbia"
    },
    new Location
    {
        LocationId = 6,
        City = "Dubrovnik",
        Country = "Croatia"
    },
    new Location
    {
        LocationId = 7,
        City = "Podgorica",
        Country = "Montenegro"
    },
    new Location
    {
        LocationId = 8,
        City = "Ljubljana",
        Country = "Slovenia"
    }
);


            modelBuilder.Entity<Role>().HasData(
            new Role { RoleId = 1, RoleName = "Admin" },
            new Role { RoleId = 2, RoleName = "User" }
        );


            modelBuilder.Entity<UserRole>().HasData(
            new UserRole { UserRoleId = 1, UserId = 1, RoleId = 1 },
            new UserRole { UserRoleId = 2, UserId = 2, RoleId = 2 },
            new UserRole { UserRoleId = 3, UserId = 3, RoleId = 2 },
            new UserRole { UserRoleId = 4, UserId = 4, RoleId = 2 },
            new UserRole { UserRoleId = 5, UserId = 5, RoleId = 2 },
            new UserRole { UserRoleId = 6, UserId = 6, RoleId = 2 },
            new UserRole { UserRoleId = 7, UserId = 7, RoleId = 2 },
            new UserRole { UserRoleId = 8, UserId = 8, RoleId = 2 }
        );

            modelBuilder.Entity<Preference>().HasData(
     new Preference
     {
         PreferenceId = 1,
         UserId = 1,
         IsChatty = "I'm chatty!",
         AllowsMusic = "Prefer music!",
         AllowsSmoking = "No smoking!",
         AllowsPets = "I love pets."
     },
     new Preference
     {
         PreferenceId = 2,
         UserId = 2,
         IsChatty = "I'm the quiet type",
         AllowsMusic = "Prefer music!",
         AllowsSmoking = "No smoking!",
         AllowsPets = "No pets allowed"
     },
     new Preference
     {
         PreferenceId = 3,
         UserId = 3,
         IsChatty = "I'm chatty!",
         AllowsMusic = "Prefer silence",
         AllowsSmoking = "No smoking!",
         AllowsPets = "I love pets."
     },
     new Preference
     {
         PreferenceId = 4,
         UserId = 4,
         IsChatty = "I'm the quiet type",
         AllowsMusic = "Prefer silence",
         AllowsSmoking = "No smoking!",
         AllowsPets = "No pets allowed"
     },
     new Preference
     {
         PreferenceId = 5,
         UserId = 5,
         IsChatty = "I'm chatty!",
         AllowsMusic = "Prefer music!",
         AllowsSmoking = "I'm fine with smoking",
         AllowsPets = "No pets allowed"
     },
     new Preference
     {
         PreferenceId = 6,
         UserId = 6,
         IsChatty = "I'm the quiet type",
         AllowsMusic = "Prefer silence",
         AllowsSmoking = "I'm fine with smoking",
         AllowsPets = "I love pets."
     },
     new Preference
     {
         PreferenceId = 7,
         UserId = 7,
         IsChatty = "I'm chatty!",
         AllowsMusic = "Prefer music!",
         AllowsSmoking = "No smoking!",
         AllowsPets = "I love pets."
     },
     new Preference
     {
         PreferenceId = 8,
         UserId = 8,
         IsChatty = "I'm the quiet type",
         AllowsMusic = "Prefer music!",
         AllowsSmoking = "No smoking!",
         AllowsPets = "No pets allowed"
     }
 );


            modelBuilder.Entity<Ride>().HasData(
    new Ride { RideId = 1, DriverId = 1, DepartureLocationId = 1, DestinationLocationId = 2, DepartureDate = DateTime.Now.AddDays(-10).AddHours(9), Distance = 150.5, Duration = 120.0, AvailableSeats = 0, RideStatus = "Archived", Price = 25 },
    new Ride { RideId = 2, DriverId = 2, DepartureLocationId = 3, DestinationLocationId = 4, DepartureDate = DateTime.Now.AddDays(-5).AddHours(8), Distance = 200.3, Duration = 150.0, AvailableSeats = 1, RideStatus = "Archived", Price = 30 },
    new Ride { RideId = 3, DriverId = 3, DepartureLocationId = 2, DestinationLocationId = 5, DepartureDate = DateTime.Now.AddDays(3).AddHours(14), Distance = 320.7, Duration = 220.0, AvailableSeats = 4, RideStatus = "Scheduled", Price = 50 },
    new Ride { RideId = 4, DriverId = 4, DepartureLocationId = 6, DestinationLocationId = 7, DepartureDate = DateTime.Now.AddDays(-7).AddHours(10), Distance = 120.0, Duration = 90.0, AvailableSeats = 0, RideStatus = "Archived", Price = 20 },
    new Ride { RideId = 5, DriverId = 5, DepartureLocationId = 8, DestinationLocationId = 1, DepartureDate = DateTime.Now.AddDays(5).AddHours(7), Distance = 400.0, Duration = 300.0, AvailableSeats = 3, RideStatus = "Scheduled", Price = 60 },
    new Ride { RideId = 6, DriverId = 6, DepartureLocationId = 3, DestinationLocationId = 2, DepartureDate = DateTime.Now.AddDays(1).AddHours(16), Distance = 180.0, Duration = 130.0, AvailableSeats = 4, RideStatus = "Scheduled", Price = 35 },
    new Ride { RideId = 7, DriverId = 7, DepartureLocationId = 4, DestinationLocationId = 6, DepartureDate = DateTime.Now.AddDays(-8).AddHours(9), Distance = 300.0, Duration = 240.0, AvailableSeats = 0, RideStatus = "Archived", Price = 45 },
    new Ride { RideId = 8, DriverId = 8, DepartureLocationId = 5, DestinationLocationId = 7, DepartureDate = DateTime.Now.AddDays(-6).AddHours(12), Distance = 220.0, Duration = 180.0, AvailableSeats = 0, RideStatus = "Archived", Price = 40 },
    new Ride { RideId = 9, DriverId = 2, DepartureLocationId = 2, DestinationLocationId = 6, DepartureDate = DateTime.Now.AddDays(-3).AddHours(11), Distance = 180.0, Duration = 140.0, AvailableSeats = 0, RideStatus = "Archived", Price = 35 },
    new Ride { RideId = 10, DriverId = 2, DepartureLocationId = 3, DestinationLocationId = 8, DepartureDate = DateTime.Now.AddDays(4).AddHours(13), Distance = 250.0, Duration = 180.0, AvailableSeats = 2, RideStatus = "Scheduled", Price = 40 },
    new Ride { RideId = 11, DriverId = 2, DepartureLocationId = 5, DestinationLocationId = 1, DepartureDate = DateTime.Now.AddDays(-8).AddHours(10), Distance = 300.0, Duration = 220.0, AvailableSeats = 0, RideStatus = "Archived", Price = 45 },
    new Ride { RideId = 12, DriverId = 2, DepartureLocationId = 6, DestinationLocationId = 3, DepartureDate = DateTime.Now.AddDays(6).AddHours(15), Distance = 280.0, Duration = 200.0, AvailableSeats = 4, RideStatus = "Scheduled", Price = 50 },
    new Ride { RideId = 13, DriverId = 2, DepartureLocationId = 4, DestinationLocationId = 2, DepartureDate = DateTime.Now.AddDays(-4).AddHours(9), Distance = 130.0, Duration = 100.0, AvailableSeats = 0, RideStatus = "Archived", Price = 30 },
    new Ride { RideId = 14, DriverId = 2, DepartureLocationId = 7, DestinationLocationId = 5, DepartureDate = DateTime.Now.AddDays(2).AddHours(17), Distance = 260.0, Duration = 190.0, AvailableSeats = 3, RideStatus = "Scheduled", Price = 55 },
    new Ride { RideId = 15, DriverId = 2, DepartureLocationId = 8, DestinationLocationId = 6, DepartureDate = DateTime.Now.AddDays(-7).AddHours(12), Distance = 220.0, Duration = 170.0, AvailableSeats = 0, RideStatus = "Archived", Price = 40 },
    new Ride { RideId = 16, DriverId = 2, DepartureLocationId = 3, DestinationLocationId = 1, DepartureDate = DateTime.Now.AddDays(5).AddHours(14), Distance = 310.0, Duration = 230.0, AvailableSeats = 2, RideStatus = "Scheduled", Price = 60 }
);
            modelBuilder.Entity<Payment>().HasData(
    new Payment
    {
        PaymentId = 1,
        RideId = 1,
        PayerId = 2,
        Amount = 25.00m,
        PaymentStatus = "Completed", // Because ride is Archived
        PaymentMethod = "Stripe",
        PaymentDate = DateTime.Now.AddDays(-9)
    },
    new Payment
    {
        PaymentId = 2,
        RideId = 2,
        PayerId = 3,
        Amount = 30.00m,
        PaymentStatus = "Completed", // Because ride is Archived
        PaymentMethod = "Stripe",
        PaymentDate = DateTime.Now.AddDays(-4)
    },
    new Payment
    {
        PaymentId = 3,
        RideId = 3,
        PayerId = 4,
        Amount = 50.00m,
        PaymentStatus = "Pending", // Scheduled ride, not paid yet
        PaymentMethod = "Cash",
        PaymentDate = DateTime.Now
    },
    new Payment
    {
        PaymentId = 4,
        RideId = 4,
        PayerId = 5,
        Amount = 20.00m,
        PaymentStatus = "Completed", // Archived ride
        PaymentMethod = "Stripe",
        PaymentDate = DateTime.Now.AddDays(-6)
    },
    
    new Payment { PaymentId = 5, RideId = 9, PayerId = 3, Amount = 35.00m, PaymentStatus = "Completed", PaymentMethod = "Stripe", PaymentDate = DateTime.Now.AddDays(-2) },
    new Payment { PaymentId = 6, RideId = 11, PayerId = 4, Amount = 45.00m, PaymentStatus = "Completed", PaymentMethod = "Stripe", PaymentDate = DateTime.Now.AddDays(-7) },
    new Payment { PaymentId = 7, RideId = 15, PayerId = 5, Amount = 40.00m, PaymentStatus = "Completed", PaymentMethod = "Stripe", PaymentDate = DateTime.Now.AddDays(-6) },
    new Payment { PaymentId = 8, RideId = 16, PayerId = 6, Amount = 60.00m, PaymentStatus = "Pending", PaymentMethod = "Cash", PaymentDate = DateTime.Now }

);


            modelBuilder.Entity<Booking>().HasData(
    new Booking
    {
        BookingId = 1,
        RideId = 1,
        PassengerId = 2,
        BookingStatus = "Completed", // Because ride is Archived
        BookingDate = DateTime.Now.AddDays(-9),
        PaymentId = 1
    },
    new Booking
    {
        BookingId = 2,
        RideId = 2,
        PassengerId = 3,
        BookingStatus = "Completed", // Because ride is Archived
        BookingDate = DateTime.Now.AddDays(-4),
        PaymentId = 2
    },
    new Booking
    {
        BookingId = 3,
        RideId = 3,
        PassengerId = 4,
        BookingStatus = "Pending", // Scheduled ride, booking not confirmed yet
        BookingDate = DateTime.Now,
        PaymentId = 3
    },
    new Booking
    {
        BookingId = 4,
        RideId = 4,
        PassengerId = 5,
        BookingStatus = "Completed", // Because ride is Archived
        BookingDate = DateTime.Now.AddDays(-6),
        PaymentId = 4
    },

    new Booking { BookingId = 5, RideId = 9, PassengerId = 3, BookingStatus = "Completed", BookingDate = DateTime.Now.AddDays(-2), PaymentId = 5 },
    new Booking { BookingId = 6, RideId = 11, PassengerId = 4, BookingStatus = "Completed", BookingDate = DateTime.Now.AddDays(-7), PaymentId = 6 },
    new Booking { BookingId = 7, RideId = 15, PassengerId = 5, BookingStatus = "Completed", BookingDate = DateTime.Now.AddDays(-6), PaymentId = 7 },
    new Booking { BookingId = 8, RideId = 16, PassengerId = 6, BookingStatus = "Pending", BookingDate = DateTime.Now, PaymentId = 8 }

);

            modelBuilder.Entity<MessageNotification>().HasData(
    new MessageNotification
    {
        MessageId = 1,
        SenderId = 1,
        ReceiverId = 2,
        MessageContent = "Hi, are you available for a ride tomorrow?",
        MessageDate = DateTime.Now.AddMinutes(-120)
    },
    new MessageNotification
    {
        MessageId = 2,
        SenderId = 2,
        ReceiverId = 1,
        MessageContent = "Yes, I am. Let me know the time.",
        MessageDate = DateTime.Now.AddMinutes(-90)
    },
    new MessageNotification
    {
        MessageId = 3,
        SenderId = 3,
        ReceiverId = 4,
        MessageContent = "Can I bring a pet on this ride?",
        MessageDate = DateTime.Now.AddHours(-2)
    },
    new MessageNotification
    {
        MessageId = 4,
        SenderId = 4,
        ReceiverId = 3,
        MessageContent = "Yes, pets are allowed as long as they are well-behaved.",
        MessageDate = DateTime.Now.AddHours(-1)
    },
    new MessageNotification
    {
        MessageId = 5,
        SenderId = 5,
        ReceiverId = 6,
        MessageContent = "How many seats are available for this trip?",
        MessageDate = DateTime.Now.AddDays(-1)
    },
    new MessageNotification
    {
        MessageId = 6,
        SenderId = 6,
        ReceiverId = 5,
        MessageContent = "There are two seats available.",
        MessageDate = DateTime.Now.AddDays(-1).AddHours(-23)
    },
    new MessageNotification
    {
        MessageId = 7,
        SenderId = 7,
        ReceiverId = 8,
        MessageContent = "Is smoking allowed on this ride?",
        MessageDate = DateTime.Now.AddDays(-2)
    },
    new MessageNotification
    {
        MessageId = 8,
        SenderId = 8,
        ReceiverId = 7,
        MessageContent = "No, sorry, smoking is not allowed.",
        MessageDate = DateTime.Now.AddDays(-2).AddHours(-20)
    },
    new MessageNotification
    {
        MessageId = 9,
        SenderId = 1,
        ReceiverId = 3,
        MessageContent = "What time is the departure?",
        MessageDate = DateTime.Now.AddMinutes(-45)
    },
    new MessageNotification
    {
        MessageId = 10,
        SenderId = 3,
        ReceiverId = 1,
        MessageContent = "We’re leaving at 10:00 AM.",
        MessageDate = DateTime.Now.AddMinutes(-30)
    },
    new MessageNotification
    {
        MessageId = 11,
        SenderId = 2,
        ReceiverId = 6,
        MessageContent = "Will you stop for a break during the ride?",
        MessageDate = DateTime.Now.AddHours(-4)
    },
    new MessageNotification
    {
        MessageId = 12,
        SenderId = 6,
        ReceiverId = 2,
        MessageContent = "Yes, we’ll stop midway for a short break.",
        MessageDate = DateTime.Now.AddHours(-3)
    },
    new MessageNotification
    {
        MessageId = 13,
        SenderId = 4,
        ReceiverId = 8,
        MessageContent = "Can you confirm my booking?",
        MessageDate = DateTime.Now.AddHours(-6)
    },
    new MessageNotification
    {
        MessageId = 14,
        SenderId = 8,
        ReceiverId = 4,
        MessageContent = "Your booking has been confirmed.",
        MessageDate = DateTime.Now.AddHours(-5)
    },
    new MessageNotification
    {
        MessageId = 15,
        SenderId = 5,
        ReceiverId = 7,
        MessageContent = "Is it okay to bring a small bag?",
        MessageDate = DateTime.Now.AddDays(-3).AddHours(-2)
    },
    new MessageNotification
    {
        MessageId = 16,
        SenderId = 7,
        ReceiverId = 5,
        MessageContent = "Yes, no problem. See you soon!",
        MessageDate = DateTime.Now.AddDays(-3).AddHours(-1)
    }
);

            modelBuilder.Entity<ReviewRating>().HasData(
      new ReviewRating { ReviewId = 1, DriverId = 1, ReviewerId = 2, RideId = 1, Rating = 5, Comments = "Great driver! Very punctual and friendly.", ReviewDate = DateTime.Now.AddDays(-7) },
      new ReviewRating { ReviewId = 2, DriverId = 3, ReviewerId = 4, RideId = 3, Rating = 4, Comments = "Good ride, but the car could have been cleaner.", ReviewDate = DateTime.Now.AddDays(-6) },
      new ReviewRating { ReviewId = 3, DriverId = 2, ReviewerId = 3, RideId = 9, Rating = 5, Comments = "Smooth ride and friendly conversation.", ReviewDate = DateTime.Now.AddDays(-2) },
      new ReviewRating { ReviewId = 4, DriverId = 3, ReviewerId = 2, RideId = 3, Rating = 4, Comments = "Safe driving, but arrived slightly late.", ReviewDate = DateTime.Now.AddDays(-6) }

      );


        }

    }
}

/*
 * 
       

        modelBuilder.Entity<Role>().HasData(
            new Role { RoleId = 1, RoleName = "Admin" },
            new Role { RoleId = 2, RoleName = "User" }
        );

       

        modelBuilder.Entity<UserRole>().HasData(
            new UserRole { UserRoleId = 1, UserId = 1, RoleId = 1 },
            new UserRole { UserRoleId = 2, UserId = 2, RoleId = 2 }
        );

        modelBuilder.Entity<Location>().HasData(
            new Location { LocationId = 1, City = "Frankfurt", Country = "Germany" },
            new Location { LocationId = 2, City = "Tuzla", Country = "BiH" }
        );

        modelBuilder.Entity<Car>().HasData(
            new Car { CarId = 1, CarType = "Sedan", Color = "Red", LicensePlateNumber = "ABC123", Make = "Toyota", DriverId = 1 }
        );

        modelBuilder.Entity<Ride>().HasData(
            new Ride { RideId = 1, DepartureDate = DateTime.Now, RideStatus = "Scheduled", DepartureLocationId = 1, DestinationLocationId = 2, DriverId = 1 }
        );

        modelBuilder.Entity<Booking>().HasData(
            new Booking { BookingId = 1, BookingDate = DateTime.Now, BookingStatus = "Confirmed", PassengerId = 2, RideId = 1 }
        );

        modelBuilder.Entity<Payment>().HasData(
            new Payment { PaymentId = 1, Amount = 20.00m, PaymentDate = DateTime.Now, PaymentStatus = "Archived", PayerId = 2, RideId = 1 }
        );

        modelBuilder.Entity<ReviewRating>().HasData(
            new ReviewRating { ReviewId = 1, Comments = "Great ride!", ReviewDate = DateTime.Now, ReviewerId = 2, DriverId = 1, Rating=5 }
        );

        modelBuilder.Entity<MessageNotification>().HasData(
            new MessageNotification { MessageId = 1, MessageContent = "Your ride is scheduled.", MessageDate = DateTime.Now, SenderId = 1, ReceiverId = 2 }
        );
 */

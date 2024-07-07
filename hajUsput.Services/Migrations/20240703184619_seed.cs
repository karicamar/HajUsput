using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace hajUsput.Services.Migrations
{
    /// <inheritdoc />
    public partial class seed : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Genders",
                columns: new[] { "GenderId", "GenderName" },
                values: new object[,]
                {
                    { 1, "Male" },
                    { 2, "Female" }
                });

            migrationBuilder.InsertData(
                table: "Locations",
                columns: new[] { "LocationId", "City", "Country" },
                values: new object[,]
                {
                    { 1, "New York", "USA" },
                    { 2, "Los Angeles", "USA" }
                });

            migrationBuilder.InsertData(
                table: "Roles",
                columns: new[] { "RoleId", "RoleName" },
                values: new object[,]
                {
                    { 1, "Admin" },
                    { 2, "User" }
                });

            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "UserId", "Email", "FirstName", "GenderId", "IsBlocked", "LastName", "PasswordHash", "PasswordSalt", "PhoneNumber", "RegistrationDate", "Username" },
                values: new object[,]
                {
                    { 1, "admin@example.com", "Admin", 1, false, "User", "adminhash", "adminsalt", "1234567890", new DateTime(2024, 7, 3, 20, 46, 19, 466, DateTimeKind.Local).AddTicks(4625), "admin" },
                    { 2, "johndoe@example.com", "John", 1, false, "Doe", "johnhash", "johnsalt", "0987654321", new DateTime(2024, 7, 3, 20, 46, 19, 466, DateTimeKind.Local).AddTicks(4694), "johndoe" }
                });

            migrationBuilder.InsertData(
                table: "Cars",
                columns: new[] { "CarId", "CarType", "Color", "DriverId", "LicensePlateNumber", "Make", "YearOfManufacture" },
                values: new object[] { 1, "Sedan", "Red", 1, "ABC123", "Toyota", null });

            migrationBuilder.InsertData(
                table: "MessageNotifications",
                columns: new[] { "MessageId", "MessageContent", "MessageDate", "ReceiverId", "SenderId" },
                values: new object[] { 1, "Your ride is scheduled.", new DateTime(2024, 7, 3, 20, 46, 19, 466, DateTimeKind.Local).AddTicks(5773), 2, 1 });

            migrationBuilder.InsertData(
                table: "Rides",
                columns: new[] { "RideId", "AvailableSeats", "DepartureDate", "DepartureLocationId", "DestinationLocationId", "DriverId", "Price", "RideStatus" },
                values: new object[] { 1, null, new DateTime(2024, 7, 3, 20, 46, 19, 466, DateTimeKind.Local).AddTicks(4827), 1, 2, 1, null, "Scheduled" });

            migrationBuilder.InsertData(
                table: "UserRoles",
                columns: new[] { "UserRoleId", "RoleId", "UserId" },
                values: new object[,]
                {
                    { 1, 1, 1 },
                    { 2, 2, 2 }
                });

            migrationBuilder.InsertData(
                table: "Bookings",
                columns: new[] { "BookingId", "BookingDate", "BookingStatus", "PassengerId", "RideId" },
                values: new object[] { 1, new DateTime(2024, 7, 3, 20, 46, 19, 466, DateTimeKind.Local).AddTicks(5325), "Confirmed", 2, 1 });

            migrationBuilder.InsertData(
                table: "Payments",
                columns: new[] { "PaymentId", "Amount", "PayerId", "PaymentDate", "PaymentStatus", "RideId" },
                values: new object[] { 1, 20.00m, 2, new DateTime(2024, 7, 3, 20, 46, 19, 466, DateTimeKind.Local).AddTicks(5427), "Completed", 1 });

            migrationBuilder.InsertData(
                table: "ReviewRatings",
                columns: new[] { "ReviewId", "Comments", "Rating", "ReviewDate", "ReviewerId", "RideId" },
                values: new object[] { 1, "Great ride!", null, new DateTime(2024, 7, 3, 20, 46, 19, 466, DateTimeKind.Local).AddTicks(5662), 2, 1 });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Bookings",
                keyColumn: "BookingId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Cars",
                keyColumn: "CarId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Genders",
                keyColumn: "GenderId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "MessageNotifications",
                keyColumn: "MessageId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Payments",
                keyColumn: "PaymentId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "ReviewRatings",
                keyColumn: "ReviewId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "UserRoles",
                keyColumn: "UserRoleId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "UserRoles",
                keyColumn: "UserRoleId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Rides",
                keyColumn: "RideId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Roles",
                keyColumn: "RoleId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Roles",
                keyColumn: "RoleId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "UserId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Locations",
                keyColumn: "LocationId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Locations",
                keyColumn: "LocationId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "UserId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Genders",
                keyColumn: "GenderId",
                keyValue: 1);
        }
    }
}

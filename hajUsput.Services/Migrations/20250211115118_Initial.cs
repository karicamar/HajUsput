using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace hajUsput.Services.Migrations
{
    /// <inheritdoc />
    public partial class Initial : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "CarMakes",
                columns: table => new
                {
                    CarMakeId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CarMakes", x => x.CarMakeId);
                });

            migrationBuilder.CreateTable(
                name: "Genders",
                columns: table => new
                {
                    GenderId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    GenderName = table.Column<string>(type: "varchar(20)", unicode: false, maxLength: 20, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Genders__4E24E9F7F36896DA", x => x.GenderId);
                });

            migrationBuilder.CreateTable(
                name: "Locations",
                columns: table => new
                {
                    LocationId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    City = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: true),
                    Country = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Location__E7FEA497A22466C6", x => x.LocationId);
                });

            migrationBuilder.CreateTable(
                name: "Roles",
                columns: table => new
                {
                    RoleId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    RoleName = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Roles__8AFACE1A64D6009E", x => x.RoleId);
                });

            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    UserId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    FirstName = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: false),
                    LastName = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: false),
                    GenderId = table.Column<int>(type: "int", nullable: true),
                    Username = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: false),
                    Email = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false),
                    PasswordHash = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false),
                    PasswordSalt = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false),
                    PhoneNumber = table.Column<string>(type: "varchar(20)", unicode: false, maxLength: 20, nullable: true),
                    RegistrationDate = table.Column<DateTime>(type: "datetime", nullable: true),
                    IsBlocked = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Users__1788CC4C11AD459A", x => x.UserId);
                    table.ForeignKey(
                        name: "FK__Users__GenderId__3B75D760",
                        column: x => x.GenderId,
                        principalTable: "Genders",
                        principalColumn: "GenderId");
                });

            migrationBuilder.CreateTable(
                name: "Cars",
                columns: table => new
                {
                    CarId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DriverId = table.Column<int>(type: "int", nullable: true),
                    CarMakeId = table.Column<int>(type: "int", nullable: false),
                    Color = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: false),
                    YearOfManufacture = table.Column<int>(type: "int", nullable: true),
                    LicensePlateNumber = table.Column<string>(type: "varchar(20)", unicode: false, maxLength: 20, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Cars__68A0342EA4CAD173", x => x.CarId);
                    table.ForeignKey(
                        name: "FK_Cars_CarMakes_CarMakeId",
                        column: x => x.CarMakeId,
                        principalTable: "CarMakes",
                        principalColumn: "CarMakeId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK__Cars__DriverId__4CA06362",
                        column: x => x.DriverId,
                        principalTable: "Users",
                        principalColumn: "UserId");
                });

            migrationBuilder.CreateTable(
                name: "MessageNotifications",
                columns: table => new
                {
                    MessageId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    SenderId = table.Column<int>(type: "int", nullable: true),
                    ReceiverId = table.Column<int>(type: "int", nullable: true),
                    MessageContent = table.Column<string>(type: "text", nullable: true),
                    MessageDate = table.Column<DateTime>(type: "datetime", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__MessageN__C87C0C9C062F9B77", x => x.MessageId);
                    table.ForeignKey(
                        name: "FK__MessageNo__Recei__5441852A",
                        column: x => x.ReceiverId,
                        principalTable: "Users",
                        principalColumn: "UserId");
                    table.ForeignKey(
                        name: "FK__MessageNo__Sende__534D60F1",
                        column: x => x.SenderId,
                        principalTable: "Users",
                        principalColumn: "UserId");
                });

            migrationBuilder.CreateTable(
                name: "Preferences",
                columns: table => new
                {
                    PreferenceId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    IsChatty = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    AllowsMusic = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    AllowsSmoking = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    AllowsPets = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    UserId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Preferences", x => x.PreferenceId);
                    table.ForeignKey(
                        name: "FK_Preferences_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "UserId");
                });

            migrationBuilder.CreateTable(
                name: "Rides",
                columns: table => new
                {
                    RideId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DriverId = table.Column<int>(type: "int", nullable: true),
                    DepartureLocationId = table.Column<int>(type: "int", nullable: true),
                    DestinationLocationId = table.Column<int>(type: "int", nullable: true),
                    DepartureDate = table.Column<DateTime>(type: "datetime", nullable: false),
                    Distance = table.Column<double>(type: "float", nullable: false),
                    Duration = table.Column<double>(type: "float", nullable: false),
                    AvailableSeats = table.Column<int>(type: "int", nullable: true),
                    RideStatus = table.Column<string>(type: "varchar(20)", unicode: false, maxLength: 20, nullable: true),
                    Price = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Rides__C5B8C4F4C377711F", x => x.RideId);
                    table.ForeignKey(
                        name: "FK__Rides__Departure__44FF419A",
                        column: x => x.DepartureLocationId,
                        principalTable: "Locations",
                        principalColumn: "LocationId");
                    table.ForeignKey(
                        name: "FK__Rides__Destinati__45F365D3",
                        column: x => x.DestinationLocationId,
                        principalTable: "Locations",
                        principalColumn: "LocationId");
                    table.ForeignKey(
                        name: "FK__Rides__DriverId__440B1D61",
                        column: x => x.DriverId,
                        principalTable: "Users",
                        principalColumn: "UserId");
                });

            migrationBuilder.CreateTable(
                name: "UserRoles",
                columns: table => new
                {
                    UserRoleId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserId = table.Column<int>(type: "int", nullable: true),
                    RoleId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__UserRole__3D978A35A8E1E2E4", x => x.UserRoleId);
                    table.ForeignKey(
                        name: "FK__UserRoles__RoleI__3F466844",
                        column: x => x.RoleId,
                        principalTable: "Roles",
                        principalColumn: "RoleId");
                    table.ForeignKey(
                        name: "FK__UserRoles__UserI__3E52440B",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "UserId");
                });

            migrationBuilder.CreateTable(
                name: "Payments",
                columns: table => new
                {
                    PaymentId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    RideId = table.Column<int>(type: "int", nullable: true),
                    PayerId = table.Column<int>(type: "int", nullable: true),
                    Amount = table.Column<decimal>(type: "decimal(10,2)", nullable: true),
                    PaymentStatus = table.Column<string>(type: "varchar(20)", unicode: false, maxLength: 20, nullable: true),
                    PaymentMethod = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    PaymentDate = table.Column<DateTime>(type: "datetime", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Payments__9B556A3866677ECB", x => x.PaymentId);
                    table.ForeignKey(
                        name: "FK__Payments__PayerI__5812160E",
                        column: x => x.PayerId,
                        principalTable: "Users",
                        principalColumn: "UserId");
                    table.ForeignKey(
                        name: "FK__Payments__RideId__571DF1D5",
                        column: x => x.RideId,
                        principalTable: "Rides",
                        principalColumn: "RideId");
                });

            migrationBuilder.CreateTable(
                name: "ReviewRatings",
                columns: table => new
                {
                    ReviewId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DriverId = table.Column<int>(type: "int", nullable: true),
                    ReviewerId = table.Column<int>(type: "int", nullable: true),
                    RideId = table.Column<int>(type: "int", nullable: true),
                    Rating = table.Column<int>(type: "int", nullable: true),
                    Comments = table.Column<string>(type: "text", nullable: true),
                    ReviewDate = table.Column<DateTime>(type: "datetime", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__ReviewRa__74BC79CE3F044E1B", x => x.ReviewId);
                    table.ForeignKey(
                        name: "FK_ReviewRatings_Rides_RideId",
                        column: x => x.RideId,
                        principalTable: "Rides",
                        principalColumn: "RideId");
                    table.ForeignKey(
                        name: "FK_ReviewRatings_Users_DriverId",
                        column: x => x.DriverId,
                        principalTable: "Users",
                        principalColumn: "UserId");
                    table.ForeignKey(
                        name: "FK__ReviewRat__Revie__5070F446",
                        column: x => x.ReviewerId,
                        principalTable: "Users",
                        principalColumn: "UserId");
                });

            migrationBuilder.CreateTable(
                name: "Bookings",
                columns: table => new
                {
                    BookingId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    RideId = table.Column<int>(type: "int", nullable: true),
                    PassengerId = table.Column<int>(type: "int", nullable: true),
                    BookingStatus = table.Column<string>(type: "varchar(20)", unicode: false, maxLength: 20, nullable: true),
                    BookingDate = table.Column<DateTime>(type: "datetime", nullable: true),
                    PaymentId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Bookings__73951AED68E99F23", x => x.BookingId);
                    table.ForeignKey(
                        name: "FK_Bookings_Payments_PaymentId",
                        column: x => x.PaymentId,
                        principalTable: "Payments",
                        principalColumn: "PaymentId");
                    table.ForeignKey(
                        name: "FK__Bookings__Passen__49C3F6B7",
                        column: x => x.PassengerId,
                        principalTable: "Users",
                        principalColumn: "UserId");
                    table.ForeignKey(
                        name: "FK__Bookings__RideId__48CFD27E",
                        column: x => x.RideId,
                        principalTable: "Rides",
                        principalColumn: "RideId");
                });

            migrationBuilder.InsertData(
                table: "CarMakes",
                columns: new[] { "CarMakeId", "Name" },
                values: new object[,]
                {
                    { 1, "Toyota" },
                    { 2, "Ford" },
                    { 3, "BMW" },
                    { 4, "Mercedes" },
                    { 5, "Hyundai" },
                    { 6, "Volkswagen" },
                    { 7, "Audi" },
                    { 8, "Chevrolet" }
                });

            migrationBuilder.InsertData(
                table: "Genders",
                columns: new[] { "GenderId", "GenderName" },
                values: new object[,]
                {
                    { 1, "Male" },
                    { 2, "Female" },
                    { 3, "Other" }
                });

            migrationBuilder.InsertData(
                table: "Locations",
                columns: new[] { "LocationId", "City", "Country" },
                values: new object[,]
                {
                    { 1, "Sarajevo", "Bosnia and Herzegovina" },
                    { 2, "Mostar", "Bosnia and Herzegovina" },
                    { 3, "Banja Luka", "Bosnia and Herzegovina" },
                    { 4, "Zagreb", "Croatia" },
                    { 5, "Belgrade", "Serbia" },
                    { 6, "Dubrovnik", "Croatia" },
                    { 7, "Podgorica", "Montenegro" },
                    { 8, "Ljubljana", "Slovenia" }
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
                    { 1, "desktop@example.com", "Desktop", 3, false, "Admin", "2cbdZqHhy9RrytXZahjsbxwei/E=", "uL8kIBKEeCRKGdcpeVEywQ==", "111111111", new DateTime(2025, 2, 11, 11, 51, 17, 881, DateTimeKind.Utc).AddTicks(1529), "desktop" },
                    { 2, "mobile@example.com", "Mobile", 3, false, "User", "B16o6u/bkUnb/UyRPjNvvC40QGg=", "iGZkmWiEvWTcgdKyA7nzsw==", "222222222", new DateTime(2025, 2, 11, 11, 51, 17, 881, DateTimeKind.Utc).AddTicks(1539), "mobile" },
                    { 3, "john.doe@example.com", "John", 1, false, "Doe", "wOk6vHp5cvY+Q8a0O6xAHnYZYFA=", "6uWglWz8+FPXd0HaS+EJ2g==", "333333333", new DateTime(2025, 2, 11, 11, 51, 17, 881, DateTimeKind.Utc).AddTicks(1543), "john.doe" },
                    { 4, "jane.smith@example.com", "Jane", 2, false, "Smith", "4bW2W2Q0wnyY0E3POm9kPYJktVs=", "oq7VOWmLurMri8cxiJbshA==", "444444444", new DateTime(2025, 2, 11, 11, 51, 17, 881, DateTimeKind.Utc).AddTicks(1547), "jane.smith" },
                    { 5, "alice.johnson@example.com", "Alice", 2, false, "Johnson", "0FiR8gJfy/ED7BZ1ssAgkRX6h7g=", "lI62DwXac3xk0tLIWBcj2g==", "555555555", new DateTime(2025, 2, 11, 11, 51, 17, 881, DateTimeKind.Utc).AddTicks(1551), "alice.johnson" },
                    { 6, "bob.williams@example.com", "Bob", 1, false, "Williams", "fTZsmb0NgGS8EOfoF0sQ0F9pR7M=", "GTxGmBaI9/ioc94ljYuD9w==", "666666666", new DateTime(2025, 2, 11, 11, 51, 17, 881, DateTimeKind.Utc).AddTicks(1556), "bob.williams" },
                    { 7, "david.taylor@example.com", "David", 1, true, "Taylor", "hashedpassword7", "salt7", "9988776655", new DateTime(2025, 2, 11, 11, 51, 17, 881, DateTimeKind.Utc).AddTicks(1560), "david.taylor" },
                    { 8, "olivia.moore@example.com", "Olivia", 2, false, "Moore", "hashedpassword8", "salt8", "3344556677", new DateTime(2025, 2, 11, 11, 51, 17, 881, DateTimeKind.Utc).AddTicks(1564), "olivia.moore" }
                });

            migrationBuilder.InsertData(
                table: "Cars",
                columns: new[] { "CarId", "CarMakeId", "Color", "DriverId", "LicensePlateNumber", "YearOfManufacture" },
                values: new object[,]
                {
                    { 1, 1, "Red", 1, "ABC-123", 2015 },
                    { 2, 2, "Blue", 2, "DEF-456", 2018 },
                    { 3, 3, "Black", 3, "GHI-789", 2020 },
                    { 4, 4, "White", 4, "JKL-012", 2017 },
                    { 5, 5, "Gray", 5, "MNO-345", 2016 },
                    { 6, 6, "Silver", 6, "PQR-678", 2019 },
                    { 7, 7, "Green", 7, "STU-901", 2021 },
                    { 8, 8, "Yellow", 8, "VWX-234", 2014 }
                });

            migrationBuilder.InsertData(
                table: "MessageNotifications",
                columns: new[] { "MessageId", "MessageContent", "MessageDate", "ReceiverId", "SenderId" },
                values: new object[,]
                {
                    { 1, "Hi, are you available for a ride tomorrow?", new DateTime(2025, 2, 11, 10, 51, 17, 881, DateTimeKind.Local).AddTicks(2295), 2, 1 },
                    { 2, "Yes, I am. Let me know the time.", new DateTime(2025, 2, 11, 11, 21, 17, 881, DateTimeKind.Local).AddTicks(2301), 1, 2 },
                    { 3, "Can I bring a pet on this ride?", new DateTime(2025, 2, 11, 10, 51, 17, 881, DateTimeKind.Local).AddTicks(2305), 4, 3 },
                    { 4, "Yes, pets are allowed as long as they are well-behaved.", new DateTime(2025, 2, 11, 11, 51, 17, 881, DateTimeKind.Local).AddTicks(2309), 3, 4 },
                    { 5, "How many seats are available for this trip?", new DateTime(2025, 2, 10, 12, 51, 17, 881, DateTimeKind.Local).AddTicks(2313), 6, 5 },
                    { 6, "There are two seats available.", new DateTime(2025, 2, 9, 13, 51, 17, 881, DateTimeKind.Local).AddTicks(2317), 5, 6 },
                    { 7, "Is smoking allowed on this ride?", new DateTime(2025, 2, 9, 12, 51, 17, 881, DateTimeKind.Local).AddTicks(2321), 8, 7 },
                    { 8, "No, sorry, smoking is not allowed.", new DateTime(2025, 2, 8, 16, 51, 17, 881, DateTimeKind.Local).AddTicks(2325), 7, 8 },
                    { 9, "What time is the departure?", new DateTime(2025, 2, 11, 12, 6, 17, 881, DateTimeKind.Local).AddTicks(2330), 3, 1 },
                    { 10, "We’re leaving at 10:00 AM.", new DateTime(2025, 2, 11, 12, 21, 17, 881, DateTimeKind.Local).AddTicks(2334), 1, 3 },
                    { 11, "Will you stop for a break during the ride?", new DateTime(2025, 2, 11, 8, 51, 17, 881, DateTimeKind.Local).AddTicks(2338), 6, 2 },
                    { 12, "Yes, we’ll stop midway for a short break.", new DateTime(2025, 2, 11, 9, 51, 17, 881, DateTimeKind.Local).AddTicks(2342), 2, 6 },
                    { 13, "Can you confirm my booking?", new DateTime(2025, 2, 11, 6, 51, 17, 881, DateTimeKind.Local).AddTicks(2346), 8, 4 },
                    { 14, "Your booking has been confirmed.", new DateTime(2025, 2, 11, 7, 51, 17, 881, DateTimeKind.Local).AddTicks(2350), 4, 8 },
                    { 15, "Is it okay to bring a small bag?", new DateTime(2025, 2, 8, 10, 51, 17, 881, DateTimeKind.Local).AddTicks(2354), 7, 5 },
                    { 16, "Yes, no problem. See you soon!", new DateTime(2025, 2, 8, 11, 51, 17, 881, DateTimeKind.Local).AddTicks(2358), 5, 7 }
                });

            migrationBuilder.InsertData(
                table: "Preferences",
                columns: new[] { "PreferenceId", "AllowsMusic", "AllowsPets", "AllowsSmoking", "IsChatty", "UserId" },
                values: new object[,]
                {
                    { 1, "Prefer music!", "I love pets.", "No smoking!", "I'm chatty!", 1 },
                    { 2, "Prefer music!", "No pets allowed", "No smoking!", "I'm the quiet type", 2 },
                    { 3, "Prefer silence", "I love pets.", "No smoking!", "I'm chatty!", 3 },
                    { 4, "Prefer silence", "No pets allowed", "No smoking!", "I'm the quiet type", 4 },
                    { 5, "Prefer music!", "No pets allowed", "I'm fine with smoking", "I'm chatty!", 5 },
                    { 6, "Prefer silence", "I love pets.", "I'm fine with smoking", "I'm the quiet type", 6 },
                    { 7, "Prefer music!", "I love pets.", "No smoking!", "I'm chatty!", 7 },
                    { 8, "Prefer music!", "No pets allowed", "No smoking!", "I'm the quiet type", 8 }
                });

            migrationBuilder.InsertData(
                table: "Rides",
                columns: new[] { "RideId", "AvailableSeats", "DepartureDate", "DepartureLocationId", "DestinationLocationId", "Distance", "DriverId", "Duration", "Price", "RideStatus" },
                values: new object[,]
                {
                    { 1, 0, new DateTime(2025, 2, 1, 21, 51, 17, 881, DateTimeKind.Local).AddTicks(1908), 1, 2, 150.5, 1, 120.0, 25, "Archived" },
                    { 2, 1, new DateTime(2025, 2, 6, 20, 51, 17, 881, DateTimeKind.Local).AddTicks(1958), 3, 4, 200.30000000000001, 2, 150.0, 30, "Archived" },
                    { 3, 4, new DateTime(2025, 2, 15, 2, 51, 17, 881, DateTimeKind.Local).AddTicks(1965), 2, 5, 320.69999999999999, 3, 220.0, 50, "Scheduled" },
                    { 4, 0, new DateTime(2025, 2, 4, 22, 51, 17, 881, DateTimeKind.Local).AddTicks(1971), 6, 7, 120.0, 4, 90.0, 20, "Archived" },
                    { 5, 3, new DateTime(2025, 2, 16, 19, 51, 17, 881, DateTimeKind.Local).AddTicks(1978), 8, 1, 400.0, 5, 300.0, 60, "Scheduled" },
                    { 6, 4, new DateTime(2025, 2, 13, 4, 51, 17, 881, DateTimeKind.Local).AddTicks(1984), 3, 2, 180.0, 6, 130.0, 35, "Scheduled" },
                    { 7, 0, new DateTime(2025, 2, 3, 21, 51, 17, 881, DateTimeKind.Local).AddTicks(1990), 4, 6, 300.0, 7, 240.0, 45, "Archived" },
                    { 8, 0, new DateTime(2025, 2, 6, 0, 51, 17, 881, DateTimeKind.Local).AddTicks(1995), 5, 7, 220.0, 8, 180.0, 40, "Archived" },
                    { 9, 0, new DateTime(2025, 2, 8, 23, 51, 17, 881, DateTimeKind.Local).AddTicks(2001), 2, 6, 180.0, 2, 140.0, 35, "Archived" },
                    { 10, 2, new DateTime(2025, 2, 16, 1, 51, 17, 881, DateTimeKind.Local).AddTicks(2082), 3, 8, 250.0, 2, 180.0, 40, "Scheduled" },
                    { 11, 0, new DateTime(2025, 2, 3, 22, 51, 17, 881, DateTimeKind.Local).AddTicks(2088), 5, 1, 300.0, 2, 220.0, 45, "Archived" },
                    { 12, 4, new DateTime(2025, 2, 18, 3, 51, 17, 881, DateTimeKind.Local).AddTicks(2094), 6, 3, 280.0, 2, 200.0, 50, "Scheduled" },
                    { 13, 0, new DateTime(2025, 2, 7, 21, 51, 17, 881, DateTimeKind.Local).AddTicks(2100), 4, 2, 130.0, 2, 100.0, 30, "Archived" },
                    { 14, 3, new DateTime(2025, 2, 14, 5, 51, 17, 881, DateTimeKind.Local).AddTicks(2107), 7, 5, 260.0, 2, 190.0, 55, "Scheduled" },
                    { 15, 0, new DateTime(2025, 2, 5, 0, 51, 17, 881, DateTimeKind.Local).AddTicks(2112), 8, 6, 220.0, 2, 170.0, 40, "Archived" },
                    { 16, 2, new DateTime(2025, 2, 17, 2, 51, 17, 881, DateTimeKind.Local).AddTicks(2118), 3, 1, 310.0, 2, 230.0, 60, "Scheduled" }
                });

            migrationBuilder.InsertData(
                table: "UserRoles",
                columns: new[] { "UserRoleId", "RoleId", "UserId" },
                values: new object[,]
                {
                    { 1, 1, 1 },
                    { 2, 2, 2 },
                    { 3, 2, 3 },
                    { 4, 2, 4 },
                    { 5, 2, 5 },
                    { 6, 2, 6 },
                    { 7, 2, 7 },
                    { 8, 2, 8 }
                });

            migrationBuilder.InsertData(
                table: "Payments",
                columns: new[] { "PaymentId", "Amount", "PayerId", "PaymentDate", "PaymentMethod", "PaymentStatus", "RideId" },
                values: new object[,]
                {
                    { 1, 25.00m, 2, new DateTime(2025, 2, 2, 12, 51, 17, 881, DateTimeKind.Local).AddTicks(2166), "Stripe", "Completed", 1 },
                    { 2, 30.00m, 3, new DateTime(2025, 2, 7, 12, 51, 17, 881, DateTimeKind.Local).AddTicks(2173), "Stripe", "Completed", 2 },
                    { 3, 50.00m, 4, new DateTime(2025, 2, 11, 12, 51, 17, 881, DateTimeKind.Local).AddTicks(2178), "Cash", "Pending", 3 },
                    { 4, 20.00m, 5, new DateTime(2025, 2, 5, 12, 51, 17, 881, DateTimeKind.Local).AddTicks(2182), "Stripe", "Completed", 4 },
                    { 5, 35.00m, 3, new DateTime(2025, 2, 9, 12, 51, 17, 881, DateTimeKind.Local).AddTicks(2186), "Stripe", "Completed", 9 },
                    { 6, 45.00m, 4, new DateTime(2025, 2, 4, 12, 51, 17, 881, DateTimeKind.Local).AddTicks(2191), "Stripe", "Completed", 11 },
                    { 7, 40.00m, 5, new DateTime(2025, 2, 5, 12, 51, 17, 881, DateTimeKind.Local).AddTicks(2195), "Stripe", "Completed", 15 },
                    { 8, 60.00m, 6, new DateTime(2025, 2, 11, 12, 51, 17, 881, DateTimeKind.Local).AddTicks(2200), "Cash", "Pending", 16 }
                });

            migrationBuilder.InsertData(
                table: "ReviewRatings",
                columns: new[] { "ReviewId", "Comments", "DriverId", "Rating", "ReviewDate", "ReviewerId", "RideId" },
                values: new object[,]
                {
                    { 1, "Great driver! Very punctual and friendly.", 1, 5, new DateTime(2025, 2, 4, 12, 51, 17, 881, DateTimeKind.Local).AddTicks(2392), 2, 1 },
                    { 2, "Good ride, but the car could have been cleaner.", 3, 4, new DateTime(2025, 2, 5, 12, 51, 17, 881, DateTimeKind.Local).AddTicks(2398), 4, 3 },
                    { 3, "Smooth ride and friendly conversation.", 2, 5, new DateTime(2025, 2, 9, 12, 51, 17, 881, DateTimeKind.Local).AddTicks(2402), 3, 9 },
                    { 4, "Safe driving, but arrived slightly late.", 3, 4, new DateTime(2025, 2, 5, 12, 51, 17, 881, DateTimeKind.Local).AddTicks(2406), 2, 3 }
                });

            migrationBuilder.InsertData(
                table: "Bookings",
                columns: new[] { "BookingId", "BookingDate", "BookingStatus", "PassengerId", "PaymentId", "RideId" },
                values: new object[,]
                {
                    { 1, new DateTime(2025, 2, 2, 12, 51, 17, 881, DateTimeKind.Local).AddTicks(2232), "Completed", 2, 1, 1 },
                    { 2, new DateTime(2025, 2, 7, 12, 51, 17, 881, DateTimeKind.Local).AddTicks(2238), "Completed", 3, 2, 2 },
                    { 3, new DateTime(2025, 2, 11, 12, 51, 17, 881, DateTimeKind.Local).AddTicks(2242), "Pending", 4, 3, 3 },
                    { 4, new DateTime(2025, 2, 5, 12, 51, 17, 881, DateTimeKind.Local).AddTicks(2246), "Completed", 5, 4, 4 },
                    { 5, new DateTime(2025, 2, 9, 12, 51, 17, 881, DateTimeKind.Local).AddTicks(2250), "Completed", 3, 5, 9 },
                    { 6, new DateTime(2025, 2, 4, 12, 51, 17, 881, DateTimeKind.Local).AddTicks(2257), "Completed", 4, 6, 11 },
                    { 7, new DateTime(2025, 2, 5, 12, 51, 17, 881, DateTimeKind.Local).AddTicks(2261), "Completed", 5, 7, 15 },
                    { 8, new DateTime(2025, 2, 11, 12, 51, 17, 881, DateTimeKind.Local).AddTicks(2265), "Pending", 6, 8, 16 }
                });

            migrationBuilder.CreateIndex(
                name: "IX_Bookings_PassengerId",
                table: "Bookings",
                column: "PassengerId");

            migrationBuilder.CreateIndex(
                name: "IX_Bookings_PaymentId",
                table: "Bookings",
                column: "PaymentId");

            migrationBuilder.CreateIndex(
                name: "IX_Bookings_RideId",
                table: "Bookings",
                column: "RideId");

            migrationBuilder.CreateIndex(
                name: "IX_Cars_CarMakeId",
                table: "Cars",
                column: "CarMakeId");

            migrationBuilder.CreateIndex(
                name: "IX_Cars_DriverId",
                table: "Cars",
                column: "DriverId");

            migrationBuilder.CreateIndex(
                name: "IX_MessageNotifications_ReceiverId",
                table: "MessageNotifications",
                column: "ReceiverId");

            migrationBuilder.CreateIndex(
                name: "IX_MessageNotifications_SenderId",
                table: "MessageNotifications",
                column: "SenderId");

            migrationBuilder.CreateIndex(
                name: "IX_Payments_PayerId",
                table: "Payments",
                column: "PayerId");

            migrationBuilder.CreateIndex(
                name: "IX_Payments_RideId",
                table: "Payments",
                column: "RideId");

            migrationBuilder.CreateIndex(
                name: "IX_Preferences_UserId",
                table: "Preferences",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_ReviewRatings_DriverId",
                table: "ReviewRatings",
                column: "DriverId");

            migrationBuilder.CreateIndex(
                name: "IX_ReviewRatings_ReviewerId",
                table: "ReviewRatings",
                column: "ReviewerId");

            migrationBuilder.CreateIndex(
                name: "IX_ReviewRatings_RideId",
                table: "ReviewRatings",
                column: "RideId");

            migrationBuilder.CreateIndex(
                name: "IX_Rides_DepartureLocationId",
                table: "Rides",
                column: "DepartureLocationId");

            migrationBuilder.CreateIndex(
                name: "IX_Rides_DestinationLocationId",
                table: "Rides",
                column: "DestinationLocationId");

            migrationBuilder.CreateIndex(
                name: "IX_Rides_DriverId",
                table: "Rides",
                column: "DriverId");

            migrationBuilder.CreateIndex(
                name: "IX_UserRoles_RoleId",
                table: "UserRoles",
                column: "RoleId");

            migrationBuilder.CreateIndex(
                name: "IX_UserRoles_UserId",
                table: "UserRoles",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Users_GenderId",
                table: "Users",
                column: "GenderId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Bookings");

            migrationBuilder.DropTable(
                name: "Cars");

            migrationBuilder.DropTable(
                name: "MessageNotifications");

            migrationBuilder.DropTable(
                name: "Preferences");

            migrationBuilder.DropTable(
                name: "ReviewRatings");

            migrationBuilder.DropTable(
                name: "UserRoles");

            migrationBuilder.DropTable(
                name: "Payments");

            migrationBuilder.DropTable(
                name: "CarMakes");

            migrationBuilder.DropTable(
                name: "Roles");

            migrationBuilder.DropTable(
                name: "Rides");

            migrationBuilder.DropTable(
                name: "Locations");

            migrationBuilder.DropTable(
                name: "Users");

            migrationBuilder.DropTable(
                name: "Genders");
        }
    }
}

using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace hajUsput.Services.Migrations
{
    /// <inheritdoc />
    public partial class distdur : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<double>(
                name: "Distance",
                table: "Rides",
                type: "float",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<double>(
                name: "Duration",
                table: "Rides",
                type: "float",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.UpdateData(
                table: "Bookings",
                keyColumn: "BookingId",
                keyValue: 1,
                column: "BookingDate",
                value: new DateTime(2024, 7, 22, 16, 21, 25, 219, DateTimeKind.Local).AddTicks(4845));

            migrationBuilder.UpdateData(
                table: "Locations",
                keyColumn: "LocationId",
                keyValue: 1,
                columns: new[] { "City", "Country" },
                values: new object[] { "Frankfurt", "Germany" });

            migrationBuilder.UpdateData(
                table: "Locations",
                keyColumn: "LocationId",
                keyValue: 2,
                columns: new[] { "City", "Country" },
                values: new object[] { "Tuzla", "BiH" });

            migrationBuilder.UpdateData(
                table: "MessageNotifications",
                keyColumn: "MessageId",
                keyValue: 1,
                column: "MessageDate",
                value: new DateTime(2024, 7, 22, 16, 21, 25, 219, DateTimeKind.Local).AddTicks(5032));

            migrationBuilder.UpdateData(
                table: "Payments",
                keyColumn: "PaymentId",
                keyValue: 1,
                column: "PaymentDate",
                value: new DateTime(2024, 7, 22, 16, 21, 25, 219, DateTimeKind.Local).AddTicks(4908));

            migrationBuilder.UpdateData(
                table: "ReviewRatings",
                keyColumn: "ReviewId",
                keyValue: 1,
                column: "ReviewDate",
                value: new DateTime(2024, 7, 22, 16, 21, 25, 219, DateTimeKind.Local).AddTicks(4972));

            migrationBuilder.UpdateData(
                table: "Rides",
                keyColumn: "RideId",
                keyValue: 1,
                columns: new[] { "DepartureDate", "Distance", "Duration" },
                values: new object[] { new DateTime(2024, 7, 22, 16, 21, 25, 219, DateTimeKind.Local).AddTicks(4790), 0.0, 0.0 });

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "UserId",
                keyValue: 1,
                column: "RegistrationDate",
                value: new DateTime(2024, 7, 22, 16, 21, 25, 219, DateTimeKind.Local).AddTicks(4336));

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "UserId",
                keyValue: 2,
                column: "RegistrationDate",
                value: new DateTime(2024, 7, 22, 16, 21, 25, 219, DateTimeKind.Local).AddTicks(4596));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Distance",
                table: "Rides");

            migrationBuilder.DropColumn(
                name: "Duration",
                table: "Rides");

            migrationBuilder.UpdateData(
                table: "Bookings",
                keyColumn: "BookingId",
                keyValue: 1,
                column: "BookingDate",
                value: new DateTime(2024, 7, 3, 20, 46, 19, 466, DateTimeKind.Local).AddTicks(5325));

            migrationBuilder.UpdateData(
                table: "Locations",
                keyColumn: "LocationId",
                keyValue: 1,
                columns: new[] { "City", "Country" },
                values: new object[] { "New York", "USA" });

            migrationBuilder.UpdateData(
                table: "Locations",
                keyColumn: "LocationId",
                keyValue: 2,
                columns: new[] { "City", "Country" },
                values: new object[] { "Los Angeles", "USA" });

            migrationBuilder.UpdateData(
                table: "MessageNotifications",
                keyColumn: "MessageId",
                keyValue: 1,
                column: "MessageDate",
                value: new DateTime(2024, 7, 3, 20, 46, 19, 466, DateTimeKind.Local).AddTicks(5773));

            migrationBuilder.UpdateData(
                table: "Payments",
                keyColumn: "PaymentId",
                keyValue: 1,
                column: "PaymentDate",
                value: new DateTime(2024, 7, 3, 20, 46, 19, 466, DateTimeKind.Local).AddTicks(5427));

            migrationBuilder.UpdateData(
                table: "ReviewRatings",
                keyColumn: "ReviewId",
                keyValue: 1,
                column: "ReviewDate",
                value: new DateTime(2024, 7, 3, 20, 46, 19, 466, DateTimeKind.Local).AddTicks(5662));

            migrationBuilder.UpdateData(
                table: "Rides",
                keyColumn: "RideId",
                keyValue: 1,
                column: "DepartureDate",
                value: new DateTime(2024, 7, 3, 20, 46, 19, 466, DateTimeKind.Local).AddTicks(4827));

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "UserId",
                keyValue: 1,
                column: "RegistrationDate",
                value: new DateTime(2024, 7, 3, 20, 46, 19, 466, DateTimeKind.Local).AddTicks(4625));

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "UserId",
                keyValue: 2,
                column: "RegistrationDate",
                value: new DateTime(2024, 7, 3, 20, 46, 19, 466, DateTimeKind.Local).AddTicks(4694));
        }
    }
}

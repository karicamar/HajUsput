using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace hajUsput.Services.Migrations
{
    /// <inheritdoc />
    public partial class droppref : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Bookings",
                keyColumn: "BookingId",
                keyValue: 1,
                column: "BookingDate",
                value: new DateTime(2024, 8, 19, 15, 2, 8, 484, DateTimeKind.Local).AddTicks(5643));

            migrationBuilder.UpdateData(
                table: "MessageNotifications",
                keyColumn: "MessageId",
                keyValue: 1,
                column: "MessageDate",
                value: new DateTime(2024, 8, 19, 15, 2, 8, 484, DateTimeKind.Local).AddTicks(5729));

            migrationBuilder.UpdateData(
                table: "Payments",
                keyColumn: "PaymentId",
                keyValue: 1,
                column: "PaymentDate",
                value: new DateTime(2024, 8, 19, 15, 2, 8, 484, DateTimeKind.Local).AddTicks(5677));

            migrationBuilder.UpdateData(
                table: "ReviewRatings",
                keyColumn: "ReviewId",
                keyValue: 1,
                column: "ReviewDate",
                value: new DateTime(2024, 8, 19, 15, 2, 8, 484, DateTimeKind.Local).AddTicks(5702));

            migrationBuilder.UpdateData(
                table: "Rides",
                keyColumn: "RideId",
                keyValue: 1,
                column: "DepartureDate",
                value: new DateTime(2024, 8, 19, 15, 2, 8, 484, DateTimeKind.Local).AddTicks(5616));

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "UserId",
                keyValue: 1,
                column: "RegistrationDate",
                value: new DateTime(2024, 8, 19, 15, 2, 8, 484, DateTimeKind.Local).AddTicks(5462));

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "UserId",
                keyValue: 2,
                column: "RegistrationDate",
                value: new DateTime(2024, 8, 19, 15, 2, 8, 484, DateTimeKind.Local).AddTicks(5518));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Bookings",
                keyColumn: "BookingId",
                keyValue: 1,
                column: "BookingDate",
                value: new DateTime(2024, 8, 17, 12, 29, 42, 703, DateTimeKind.Local).AddTicks(2314));

            migrationBuilder.UpdateData(
                table: "MessageNotifications",
                keyColumn: "MessageId",
                keyValue: 1,
                column: "MessageDate",
                value: new DateTime(2024, 8, 17, 12, 29, 42, 703, DateTimeKind.Local).AddTicks(2417));

            migrationBuilder.UpdateData(
                table: "Payments",
                keyColumn: "PaymentId",
                keyValue: 1,
                column: "PaymentDate",
                value: new DateTime(2024, 8, 17, 12, 29, 42, 703, DateTimeKind.Local).AddTicks(2363));

            migrationBuilder.UpdateData(
                table: "ReviewRatings",
                keyColumn: "ReviewId",
                keyValue: 1,
                column: "ReviewDate",
                value: new DateTime(2024, 8, 17, 12, 29, 42, 703, DateTimeKind.Local).AddTicks(2389));

            migrationBuilder.UpdateData(
                table: "Rides",
                keyColumn: "RideId",
                keyValue: 1,
                column: "DepartureDate",
                value: new DateTime(2024, 8, 17, 12, 29, 42, 703, DateTimeKind.Local).AddTicks(2287));

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "UserId",
                keyValue: 1,
                column: "RegistrationDate",
                value: new DateTime(2024, 8, 17, 12, 29, 42, 703, DateTimeKind.Local).AddTicks(2133));

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "UserId",
                keyValue: 2,
                column: "RegistrationDate",
                value: new DateTime(2024, 8, 17, 12, 29, 42, 703, DateTimeKind.Local).AddTicks(2190));
        }
    }
}

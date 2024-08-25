using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace hajUsput.Services.Migrations
{
    /// <inheritdoc />
    public partial class rw : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK__ReviewRat__RideI__4F7CD00D",
                table: "ReviewRatings");

            migrationBuilder.AddColumn<int>(
                name: "DriverId",
                table: "ReviewRatings",
                type: "int",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Bookings",
                keyColumn: "BookingId",
                keyValue: 1,
                column: "BookingDate",
                value: new DateTime(2024, 8, 2, 0, 0, 24, 217, DateTimeKind.Local).AddTicks(5514));

            migrationBuilder.UpdateData(
                table: "MessageNotifications",
                keyColumn: "MessageId",
                keyValue: 1,
                column: "MessageDate",
                value: new DateTime(2024, 8, 2, 0, 0, 24, 217, DateTimeKind.Local).AddTicks(5716));

            migrationBuilder.UpdateData(
                table: "Payments",
                keyColumn: "PaymentId",
                keyValue: 1,
                column: "PaymentDate",
                value: new DateTime(2024, 8, 2, 0, 0, 24, 217, DateTimeKind.Local).AddTicks(5580));

            migrationBuilder.UpdateData(
                table: "ReviewRatings",
                keyColumn: "ReviewId",
                keyValue: 1,
                columns: new[] { "DriverId", "ReviewDate", "RideId" },
                values: new object[] { 4, new DateTime(2024, 8, 2, 0, 0, 24, 217, DateTimeKind.Local).AddTicks(5652), null });

            migrationBuilder.UpdateData(
                table: "Rides",
                keyColumn: "RideId",
                keyValue: 1,
                column: "DepartureDate",
                value: new DateTime(2024, 8, 2, 0, 0, 24, 217, DateTimeKind.Local).AddTicks(5330));

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "UserId",
                keyValue: 1,
                column: "RegistrationDate",
                value: new DateTime(2024, 8, 2, 0, 0, 24, 217, DateTimeKind.Local).AddTicks(5044));

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "UserId",
                keyValue: 2,
                column: "RegistrationDate",
                value: new DateTime(2024, 8, 2, 0, 0, 24, 217, DateTimeKind.Local).AddTicks(5136));

            migrationBuilder.CreateIndex(
                name: "IX_ReviewRatings_DriverId",
                table: "ReviewRatings",
                column: "DriverId");

            migrationBuilder.AddForeignKey(
                name: "FK_ReviewRatings_Rides_RideId",
                table: "ReviewRatings",
                column: "RideId",
                principalTable: "Rides",
                principalColumn: "RideId");

            migrationBuilder.AddForeignKey(
                name: "FK_ReviewRatings_Users_DriverId",
                table: "ReviewRatings",
                column: "DriverId",
                principalTable: "Users",
                principalColumn: "UserId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ReviewRatings_Rides_RideId",
                table: "ReviewRatings");

            migrationBuilder.DropForeignKey(
                name: "FK_ReviewRatings_Users_DriverId",
                table: "ReviewRatings");

            migrationBuilder.DropIndex(
                name: "IX_ReviewRatings_DriverId",
                table: "ReviewRatings");

            migrationBuilder.DropColumn(
                name: "DriverId",
                table: "ReviewRatings");

            migrationBuilder.UpdateData(
                table: "Bookings",
                keyColumn: "BookingId",
                keyValue: 1,
                column: "BookingDate",
                value: new DateTime(2024, 7, 22, 16, 21, 25, 219, DateTimeKind.Local).AddTicks(4845));

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
                columns: new[] { "ReviewDate", "RideId" },
                values: new object[] { new DateTime(2024, 7, 22, 16, 21, 25, 219, DateTimeKind.Local).AddTicks(4972), 1 });

            migrationBuilder.UpdateData(
                table: "Rides",
                keyColumn: "RideId",
                keyValue: 1,
                column: "DepartureDate",
                value: new DateTime(2024, 7, 22, 16, 21, 25, 219, DateTimeKind.Local).AddTicks(4790));

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

            migrationBuilder.AddForeignKey(
                name: "FK__ReviewRat__RideI__4F7CD00D",
                table: "ReviewRatings",
                column: "RideId",
                principalTable: "Rides",
                principalColumn: "RideId");
        }
    }
}

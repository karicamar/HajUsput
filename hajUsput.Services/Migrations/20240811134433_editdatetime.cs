using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace hajUsput.Services.Migrations
{
    /// <inheritdoc />
    public partial class editdatetime : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "RegistrationDate",
                table: "Users",
                type: "date",
                nullable: true,
                oldClrType: typeof(DateTime),
                oldType: "datetime",
                oldNullable: true);

            migrationBuilder.AlterColumn<DateTime>(
                name: "DepartureDate",
                table: "Rides",
                type: "date",
                nullable: false,
                oldClrType: typeof(DateTime),
                oldType: "datetime");

            migrationBuilder.AlterColumn<DateTime>(
                name: "ReviewDate",
                table: "ReviewRatings",
                type: "date",
                nullable: true,
                oldClrType: typeof(DateTime),
                oldType: "datetime",
                oldNullable: true);

            migrationBuilder.AlterColumn<DateTime>(
                name: "PaymentDate",
                table: "Payments",
                type: "date",
                nullable: true,
                oldClrType: typeof(DateTime),
                oldType: "datetime",
                oldNullable: true);

            migrationBuilder.AlterColumn<DateTime>(
                name: "BookingDate",
                table: "Bookings",
                type: "date",
                nullable: true,
                oldClrType: typeof(DateTime),
                oldType: "datetime",
                oldNullable: true);

            migrationBuilder.UpdateData(
                table: "Bookings",
                keyColumn: "BookingId",
                keyValue: 1,
                column: "BookingDate",
                value: new DateTime(2024, 8, 11, 15, 44, 32, 551, DateTimeKind.Local).AddTicks(5373));

            migrationBuilder.UpdateData(
                table: "MessageNotifications",
                keyColumn: "MessageId",
                keyValue: 1,
                column: "MessageDate",
                value: new DateTime(2024, 8, 11, 15, 44, 32, 551, DateTimeKind.Local).AddTicks(5460));

            migrationBuilder.UpdateData(
                table: "Payments",
                keyColumn: "PaymentId",
                keyValue: 1,
                column: "PaymentDate",
                value: new DateTime(2024, 8, 11, 15, 44, 32, 551, DateTimeKind.Local).AddTicks(5407));

            migrationBuilder.UpdateData(
                table: "ReviewRatings",
                keyColumn: "ReviewId",
                keyValue: 1,
                column: "ReviewDate",
                value: new DateTime(2024, 8, 11, 15, 44, 32, 551, DateTimeKind.Local).AddTicks(5434));

            migrationBuilder.UpdateData(
                table: "Rides",
                keyColumn: "RideId",
                keyValue: 1,
                column: "DepartureDate",
                value: new DateTime(2024, 8, 11, 15, 44, 32, 551, DateTimeKind.Local).AddTicks(5336));

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "UserId",
                keyValue: 1,
                column: "RegistrationDate",
                value: new DateTime(2024, 8, 11, 15, 44, 32, 551, DateTimeKind.Local).AddTicks(5085));

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "UserId",
                keyValue: 2,
                column: "RegistrationDate",
                value: new DateTime(2024, 8, 11, 15, 44, 32, 551, DateTimeKind.Local).AddTicks(5137));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "RegistrationDate",
                table: "Users",
                type: "datetime",
                nullable: true,
                oldClrType: typeof(DateTime),
                oldType: "date",
                oldNullable: true);

            migrationBuilder.AlterColumn<DateTime>(
                name: "DepartureDate",
                table: "Rides",
                type: "datetime",
                nullable: false,
                oldClrType: typeof(DateTime),
                oldType: "date");

            migrationBuilder.AlterColumn<DateTime>(
                name: "ReviewDate",
                table: "ReviewRatings",
                type: "datetime",
                nullable: true,
                oldClrType: typeof(DateTime),
                oldType: "date",
                oldNullable: true);

            migrationBuilder.AlterColumn<DateTime>(
                name: "PaymentDate",
                table: "Payments",
                type: "datetime",
                nullable: true,
                oldClrType: typeof(DateTime),
                oldType: "date",
                oldNullable: true);

            migrationBuilder.AlterColumn<DateTime>(
                name: "BookingDate",
                table: "Bookings",
                type: "datetime",
                nullable: true,
                oldClrType: typeof(DateTime),
                oldType: "date",
                oldNullable: true);

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
                column: "ReviewDate",
                value: new DateTime(2024, 8, 2, 0, 0, 24, 217, DateTimeKind.Local).AddTicks(5652));

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
        }
    }
}

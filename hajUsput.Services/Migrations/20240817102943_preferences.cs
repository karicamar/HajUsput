using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace hajUsput.Services.Migrations
{
    /// <inheritdoc />
    public partial class preferences : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
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

            migrationBuilder.CreateIndex(
                name: "IX_Preferences_UserId",
                table: "Preferences",
                column: "UserId",
                unique: true,
                filter: "[UserId] IS NOT NULL");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Preferences");

            migrationBuilder.UpdateData(
                table: "Bookings",
                keyColumn: "BookingId",
                keyValue: 1,
                column: "BookingDate",
                value: new DateTime(2024, 8, 14, 0, 54, 43, 932, DateTimeKind.Local).AddTicks(153));

            migrationBuilder.UpdateData(
                table: "MessageNotifications",
                keyColumn: "MessageId",
                keyValue: 1,
                column: "MessageDate",
                value: new DateTime(2024, 8, 14, 0, 54, 43, 932, DateTimeKind.Local).AddTicks(311));

            migrationBuilder.UpdateData(
                table: "Payments",
                keyColumn: "PaymentId",
                keyValue: 1,
                column: "PaymentDate",
                value: new DateTime(2024, 8, 14, 0, 54, 43, 932, DateTimeKind.Local).AddTicks(206));

            migrationBuilder.UpdateData(
                table: "ReviewRatings",
                keyColumn: "ReviewId",
                keyValue: 1,
                column: "ReviewDate",
                value: new DateTime(2024, 8, 14, 0, 54, 43, 932, DateTimeKind.Local).AddTicks(258));

            migrationBuilder.UpdateData(
                table: "Rides",
                keyColumn: "RideId",
                keyValue: 1,
                column: "DepartureDate",
                value: new DateTime(2024, 8, 14, 0, 54, 43, 932, DateTimeKind.Local).AddTicks(102));

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "UserId",
                keyValue: 1,
                column: "RegistrationDate",
                value: new DateTime(2024, 8, 14, 0, 54, 43, 931, DateTimeKind.Local).AddTicks(9725));

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "UserId",
                keyValue: 2,
                column: "RegistrationDate",
                value: new DateTime(2024, 8, 14, 0, 54, 43, 931, DateTimeKind.Local).AddTicks(9923));
        }
    }
}

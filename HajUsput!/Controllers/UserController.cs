
using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;
using hajUsput.Services;
using hajUsput.Services.Database;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Stripe;
using User = hajUsput.Model.User;

namespace HajUsput_.Controllers
{
    [ApiController]
    [Route("[controller]")]
    [Authorize(Roles = "User,Admin")]

    public class UserController : BaseCRUDController<User, hajUsput.Model.SearchObjects.UserSearchObject, hajUsput.Model.Requests.UserInsertRequest, hajUsput.Model.Requests.UserUpdateRequest>

    {
        private readonly IUserService _userService;
        public UserController(ILogger<BaseController<User, hajUsput.Model.SearchObjects.UserSearchObject>> logger, IUserService service) : base(logger,service)
        {
            _userService = service;

        }

        [AllowAnonymous]
        public override Task<User> Insert(UserInsertRequest request)
        {
            return base.Insert(request);
        }
        [HttpPut("Block/{id}")]
        public virtual async Task<User> Block(int id)
        {
            return await (_service as IUserService).Block(id);
        }

        [HttpPost("login")]
        [AllowAnonymous]
        public async Task<IActionResult> Login([FromBody] LoginRequest request)
        {
            var user = await _userService.Login(request.Username, request.Password);
            if (user == null) return Unauthorized();

            return Ok(new { UserId = user.UserId /* other user details */ });
        }


        [HttpPost("checkEmail")]
        [AllowAnonymous]

        public async Task<IActionResult> CheckEmail([FromBody] string email)
        {
            var exists = await _userService.EmailExists(email);
            return Ok(new { exists });
        }

        [HttpPost("checkUsername")]
        [AllowAnonymous]

        public async Task<IActionResult> CheckUsername([FromBody] string username)
        {
            var exists = await _userService.UsernameExists(username);
            return Ok(new { exists });
        }
        // GET: api/User/{userId}/preferences
        [HttpGet("{userId}/preferences")]
        public async Task<IActionResult> GetPreferences(int userId)
        {
            var preferences = await _userService.GetPreferences(userId);
            if (preferences == null)
            {
                return NotFound(new { Message = "Preferences not found." });
            }
            return Ok(preferences);
        }

        // PUT: api/User/{userId}/preferences
        [HttpPut("{userId}/preferences")]
        public async Task<IActionResult> UpdatePreferences(int userId, PreferenceUpsertRequest request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                var updatedPreferences = await _userService.UpdatePreferences(userId, request);
                return Ok(updatedPreferences);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { Message = "An error occurred while updating preferences.", Detail = ex.Message });
            }
        }
        [HttpPost("change-password")]
        public async Task<IActionResult> ChangePassword([FromBody] ChangePasswordRequest request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var result = await _userService.ChangePassword(request.UserId, request.OldPassword, request.NewPassword);

            if (!result)
            {
                return BadRequest("Password change failed. Please check your current password and try again.");
            }

            return Ok("Password changed successfully.");
        }
        [HttpGet("total-users")]
        public async Task<int> GetTotalUsers()
        {
            var totalUsers = await _userService.GetTotalUsersAsync();
            return totalUsers;
        }
    }
}

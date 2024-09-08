



using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;

namespace hajUsput.Services
{
    public interface IUserService :  ICRUDService<User, UserSearchObject, UserInsertRequest, UserUpdateRequest>

    {
        Task<bool> EmailExists(string email);
        Task<bool> UsernameExists(string username);
        public Task<Model.User> Login(string username, string password);

        public Task<Model.User> Block(int id);
        public Task<Model.Preference> GetPreferences(int userId);
        public Task<Model.Preference> UpdatePreferences(int userId, PreferenceUpsertRequest request);
        public Task<bool> ChangePassword(int userId, string oldPassword, string newPassword);
        public Task<int> GetTotalUsersAsync();


    }
}
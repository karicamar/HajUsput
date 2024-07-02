



using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;

namespace hajUsput.Services
{
    public interface IUserService :  ICRUDService<User, UserSearchObject, UserInsertRequest, UserUpdateRequest>

    {
        // Model.User Login(string username, string password);
        public Task<Model.User> Login(string username, string password);

        public Task<Model.User> Block(int id);

    }
}
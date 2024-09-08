



using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;

namespace hajUsput.Services
{
    public interface ICarService :  ICRUDService<Car, CarSearchObject, CarInsertRequest, CarUpdateRequest>

    {


        public Car GetCarsByUserId(int userId);




    }
}
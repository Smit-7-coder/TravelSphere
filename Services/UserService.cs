using TravelSphere.DAL;
using TravelSphere.Helpers;
using TravelSphere.Models;

namespace TravelSphere.Services
{
    public class UserService
    {
        private readonly UserRepository userRepository;

        public UserService()
        {
            userRepository = new UserRepository();
        }

        public string Register(User user)
        {
            // Check whether email already exists
            if (userRepository.EmailExists(user.Email))
            {
                return "Email already registered.";
            }

            // Convert plain password into BCrypt hash
            user.Password = PasswordHelper.HashPassword(user.Password);

            // Save user
            bool result = userRepository.RegisterUser(user);

            if (result)
            {
                return "Registration Successful";
            }

            return "Registration Failed";
        }
    }
}